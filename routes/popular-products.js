import express from 'express'
const router = express.Router()

import { getHotProducts } from '../models/products.js'

router.get('/hot', async (req, res, next) => {
  try {
    const hotProducts = await getHotProducts()
    res.json({ hotProducts })
  } catch (err) {
    console.error('Error fetching hot products:', err)
    res.status(500).json({ error: 'Unable to fetch hot products' })
  }
})

export default router
