import express from 'express'
const router = express.Router()

import { readJsonFile } from '../utils/json-tool.js'

import {
  getCourse,
  getCourseWithQS,
  getCourseById,
  countWithQS,
} from '../models/course.js'
// 專用處理sql字串的工具，主要format與escape，防止sql injection
import sqlString from 'sqlstring'

function handleMultipleValues(field, values) {
  if (values) {
    const valuesArray = values.split(',')
    const orConditions = valuesArray.map(
      (v) => `${field} LIKE ${sqlString.escape('%' + v + '%')}`
    )
    return orConditions.join('OR')
  }
  return ''
}

function createSearchConditions(searchString) {
  const searchKeywordsArr = searchString.split(',')
  const searchConditions = searchKeywordsArr.map((keyword) => {
    return `name LIKE ${sqlString.escape('%' + keyword + '%')}`
  })
  return searchConditions.join('OR')
}
// 獲得所有資料，加入分頁與搜尋字串功能，單一資料表處理
// courses/qs?page=1&keyword=xxxx&cat_ids=1,2&sizes=1,2&tags=3,4&colors=1,2,3&orderby=id,asc&perpage=10&price_range=1500,10000
router.get('/qs', async (req, res, next) => {
  // 獲取網頁的搜尋字串
  const {
    page,
    keyword,
    course_ids,
    colors,
    tags,
    sizes,
    orderby,
    perpage,
    latte_art,
    search,
    pour,
    roast,
    price_range,
  } = req.query

  // 建立資料庫搜尋條件
  const conditions = []

  const ArtCondition = handleMultipleValues('latte_art', latte_art)
  if (ArtCondition) {
    conditions.push(ArtCondition)
  }

  const PourCondition = handleMultipleValues('pour', pour)
  if (PourCondition) {
    conditions.push(PourCondition)
  }

  const RoastCondition = handleMultipleValues('roast', roast)
  if (RoastCondition) {
    conditions.push(RoastCondition)
  }

  if (search) {
    conditions.push(createSearchConditions(search))
  }

  // 關鍵字 keyword 使用 `name LIKE '%keyword%'`
  conditions[0] = keyword
    ? `name LIKE ${sqlString.escape('%' + keyword + '%')}`
    : ''

  // 分類，course_id 使用 `course_id IN (1, 2, 3, 4, 5)`
  conditions[1] = course_ids ? `course_id IN (${course_ids})` : ''

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

  let zhLatter_art

  if (latte_art === 'beginer') {
    zhLatter_art = '入門'
  }

  console.log(latte_art)
  conditions.push(zhLatter_art ? `course_level_id = ${zhLatter_art}` : '')
  //   conditions.push(cate_2 ? `category_2 IN (${cate_2})` : '')

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
  const courses = await getCourseWithQS(where, order, limit, offset)

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
    data: courses,
  }

  res.json(result)
})

// 獲得單筆資料
router.get('/:pid', async (req, res, next) => {
  const courseId = req.params.pid // Access course_id from URL parameter

  try {
    const course = await getCourseById(courseId) // Use courseId to fetch course data

    if (course) {
      return res.json({ ...course })
    } else {
      return res.json({})
    }
  } catch (err) {
    console.log(err)
    return res.status(500).json({ err: 'Internal Server Error' })
  }
})

// 獲得所有資料
router.get('/', async (req, res, next) => {
  // 讀入範例資料
  const courses = await getCourse()
  res.json({ courses })
})

export default router
