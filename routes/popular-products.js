import express from 'express'
const router = express.Router()

import { getProducts, getProductsWithQS } from '../models/products.js'

router.get('/', async (req, res, next) => {
  const products = await getProductsWithQS('', { popularity: 'desc' }, 6)
  res.json({ products })
})

export default router
