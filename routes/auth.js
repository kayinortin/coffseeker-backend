import express from 'express'
const router = express.Router()
import auth from '../middlewares/auth.js'
import { verifyUser, getUser, getUserById } from '../models/users.js'

router.post('/login', async function (req, res, next) {
  const user = req.body
  console.log(user)

  // 這裡可以再檢查從react來的資料，哪些資料為必要(email, password...)
  if (!user.email || !user.password) {
    return res.json({ message: 'fail', code: '400' })
  }

  const { email, password } = user
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

  console.log(member)

  // member的password資料不應該回應給瀏覽器
  delete member.password

  // 啟用session
  req.session.userId = member.id

  return res.json({
    message: 'success',
    code: '200',
    user: member,
  })
})

router.post('/logout', auth, async function (req, res, next) {
  res.clearCookie('SESSION_ID') //cookie name
  req.session.destroy(() => {
    console.log('session destroyed')
  })

  res.json({ message: 'success', code: '200' })
})

router.get('/private', auth, (req, res) => {
  const userId = req.session.userId
  return res.json({ message: 'authorized', userId })
})

router.get('/check-login', async function (req, res, next) {
  if (req.session.userId) {
    const userId = req.session.userId
    const user = await getUserById(userId)
    delete user.password

    return res.json({ message: 'authorized', user })
  } else {
    return res.json({ message: 'Unauthorized' })
  }
})

export default router
