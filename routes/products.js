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
    const orConditions = valuesArray.map(
      (v) => `${field} LIKE ${sqlString.escape('%' + v + '%')}`
    )
    return orConditions.join(' OR ')
  }
  return ''
}

function createSearchConditions(searchString) {
  const searchKeywordsArr = searchString.split(',')
  const searchConditions = searchKeywordsArr.map((keyword) => {
    return `name LIKE ${sqlString.escape(
      '%' + keyword + '%'
    )} OR description LIKE ${sqlString.escape('%' + keyword + '%')}`
  })
  return searchConditions.join(' OR ')
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

  if (keyword) {
    conditions.push(`name LIKE ${sqlString.escape('%' + keyword + '%')}`)
  }

  const descriptionCondition = handleMultipleValues('description', description)
  if (descriptionCondition) {
    conditions.push(descriptionCondition)
  }

  const originCondition = handleMultipleValues('origin', origin)
  if (originCondition) {
    conditions.push(originCondition)
  }

  const RoastCondition = handleMultipleValues('Roast_degree', Roast_degree)
  if (RoastCondition) {
    conditions.push(RoastCondition)
  }

  const ProcessingCondition = handleMultipleValues('Processing', Processing)
  if (ProcessingCondition) {
    conditions.push(ProcessingCondition)
  }

  const VarietyCondition = handleMultipleValues('Variety', Variety)
  if (VarietyCondition) {
    conditions.push(VarietyCondition)
  }

  if (search) {
    conditions.push(createSearchConditions(search))
  }

  const priceRanges = price_range ? price_range.split(',') : []
  const min = Number(priceRanges[0])
  const max = Number(priceRanges[1])
  if (min >= 100 && max <= 5000) {
    conditions.push(`discountPrice BETWEEN ${min} AND ${max}`)
  }

  const conditionsValues = conditions.filter((v) => v)
  const where =
    conditionsValues.length > 0
      ? `WHERE ` + conditionsValues.map((v) => `( ${v} )`).join(' AND ')
      : ''

  const perpageNow = Number(perpage) || 10000
  const pageNow = Number(page) || 1
  const limit = perpageNow
  const offset = (pageNow - 1) * perpageNow

  const order = orderby
    ? { [orderby.split(',')[0]]: orderby.split(',')[1] }
    : { id: 'asc' }

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
