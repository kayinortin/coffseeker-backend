// 資料庫查詢處理函式
import {
  find,
  findOneById,
  insertMany,
  cleanTable,
  count,
  executeQuery,
} from './base.js'

// 定義資料庫表格名稱
const table = 'coupon'

// 所需的資料處理函式
// 查詢所有資料
const getCoupons = async () => {
  const { rows } = await find(table)
  return rows
}

// 查詢所有資料，加入分頁與搜尋字串功能
// SELECT *
// FROM product
// WHERE  name LIKE '%Awesome%'
//        AND cat_id IN (1,2,3)
//        AND (
//               FIND_IN_SET(1, color)
//               OR FIND_IN_SET(2, color)
//        )
//        AND (FIND_IN_SET(3, tag))
//        AND (
//               FIND_IN_SET(1, size)
//               OR FIND_IN_SET(2, size)
//        )
// ORDER BY id
// LIMIT 0 OFFSET 10;
const getCouponWithQS = async (where = '', order = {}, limit = 0, offset) => {
  const { rows } = await find(table, where, order, limit, offset)
  return rows
}

// 查詢總數用，加入分頁與搜尋字串功能
const countWithQS = async (where = '') => {
  return await count(table, where)
}

// 查詢單一資料，使用id
const getCouponById = async (id) => await findOneById(table, id)

// 建立大量優惠卷資料用
const createBulkCoupon = async (users) => await insertMany(table, users)

// 其它用途

// 清除表格資料
const cleanAll = async () => await cleanTable(table)

//
const getCouponByUserId = async (userId) => {
  const sql = `SELECT * FROM ${table} WHERE user_id = ${userId}`
  const { rows } = await executeQuery(sql)
  return rows
}

// ！！！！！！！！！！！！！！！！！！
// 品睿優惠券頁面渲染用
// 找尋指定使用者Id的所有優惠券(分頁版)
const getCouponPagesByUserId = async (userId, orderBy, page) => {
  const itemsPerPage = 6
  const offset = (page - 1) * itemsPerPage
  const sql = `
  SELECT *
  FROM ${table}
  WHERE user_id = ${userId} AND coupon_valid = 1
  ORDER BY expires_at ${orderBy}
  LIMIT ${itemsPerPage}
  OFFSET ${offset}
  `
  const { rows } = await executeQuery(sql)
  return rows
}

// ！！！！！！！！！！！！！！！！！！
// 品睿優惠券頁面渲染用
// 計算總頁數
const getCouponTotalPage = async (userId) => {
  //先將資料全部抽出
  const countSql = `
  SELECT COUNT(*) as total
  FROM ${table}
  WHERE user_id = ${userId} AND coupon_valid = 1
  `
  const countResult = await executeQuery(countSql)
  const totalRecords = countResult.rows[0].total

  const itemsPerPage = 6

  // 計算總頁數
  const totalPages = Math.ceil(totalRecords / itemsPerPage)
  return totalPages
}

export {
  getCoupons,
  getCouponWithQS,
  getCouponById,
  createBulkCoupon,
  cleanAll,
  countWithQS,
  getCouponByUserId,
  getCouponPagesByUserId,
  getCouponTotalPage,
}
