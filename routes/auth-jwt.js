import express from 'express'
const router = express.Router()
import jsonwebtoken from 'jsonwebtoken'
import authenticate from '../middlewares/jwt.js'
import { verifyUser, getUser, getUserById } from '../models/users.js'
import 'dotenv/config.js'

const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET

router.get('/private', authenticate, (req, res) => {
  const user = req.user

  return res.json({ message: 'authorized', user })
})

// 檢查登入狀態用
router.get('/check-login', authenticate, async (req, res) => {
  const user = req.user
  return res.json({ message: 'authorized', user })
})

router.post('/info-change-jwt', async (req, res) => {
  res.clearCookie('accessToken', { httpOnly: true })

  const id = req.body.id
  console.log('id = ', id)
  // 會員存在，將會員的資料取出
  const member = await getUserById(id)

  if (!member) {
    return res.json({ message: '沒有member', code: '400' })
  }

  // member的password資料不應該回應給瀏覽器
  delete member.password

  // 產生存取令牌(access token)，其中包含會員資料
  const accessToken = jsonwebtoken.sign({ ...member }, accessTokenSecret, {
    expiresIn: '24h',
  })

  // 使用httpOnly cookie來讓瀏覽器端儲存access token
  res.cookie('accessToken', accessToken, { httpOnly: true })

  // 傳送access token回應(react可以儲存在state中使用)
  res.json({
    message: 'success',
    code: '200',
    accessToken,
  })
})

router.post('/login', async (req, res) => {
  const { email, password } = req.body

  const isMember = await verifyUser({
    email,
    password,
  })

  if (!isMember) {
    return res.json({ message: 'fail', code: '400' })
  }

  // 會員存在，將會員的資料取出
  const member = await getUser({
    email,
    password,
  })

  // member的password資料不應該回應給瀏覽器
  delete member.password

  // 產生存取令牌(access token)，其中包含會員資料
  const accessToken = jsonwebtoken.sign({ ...member }, accessTokenSecret, {
    expiresIn: '24h',
  })

  // 使用httpOnly cookie來讓瀏覽器端儲存access token
  res.cookie('accessToken', accessToken, { httpOnly: true })

  // 傳送access token回應(react可以儲存在state中使用)
  res.json({
    message: 'success',
    code: '200',
    accessToken,
  })
})

router.post('/logout', authenticate, (req, res) => {
  // 清除cookie
  res.clearCookie('accessToken', { httpOnly: true })
  res.clearCookie('userInfo', { httpOnly: true })
  res.json({ message: 'success', code: '200' })
})

router.post('/logout-ssl-proxy', authenticate, (req, res) => {
  // 清除cookie
  res.clearCookie('accessToken', {
    httpOnly: true,
    sameSite: 'none',
    secure: true,
  })

  res.json({ message: 'success', code: '200' })
})

export default router
