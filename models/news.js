// 資料庫查詢處理函式
import {
  find,
  findOneById,
  insertMany,
  cleanTable,
  count,
  executeQuery,
} from './base.js'

import pool from '../config/db.js'

// 定義資料庫表格名稱
const table = 'news'

// 所需的資料處理函式
// 查詢所有資料
const getNews = async () => {
  const { rows } = await find(table)
  return rows
}

const getNewsWithQS = async (where = '', order = {}, limit = 0, offset) => {
  const { rows } = await find(table, where, order, limit, offset)
  return rows
}

// 查詢總數用，加入分頁與搜尋字串功能
const countWithQS = async (where = '') => {
  return await count(table, where)
}

// 查詢單一資料，使用id
const getNewsById = async (nid) => {
  console.log(nid)
  const sql = 'SELECT * FROM news WHERE news_id = ?' // 使用 news_id 作為條件
  const params = [nid] // 將 nid 作為參數傳遞
  return await executeQuery(sql, params)
}

// 建立大量商品資料用
const createBulkNews = async (users) => await insertMany(table, users)

// 其它用途
// 清除表格資料
const cleanAll = async () => await cleanTable(table)

export {
  getNews,
  getNewsWithQS,
  getNewsById,
  createBulkNews,
  cleanAll,
  countWithQS,
}
