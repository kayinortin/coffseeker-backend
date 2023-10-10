import express from 'express'
const router = express.Router()

import {
  getProducts,
  getProductsWithQS,
  getProductById,
  countWithQS,
  updateProduct,
} from '../models/products.js'
import sqlString from 'sqlstring'

function handleMultipleValues(field, values) {
  if (values) {
    const valuesArray = values.split(',')
    return `${field} IN (${valuesArray
      .map((v) => sqlString.escape('%' + v + '%'))
      .join(',')})`
  }
  return ''
}

router.get('/qs', async (req, res, next) => {
  const {
    page,
    keyword,
    description,
    origin,
    orderby,
    perpage,
    price_range,
    search,
    Roast_degree,
    Processing,
    Variety,
  } = req.query

  const conditions = []

  conditions[0] = keyword
    ? `name LIKE ${sqlString.escape('%' + keyword + '%')}`
    : ''
  conditions[1] = handleMultipleValues('description', description)
  conditions[2] = handleMultipleValues('origin', origin)
  conditions[3] = handleMultipleValues('Roast_degree', Roast_degree)
  conditions[4] = handleMultipleValues('Processing', Processing)
  conditions[5] = handleMultipleValues('Variety', Variety)

  // 模糊搜尋商品名稱(name)與敘述(description)
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
  if (min >= 100 && max <= 10000) {
    conditions[5] = `discountPrice BETWEEN ${min} AND ${max}`
  }

  const conditionsValues = conditions.filter((v) => v)
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

// 更新單筆資料
router.put('/:pid', async (req, res, next) => {
  const product = await updateProduct(req.params.pid, req.body)
  res.json({ product: product })
})

export default router
