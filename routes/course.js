import express from 'express'
const router = express.Router()
import {
  getCourse,
  getCourseWithQS,
  getCourseById,
  countWithQS,
} from '../models/course.js'
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
    orderby,
    perpage,
    course_level_id,
    search,
    course_name,
    roast,
    price_range,
  } = req.query

  // 建立資料庫搜尋條件
  const conditions = []

  if (keyword) {
    conditions.push(`name LIKE ${sqlString.escape('%' + keyword + '%')}`)
  }

  const LevelCondition = handleMultipleValues(
    'course_level_id',
    course_level_id
  )
  if (LevelCondition) {
    conditions.push(LevelCondition)
  }

  const NameCondition = handleMultipleValues('course_name', course_name)
  if (NameCondition) {
    conditions.push(NameCondition)
  }

  if (search) {
    conditions.push(createSearchConditions(search))
  }

  const priceRanges = price_range ? price_range.split(',') : []
  const min = Number(priceRanges[0])
  const max = Number(priceRanges[1])
  if (min >= 1500 && max <= 10000) {
    conditions.push(`course_price BETWEEN ${min} AND ${max}`)
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
  const courses = await getCourseWithQS(where, order, limit, offset)
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
