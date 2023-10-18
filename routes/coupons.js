import express from 'express'
const router = express.Router()
import pool from '../config/db.js'

import { readJsonFile } from '../utils/json-tool.js'

import {
  getCoupons,
  getCouponWithQS,
  getCouponById,
  countWithQS,
  getCouponByUserId,
  getCouponPagesByUserId,
  getCouponTotalPage,
} from '../models/coupons.js'
// 專用處理sql字串的工具，主要format與escape，防止sql injection
import sqlString from 'sqlstring'

// 獲得所有資料，加入分頁與搜尋字串功能，單一資料表處理
// products/qs?page=1&keyword=xxxx&cat_ids=1,2&sizes=1,2&tags=3,4&colors=1,2,3&orderby=id,asc&perpage=10&price_range=1500,10000
router.get('/qs', async (req, res, next) => {
  // 獲取網頁的搜尋字串
  const {
    page,
    keyword,
    coupon_ids,
    colors,
    tags,
    sizes,
    orderby,
    perpage,
    price_range,
  } = req.query

  // 建立資料庫搜尋條件
  const conditions = []

  // 關鍵字 keyword 使用 `name LIKE '%keyword%'`
  conditions[0] = keyword
    ? `name LIKE ${sqlString.escape('%' + keyword + '%')}`
    : ''

  // 分類，coupon_id 使用 `coupon_id IN (1, 2, 3, 4, 5)`
  conditions[1] = coupon_ids ? `coupon_id IN (${coupon_ids})` : ''

  // 顏色: FIND_IN_SET(1, color) OR FIND_IN_SET(2, color)
  const color_ids = colors ? colors.split(',') : []
  conditions[2] = color_ids
    .map((v) => `FIND_IN_SET(${Number(v)}, color)`)
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
  const products = await getCouponWithQS(where, order, limit, offset)

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
    data: products,
  }

  res.json(result)
})

// 獲得單筆資料
router.get('/:pid', async (req, res, next) => {
  const coupons = await getCouponById(req.params.pid)

  if (coupons) {
    return res.json({ ...coupons })
  } else {
    return res.json({})
  }
})

// 獲得所有資料
router.get('/', async (req, res, next) => {
  // 讀入範例資料
  const coupons = await getCoupons()
  res.json({ coupons })
})

router.get('/userCoupons/:userId', async function (req, res, next) {
  try {
    const orders = await getCouponByUserId(req.params.userId)
    res.json({ message: 'success', code: '200', orders })
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' })
  }
})

//更新已使用的優惠卷valid 值

router.put('/updatecoupon/:id', async (req, res, next) => {
  const couponId = req.params.id
  const newValidValue = 0
  // console.log(couponId)

  try {
    const updateCouponSql = `UPDATE coupon SET coupon_valid = ? WHERE coupon_id = ?`
    await pool.execute(updateCouponSql, [newValidValue, couponId])

    return res.json({
      message: 'Coupon已成功更新',
      code: '200',
    })
  } catch (error) {
    console.error('更新 Coupon 出錯', error)
    return res.status(500).json({
      message: '無法更新 Coupon ',
      code: '500',
    })
  }
})

// ！！！！！！！！！！！！！！！！！
// 品睿的會員優惠券頁面使用
// 收出指定使用者優惠券資料及計算分頁
router.get(
  '/getCouponPages/:userId/:orderBy/:page',
  async function (req, res, next) {
    try {
      const coupons = await getCouponPagesByUserId(
        req.params.userId,
        req.params.orderBy,
        req.params.page
      )
      const totalPage = await getCouponTotalPage(req.params.userId)
      res.json({ message: 'success', code: '200', coupons, totalPage })
    } catch (error) {
      res.status(500).json({ error: 'Internal server error' })
    }
  }
)

export default router
