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
const getOrderById = async (id) => await findOneById(table, id)
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

// 找尋指定使用者Id的所有訂單
const getOrdersByUserId = async (userId) => {
  const sql = `SELECT * FROM ${table} WHERE user_id = ${userId}`
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
  getOrderById,
  getOrders,
  updateOrder,
  updateOrderById,
  verifyOrder,
  getOrdersByUserId,
}
