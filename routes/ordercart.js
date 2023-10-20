import express from 'express'
const router = express.Router()
import 'dotenv/config.js'
import pool from '../config/db.js'

import { readJsonFile } from '../utils/json-tool.js'

import {
  getOrders,
  getOrderWithQS,
  getOrderById,
  cleanAll,
  OrderWithQS,
  getOrderByUserId,
  createOrder,
} from '../models/ordercart.js'
// 專用處理sql字串的工具，主要format與escape，防止sql injection
import sqlString from 'sqlstring'
import { log } from 'debug/src/browser.js'

// 獲得所有資料
router.get('/', async (req, res, next) => {
  // 讀入範例資料
  const orders = await getOrders()
  res.json({ orders })
})

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
  // conditions[1] = order_ids ? `coupon_id IN (${order_ids})` : ''

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
  const total = await OrderWithQS(where)
  const products = await getOrderWithQS(where, order, limit, offset)

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

//新增訂單資料
router.post('/neworder', async (req, res, next) => {
  const orderList = req.body.orderList
  const orderProducts = req.body.orderProducts
  const orderCourses = req.body.orderCourses
  console.log(orderList)
  console.log(orderProducts)
  console.log(orderCourses)

  const ordersql = `INSERT INTO order_details (user_id, tracking_number, subtotal, shipping_fee, discount_price, total_price, payment, delivery, receiver_name, receiver_phone, receiver_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`

  try {
    const [rows] = await pool.execute(ordersql, [
      orderList.user_id,
      orderList.tracking_number,
      orderList.subtotal,
      orderList.shipping_fee,
      orderList.discount_price,
      orderList.total_price,
      orderList.payment,
      orderList.delivery,
      orderList.receiver_name,
      orderList.receiver_phone,
      orderList.receiver_address,
    ])

    if (orderProducts && orderProducts.length > 0) {
      const orderProductsql = `INSERT INTO order_product(tracking_number, product_id, amount, price) VALUES (?, ?, ?, ?)`

      for (const product of orderProducts) {
        await pool.execute(orderProductsql, [
          orderList.tracking_number,
          product.product_id,
          product.amount,
          product.price,
        ])
      }
    }

    if (orderCourses && orderCourses.length > 0) {
      const orderCoursesql = `INSERT INTO order_course (tracking_number, course_id, amount, price) VALUES (?, ?, ?, ?)`

      for (const course of orderCourses) {
        await pool.execute(orderCoursesql, [
          orderList.tracking_number,
          course.course_id,
          1,
          course.price,
        ])
      }
    }

    return res.json({
      message: 'DB訂單已成功加入',
      code: '200',
      insertData: rows,
    })
  } catch (error) {
    console.error('DB新增訂單錯誤', error)
    return res.status(500).json({
      message: 'DB無法插入訂單',
      code: '500',
    })
  }
})

// 獲得單筆資料
router.get('/:pid', async (req, res, next) => {
  const order = await getOrderById(req.params.pid)

  if (order) {
    return res.json({ ...order })
  } else {
    return res.json({})
  }
})

export default router
