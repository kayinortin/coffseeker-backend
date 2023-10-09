import express from 'express'
const router = express.Router()

import { getComment, checkOrder, addComment } from '../models/comment.js'

router.get('/', async (req, res) => {
  try {
    // 從請求的查詢參數中獲取 product_id
    const { product_id } = req.query

    // 使用 getComment 函數
    const result = await getComment(product_id)

    res.json(result)
  } catch (error) {
    console.error(error)
    res.status(500).send('Internal Server Error')
  }
})

router.post('/add', async (req, res) => {
  try {
    // 從請求的查詢參數中獲取 product_id
    const {
      product_id,
      user_id,
      user_email,
      user_name,
      comment,
      date,
      rating,
    } = req.body

    // 使用 checkOrder 函數
    const result = await checkOrder(product_id, user_id)

    // 如果沒有訂單，回傳錯誤
    if (result.length === 0) {
      return res.status(401).json({ message: '還沒品嘗過嗎？快去購買商品吧！' })
    }

    // 使用 addComment 函數
    const newComment = await addComment(
      product_id,
      user_id,
      user_email,
      user_name,
      comment,
      date,
      rating
    )

    if (newComment && newComment.insertId) {
      // 檢查是否有insertId，如果有，表示評論已經成功新增
      res.json({ message: '評論和評分已送出', data: newComment })
    } else {
      // 如果沒有insertId，表示評論沒有新增，可能是因為該用戶已在同一天為該商品提交了評論
      res.status(400).json({ message: '您今天已經評論過了，感謝您的支持！' })
    }
  } catch (error) {
    console.error(error)
    res.status(500).send('Internal Server Error')
  }
})

export default router
