// 資料庫查詢處理函式
import {
  find,
  count,
  findOneById,
  insertOne,
  insertMany,
  remove,
  updateById,
  cleanTable,
  findOne,
  executeQuery,
} from './base.js'

// 定義資料庫表格名稱
const table = 'order_details'

// 所需的資料處理函式
const getOrders = async () => {
  const { rows } = await find(table)
  return rows
}
const getOrderBytrackingNumber = async (tracking_number) =>
  await findOneById(table, tracking_number)
const getCount = async (where) => await count(table, where)
const createOrder = async (user) => await insertOne(table, user)
const createBulkOrders = async (users) => await insertMany(table, users)
const deleteOrderById = async (id) => await remove(table, { id })

// 針對PUT更新user資料
const updateOrderById = async (user, id) => await updateById(table, user, id)
const updateOrder = async (user) => await updateById(table, user, user.id)

// 登入使用
const verifyOrder = async ({ email, password }) =>
  Boolean(await count(table, { email, password }))

const getOrder = async ({ email, password }) =>
  await findOne(table, { email, password })

// 其它用途
const cleanAll = async () => await cleanTable(table)

// 找尋指定使用者Id的所有訂單(全訂單)
// const getOrdersByUserId = async (userId, orderBy) => {
//   const sql = `SELECT * FROM ${table} WHERE user_id = ${userId} ORDER BY order_date ${orderBy}`
//   const { rows } = await executeQuery(sql)
//   return rows
// }

const getOrderTotalPage = async (userId) => {
  //先將資料全部抽出
  const countSql = `
  SELECT COUNT(*) as total
  FROM ${table}
  WHERE user_id = ${userId}
  `
  const countResult = await executeQuery(countSql)
  const totalRecords = countResult.rows[0].total

  const itemsPerPage = 6

  // 計算總頁數
  const totalPages = Math.ceil(totalRecords / itemsPerPage)
  return totalPages
}

// 找尋指定使用者Id的所有訂單(分頁版)
const getOrdersByUserId = async (userId, orderBy, page) => {
  const itemsPerPage = 6
  const offset = (page - 1) * itemsPerPage
  const sql = `
  SELECT *
  FROM ${table}
  WHERE user_id = ${userId}
  ORDER BY order_date ${orderBy}
  LIMIT ${itemsPerPage}
  OFFSET ${offset}
  `
  const { rows } = await executeQuery(sql)
  return rows
}

const getItemsBytrackingNunber = async (trackingNunber) => {
  const sql = `SELECT 
  product.id, 
  product.image, 
  product.name,
  product.discountPrice, 
  order_product.amount
FROM order_product
INNER JOIN product ON order_product.product_id = product.id
WHERE order_product.tracking_number = ${trackingNunber}

UNION

SELECT 
  course.id, 
  course.course_subpics, 
  course.course_name, 
  course.course_price, 
  order_course.amount
FROM order_course
INNER JOIN course ON order_course.course_id = course.id
WHERE order_course.tracking_number = ${trackingNunber};`
  const { rows } = await executeQuery(sql)
  return rows
}

export {
  cleanAll,
  createBulkOrders,
  createOrder,
  deleteOrderById,
  getCount,
  getOrder,
  getOrderBytrackingNumber,
  getOrders,
  updateOrder,
  updateOrderById,
  verifyOrder,
  getOrdersByUserId,
  getItemsBytrackingNunber,
  getOrderTotalPage,
}
