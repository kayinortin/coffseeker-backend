import express from 'express'
const router = express.Router()

// 檢查空物件
import { isEmpty } from '../utils/tool.js'

// 認証用middleware(中介軟體)
// import auth from '../middlewares/auth.js'

// 上傳檔案用使用multer(另一方案是使用express-fileupload)
import multer from 'multer'
const upload = multer({ dest: 'public/' })

import {
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
} from '../models/order.js'

// GET - 得到所有會員資料
router.get('/', async function (req, res, next) {
  const orders = await getOrders()
  return res.json({ message: 'success', code: '200', orders })
})

// GET - 得到單筆資料(注意，有動態參數時要寫在GET區段最後面)
router.get('/:tracking_number', async function (req, res, next) {
  const order = await getOrderBytrackingNumber(req.params.tracking_number)
  return res.json({ message: 'success', code: '200', order })
})
// GET - 得到指定使用者全部訂單
router.get(
  '/userOrders/:userId/:orderBy/:page',
  async function (req, res, next) {
    try {
      const orders = await getOrdersByUserId(
        req.params.userId,
        req.params.orderBy,
        req.params.page
      )
      const totalPage = await getOrderTotalPage(req.params.userId)
      res.json({ message: 'success', code: '200', orders, totalPage })
    } catch (error) {
      res.status(500).json({ error: 'Internal server error' })
    }
  }
)
// GET - 得到指定訂單的明細
router.get('/orderItems/:tracking_number', async function (req, res, next) {
  try {
    const orderItems = await getItemsBytrackingNunber(
      req.params.tracking_number
    )
    res.json({ message: 'success', code: '200', orderItems })
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' })
  }
})

// POST - 上傳檔案用，使用express-fileupload
router.post('/upload', async function (req, res, next) {
  // req.files 所有上傳來的檔案
  // req.body 其它的文字欄位資料…
  console.log(req.files, req.body)

  if (req.files) {
    console.log(req.files.avatar) // 上傳來的檔案(欄位名稱為avatar)
    return res.json({ message: 'success', code: '200' })
  } else {
    console.log('沒有上傳檔案')
    return res.json({ message: 'fail', code: '409' })
  }
})

// POST - 上傳檔案用，使用multer
// 注意: 使用nulter會和express-fileupload衝突，所以要先註解掉express-fileupload的使用再作測試
// 在app.js中的app.use(fileUpload())
router.post(
  '/upload2',
  upload.single('avatar'), // 上傳來的檔案(這是單個檔案，欄位名稱為avatar)
  async function (req, res, next) {
    // req.file 即上傳來的檔案(avatar這個檔案)
    // req.body 其它的文字欄位資料…
    console.log(req.file, req.body)

    if (req.file) {
      console.log(req.file)
      return res.json({ message: 'success', code: '200' })
    } else {
      console.log('沒有上傳檔案')
      return res.json({ message: 'fail', code: '409' })
    }
  }
)

// POST - 新增會員資料
router.post('/', async function (req, res, next) {
  // 從react傳來的資料(json格式)，id由資料庫自動產生
  // 資料範例
  // {
  //     "name":"金妮",
  //     "email":"ginny@test.com",
  //     "ordername":"ginny",
  //     "password":"12345"
  // }

  // order是從瀏覽器來的資料
  const order = req.body

  // 檢查從瀏覽器來的資料，如果為空物件則失敗
  if (isEmpty(order)) {
    return res.json({ message: 'fail-表單資料為空', code: '400' })
  }

  // 這裡可以再檢查從react來的資料，哪些資料為必要(name, ordername...)
  console.log(order)

  // 先查詢資料庫是否有同ordername與email的資料
  const countMail = await getCount({
    // ordername: order.ordername,
    email: order.email,
  })

  // 檢查使用者是否存在
  if (countMail) {
    return res.json({ message: 'fail-使用者已存在', code: '400' })
  }

  // 新增至資料庫
  const result = await createOrder(order)

  // 不存在insertId -> 新增失敗
  if (!result.insertId) {
    return res.json({ message: 'fail', code: '400' })
  }

  // 成功加入資料庫的回應
  return res.json({
    message: 'success',
    code: '200',
    order: { ...order, id: result.insertId },
  })
})

// PUT - 更新會員資料
router.put('/:orderId', async function (req, res, next) {
  const orderId = req.params.orderId
  const order = req.body
  console.log(orderId, order)

  // 檢查是否有從網址上得到orderId
  // 檢查從瀏覽器來的資料，如果為空物件則失敗
  if (!orderId || isEmpty(order)) {
    return res.json({ message: 'error', code: '400' })
  }

  // 這裡可以再檢查從react來的資料，哪些資料為必要(name, ordername...)
  console.log(order)

  // 對資料庫執行update
  const result = await updateOrderById(order, orderId)
  console.log(result)

  // 沒有更新到任何資料
  if (!result.affectedRows) {
    return res.json({ message: 'fail', code: '400' })
  }

  // 最後成功更新
  return res.json({ message: 'success', code: '200' })
})

export default router
