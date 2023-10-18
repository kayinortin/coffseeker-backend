import express from 'express'
const router = express.Router()
import pool from '../config/db.js'

import { readJsonFile } from '../utils/json-tool.js'

import {
  getNews,
  getNewsWithQS,
  getNewsById,
  countWithQS,
} from '../models/news.js'

// 專用處理SQL字串的工具，主要format與escape，防止SQL注入
import sqlString from 'sqlstring'
import { body } from 'express-validator'

// 獲得所有資料，加入分頁與搜尋字串功能，單一資料表處理
// products/qs?page=1&keyword=xxxx&cat_ids=1,2&sizes=1,2&tags=3,4&colors=1,2,3&orderby=id,asc&perpage=10&price_range=1500,10000
router.get('/qs', async (req, res, next) => {
  // 獲取網頁的搜尋字串
  const {
    page,
    keyword,
    cat_ids,
    colors,
    tags,
    sizes,
    orderby,
    perpage,
    price_range,
  } = req.query

  // TODO: 這裡可以檢查各query string正確性或給預設值，檢查不足可能會產生查詢錯誤

  // 建立資料庫搜尋條件
  const conditions = []

  // 關鍵字 keyword 使用 `name LIKE '%keyword%'`
  conditions[0] = keyword
    ? `name LIKE ${sqlString.escape('%' + keyword + '%')}`
    : ''

  // 分類，cat_id 使用 `cat_id IN (1, 2, 3, 4, 5)`
  conditions[1] = cat_ids ? `cat_id IN (${cat_ids})` : ''

  // 顏色: FIND_IN_SET(1, color) OR FIND_IN_SET(2, color)
  const color_ids = colors ? colors.split(',') : []
  conditions[2] = color_ids
    .map((v) => `FIND_IN_SET(${Number(v)}, color)`)
    .join(' OR ')

  //  標籤: FIND_IN_SET(3, tag) OR FIND_IN_SET(2, tag)
  const tag_ids = tags ? tags.split(',') : []
  conditions[3] = tag_ids
    .map((v) => `FIND_IN_SET(${Number(v)}, tag)`)
    .join(' OR ')

  //  尺寸: FIND_IN_SET(3, size) OR FIND_IN_SET(2, size)
  const size_ids = sizes ? sizes.split(',') : []
  conditions[4] = size_ids
    .map((v) => `FIND_IN_SET(${Number(v)}, size)`)
    .join(' OR ')

  // 價格
  const priceRanges = price_range ? price_range.split(',') : []
  const min = Number(priceRanges[0])
  const max = Number(priceRanges[1])
  // 價格要介於1500~10000間
  if (min >= 1500 && max <= 10000) {
    conditions[5] = `price BETWEEN ${min} AND ${max}`
  }

  //各條件為AND相接(不存在時不加入where從句中)
  const conditionsValues = conditions.filter((v) => v)

  // 各條件需要先包含在`()`中，因各自內查詢是OR, 與其它的是AND
  const where =
    conditionsValues.length > 0
      ? `WHERE ` + conditionsValues.map((v) => `( ${v} )`).join(' AND ')
      : ''

  // 分頁用
  // page預設為1，perpage預設為10
  const perpageNow = Number(perpage) || 10
  const pageNow = Number(page) || 1
  const limit = perpageNow
  // page=1 offset=0 ; page=2 offset= perpage * 1; ...
  const offset = (pageNow - 1) * perpageNow

  // 排序用，預設使用id, asc
  const order = orderby
    ? { [orderby.split(',')[0]]: orderby.split(',')[1] }
    : { id: 'asc' }

  // 查詢
  const total = await countWithQS(where)
  const news = await getNewsWithQS(where, order, limit, offset)

  // json回傳範例
  //
  // {
  //   total: 100,
  //   perpage: 10,
  //   page: 1,
  //   data:[
  //     {id:123, name:'',...},
  //     {id:123, name:'',...}
  //   ]
  // }

  const result = {
    total,
    perpage: Number(perpage),
    page: Number(page),
    data: news,
  }

  res.json(result)
})

router.get('/', async (req, res, next) => {
  // 讀取所有新聞資料
  const allNews = await getNews()

  // 分頁相關變數
  const perpage = Number(req.query.perpage) || 6 // 每頁顯示的新聞數
  const page = Number(req.query.page) || 1 // 當前頁數

  // 計算 limit 和 offset
  const limit = perpage
  const offset = (page - 1) * perpage

  // 獲取前端傳遞的排序參數
  const sortBy = req.query.sortBy || 'date'

  // 自訂排序函數
  function myOwnSort(sortBy, items) {
    if (sortBy === 'popular') {
      // 按照熱門程度排序
      return items.slice().sort((a, b) => b.views - a.views)
    } else if (sortBy === 'oldest') {
      // 按照日期從舊到新排序
      return items
        .slice()
        .sort((a, b) => new Date(a.created_at) - new Date(b.created_at))
    } else {
      // 默認排序，日期從新到舊排序
      return items
        .slice()
        .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
    }
  }

  // 在前端選擇排序後，對所有新聞資料進行排序
  const sortedNews = myOwnSort(sortBy, allNews)
  // console.log(sortedNews)

  // 從排序後的資料中切割出當前頁面應該顯示的新聞
  const news = sortedNews.slice(offset, offset + perpage)
  const totalPages = Math.ceil(allNews.length / perpage) // 計算總頁數
  // console.log(allNews.length)

  return res.json({
    message: '成功',
    code: '200',
    news,
    currentPage: page,
    totalPages,
  })
})

