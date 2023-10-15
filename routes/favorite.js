import express from 'express'
const router = express.Router()

import { executeQuery } from '../models/base.js'

import authenticate from '../middlewares/jwt.js'

//==================收藏商品================
// 獲得某會員id的有加入到我的收藏清單中的商品id們
//會從token判讀使用者id例如"favorite/my-favorite-product/"會得到{"favoriteProducts": [2,3,4,5]}
router.get('/my-favorite-product', authenticate, async (req, res, next) => {
  const user = req.user
  const uid = user.id
  const sql = `SELECT f.product_id
        FROM favorite_product AS f
        WHERE f.user_id = ${uid}
        ORDER BY f.product_id ASC;`

  const { rows } = await executeQuery(sql)
  // 將結果中的pid取出變為一個純資料的陣列
  const favoriteProducts = rows.map((v) => v.product_id)

  res.json({ favoriteProducts })
})

//這個沒用到
router.get('/all-products-no-login', async (req, res, next) => {
  const sql = `SELECT p.*
    FROM products AS p
    ORDER BY p.id ASC`

  const { rows } = await executeQuery(sql)

  res.json({ products: rows })
})

//這個沒用到
router.get('/all-products', authenticate, async (req, res, next) => {
  const user = req.user
  const uid = user.id

  const sql = `SELECT p.*, IF(f.id, 'true', 'false') AS is_favorite
    FROM products AS p
    LEFT JOIN favorites AS f ON f.pid = p.id
    AND f.uid = ${uid}
    ORDER BY p.id ASC`

  const { rows } = await executeQuery(sql)

  console.log(rows)

  // cast boolean
  const products = rows.map((v) => ({
    ...v,
    is_favorite: v.is_favorite === 'true',
  }))

  console.log(products)

  res.json({ products })
})

//取得特定ID使用者的收藏商品，附上商品細節(會員中心顯示用)
router.get(
  '/my-favorite-product-detail/',
  authenticate,
  async (req, res, next) => {
    const user = req.user
    const uid = user.id
    const sql = `SELECT p.*, f.addedFavDate
  FROM product AS p
  INNER JOIN favorite_product AS f ON f.product_id = p.id
  WHERE f.user_id = ${uid}
  ORDER BY f.addedFavDate DESC`

    const { rows } = await executeQuery(sql)

    res.json({ products: rows })
  }
)

//新增特定ID使用者的收藏商品，需要傳入product_id
router.post('/favorite-product', authenticate, async (req, res, next) => {
  const now = new Date().toISOString().slice(0, 19).replace('T', ' ')
  const user = req.user
  const uid = user.id
  const { product_id } = req.body
  const sql = `INSERT INTO favorite_product (user_id, product_id, addedFavDate) VALUES (${uid}, ${product_id}, '${now}')`

  const { rows } = await executeQuery(sql)

  console.log(rows.affectedRows)

  if (rows.affectedRows) {
    return res.json({ message: 'success', code: '200' })
  } else {
    return res.json({ message: 'fail', code: '400' })
  }
})

//刪除特定ID使用者的收藏商品，需要傳入product_id
router.delete(
  '/favorite-product/:pid',
  authenticate,
  async (req, res, next) => {
    const pid = req.params.pid
    const user = req.user
    const uid = user.id

    const sql = `DELETE FROM favorite_product WHERE product_id=${pid} AND user_id=${uid}; `

    const { rows } = await executeQuery(sql)

    console.log(rows.affectedRows)

    if (rows.affectedRows) {
      return res.json({ message: 'success', code: '200' })
    } else {
      return res.json({ message: 'fail', code: '400' })
    }
  }
)

//=====================收藏課程==============
// 獲得某會員id的有加入到我的收藏清單中的商品id們
//例如"favorite/my-favorite-product"會得到{"favoriteCourses": [1,2,3]}
router.get('/my-favorite-course/', authenticate, async (req, res, next) => {
  const user = req.user
  const uid = user.id
  const sql = `SELECT c.course_id
        FROM favorite_course AS c
        WHERE c.user_id = ${uid}
        ORDER BY c.course_id ASC;`

  const { rows } = await executeQuery(sql)
  // 將結果中的cid取出變為一個純資料的陣列
  const favoriteCourses = rows.map((v) => v.course_id)

  res.json({ favoriteCourses: favoriteCourses })
})

//取得特定ID使用者的收藏課程，附上課程細節(會員中心顯示用)
router.get(
  '/my-favorite-course-detail/',
  authenticate,
  async (req, res, next) => {
    const user = req.user
    const uid = user.id
    const sql = `SELECT c.*, f.addedFavDate
  FROM course AS c
  INNER JOIN favorite_course AS f ON f.course_id = c.id
  WHERE f.user_id = ${uid}
  ORDER BY f.addedFavDate DESC`

    const { rows } = await executeQuery(sql)

    res.json({ courses: rows })
  }
)

//新增特定ID使用者的收藏課程，需要傳入course_id
router.post('/favorite-course', authenticate, async (req, res, next) => {
  const now = new Date().toISOString().slice(0, 19).replace('T', ' ')
  const user = req.user
  const uid = user.id
  const { course_id } = req.body
  const sql = `INSERT INTO favorite_course (user_id, course_id, addedFavDate) VALUES (${uid}, ${course_id}, '${now}')`

  const { rows } = await executeQuery(sql)

  console.log(rows.affectedRows)

  if (rows.affectedRows) {
    return res.json({ message: 'success', code: '200' })
  } else {
    return res.json({ message: 'fail', code: '400' })
  }
})

//刪除特定ID使用者的收藏課程，需要傳入course_id
router.delete('/favorite-course/:cid', authenticate, async (req, res, next) => {
  const cid = req.params.cid
  const user = req.user
  const uid = user.id

  const sql = `DELETE FROM favorite_course WHERE course_id=${cid} AND user_id=${uid}; `

  const { rows } = await executeQuery(sql)

  console.log(rows.affectedRows)

  if (rows.affectedRows) {
    return res.json({ message: 'success', code: '200' })
  } else {
    return res.json({ message: 'fail', code: '400' })
  }
})
export default router
