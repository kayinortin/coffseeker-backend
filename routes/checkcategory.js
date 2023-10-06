import express from 'express'
const router = express.Router()

import { checkProductCategory } from '../models/checkcategory.js'

router.get('/', async (req, res) => {
  try {
    // 從請求的查詢參數中獲取 product_id 和 category_id
    const { product_id, category_id } = req.query

    // 使用 checkProductCategory 函數
    const result = await checkProductCategory(product_id, category_id)

    res.json(result)
  } catch (error) {
    console.error(error)
    res.status(500).send('Internal Server Error')
  }
})

export default router
