import express from 'express'
const router = express.Router()

import { readJsonFile } from '../utils/json-tool.js'

import {
  getProducts,
  getProductsWithQS,
  getProductById,
  countWithQS,
} from '../models/products.js'
// 專用處理sql字串的工具，主要format與escape，防止sql injection
import sqlString from 'sqlstring'

// 獲得所有資料，加入分頁與搜尋字串功能，單一資料表處理
// products/qs?page=1&keyword=xxxx&cat_ids=1,2&sizes=1,2&tags=3,4&colors=1,2,3&orderby=id,asc&perpage=10&price_range=1500,10000
router.get('/qs', async (req, res, next) => {
  // 獲取網頁的搜尋字串
  const {
    page,
    keyword,
    product_ids,
    colors,
    tags,
    sizes,
    orderby,
    perpage,
    price_range,
    search,
  } = req.query

  // 建立資料庫搜尋條件
  const conditions = []

  // 關鍵字 keyword 使用 `name LIKE '%keyword%'`
  conditions[0] = keyword
    ? `name LIKE ${sqlString.escape('%' + keyword + '%')}`
    : ''

  // 分類，product_id 使用 `product_id IN (1, 2, 3, 4, 5)`
  conditions[1] = product_ids ? `product_id IN (${product_ids})` : ''

  // 顏色: FIND_IN_SET(1, color) OR FIND_IN_SET(2, color)
  const color_ids = colors ? colors.split(',') : []
  conditions[2] = color_ids
    .map((v) => `FIND_IN_SET(${Number(v)}, color)`)
    .join(' OR ')

  //模糊搜尋商品名稱(name)與敘述(description)
  // 處理模糊搜尋字串的函式，預設搜尋字串用逗號分隔，例如"api/products/qs?search=中焙,花香"，會顯示所有商品名稱以及敘述有中焙或花香的商品
  function createSearchConditions(searchString) {
    const searchKeywordsArr = searchString.split(',')
    const searchConditions = searchKeywordsArr.map((keyword) => {
      return `name LIKE ${sqlString.escape(
        '%' + keyword + '%'
      )} OR description LIKE ${sqlString.escape('%' + keyword + '%')}`
    })
    return searchConditions.join(' OR ')
  }
  if (search) {
    conditions[3] = createSearchConditions(search)
  }

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
  const products = await getProductsWithQS(where, order, limit, offset)

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
  const product = await getProductById(req.params.pid)

  if (product) {
    return res.json({ ...product })
  } else {
    return res.json({})
  }
})

// 獲得所有資料
router.get('/', async (req, res, next) => {
  // 讀入範例資料
  const products = await getProducts()
  res.json({ products })
})

export default router