// 設定分類新聞的路由
router.get('/category/:cid', async (req, res, next) => {
  try {
    const cid = req.params.cid

    // 確保 cid 是一個有效的數字值
    if (isNaN(parseInt(cid))) {
      return res.status(400).json({ error: '無效的 cid' })
    }

    // 使用分頁相關變數
    const perpageNow = Number(req.query.perpage) || 6 // 每頁顯示的消息數
    const pageNow = Number(req.query.page) || 1 // 當前頁數

    // 計算偏移量
    const offset = (pageNow - 1) * perpageNow

    let categoryId = 0 // 預設的 category_id

    // 根據不同的 cid 值設定 categoryId
    switch (cid) {
      case '1':
        categoryId = 1
        break
      case '2':
        categoryId = 2
        break
      case '3':
        categoryId = 3
        break
      default:
        categoryId = 0
        break
    }

    if (categoryId === 0) {
      return res.status(404).json({ error: '找不到相應分類的消息' })
    }

    // SQL 查詢，不包括分頁邏輯
    const query = `
      SELECT * FROM news 
      WHERE category_id = ?
    `

    const [rows, fields] = await pool.execute(query, [categoryId])

    // 檢查是否找到相應分類的消息
    if (rows.length === 0) {
      return res.status(404).json({ error: '找不到相應分類的消息' })
    }

    // 排序這些資料，按照你的需求
    rows.sort((a, b) => {
      return new Date(b.created_at) - new Date(a.created_at)
    })

    // 計算總頁數
    const totalRows = rows.length
    const totalPages = Math.ceil(totalRows / perpageNow)

    // 切分分頁
    const pageNews = rows.slice(offset, offset + perpageNow)

    // 返回包含新聞和總頁數的 JSON
    res.json({ news: pageNews, totalPages })
  } catch (error) {
    console.error('資料獲取失敗:', error.message)
    res.status(500).json({ error: '資料獲取失敗，請重試。' })
  }
})

//領取優惠券區
router.get('/coupons', async (req, res, next) => {
  try {
    const query = 'SELECT * FROM user_coupon WHERE coupon_valid = 1 '
    const [rows, fields] = await pool.execute(query)
    res.json(rows)
  } catch (error) {
    console.error('優惠券獲取失敗:', error.message)
    res.status(500).json({ error: '優惠券獲取失敗，請重試。' })
  }
})

// 更新會員領取優惠券
router.post('/addCoupon', async (req, res) => {
  const { couponId, userId } = req.body

  if (userId !== undefined && couponId !== undefined) {
    try {
      // 檢查該優惠券是否已被領取
      const checkUserCouponQuery = `
        SELECT user_id, coupon_record
        FROM coupon
        WHERE user_id = ? AND coupon_record = ?
      `
      const [userCouponRows, userCouponFields] = await pool.execute(
        checkUserCouponQuery,
        [userId, couponId]
      )

      if (userCouponRows.length > 0) {
        return res.status(400).json({ message: '會員已經領取過相同的優惠券' })
      }

      // 取得優惠券的詳細資訊
      const getCouponInfoQuery = 'SELECT * FROM user_coupon WHERE coupon_id = ?'
      const [couponInfoRows, couponInfoFields] = await pool.execute(
        getCouponInfoQuery,
        [couponId]
      )

      if (couponInfoRows.length === 0) {
        return res.status(404).json({ message: '優惠券不存在' })
      }

      // 插入優惠券到coupon資料表，並記錄到coupon_record欄位
      const insertCouponQuery = `
        INSERT INTO coupon (
          coupon_name,
          coupon_code,
          coupon_valid,
          valid_description,
          discount_type,
          discount_value,
          start_at,
          expires_at,
          created_at,
          updated_at,
          max_usage,
          used_times,
          price_min,
          usage_restriction,
          user_id,
          coupon_record
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `

      const couponInfo = couponInfoRows[0]

      const insertCouponValues = [
        couponInfo.coupon_name,
        couponInfo.coupon_code,
        couponInfo.coupon_valid,
        couponInfo.valid_description,
        couponInfo.discount_type,
        couponInfo.discount_value,
        couponInfo.start_at,
        couponInfo.expires_at,
        couponInfo.created_at,
        couponInfo.updated_at,
        couponInfo.max_usage,
        couponInfo.used_times,
        couponInfo.price_min,
        couponInfo.usage_restriction,
        userId,
        couponId, // 將coupon_id插入coupon_record欄位
      ]

      // 執行插入操作
      await pool.execute(insertCouponQuery, insertCouponValues)

      return res.json({ message: '成功領取優惠券' })
    } catch (error) {
      console.error('資料庫更新失败:', error.message)
      return res.status(500).json({ message: '資料庫更新失败' })
    }
  } else {
    res.status(400).json({ message: 'userId 和 couponId 必須提供' })
  }
})

// 獲得單筆消息
router.get('/:nid', async (req, res, next) => {
  try {
    const nid = req.params.nid

    // 確保 nid 是一個有效的數字值
    if (isNaN(parseInt(nid))) {
      throw new Error('無效的 nid')
    }

    //news資料表查詢
    const query = 'SELECT * FROM news WHERE news_id = ?'
    const [rows, fields] = await pool.execute(query, [nid])

    // 檢查是否找到相應的消息
    if (rows.length === 0) {
      return res.status(404).json({ error: '找不到相應的新聞' })
    }

    //若有找到對應消息則返回給前端
    const news = rows[0]
    res.json(news)
  } catch (error) {
    console.error('資料獲取失敗:', error.message)
    res.status(500).json({ error: '資料獲取失敗，請重試。' })
  }
})

export default router
