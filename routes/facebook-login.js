import express from 'express'
const router = express.Router()
import { findOne, insertOne, count } from '../models/base.js'
import jsonwebtoken from 'jsonwebtoken'
import 'dotenv/config.js'

const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET

router.post('/jwt', async function (req, res, next) {
  const providerData = req.body

  console.log(JSON.stringify(providerData))

  if (!providerData.providerId || !providerData.uid) {
    return res.json({ message: 'fail', code: '400' })
  }

  const isFound = await count('users', { fb_uid: providerData.uid })

  if (isFound) {
    const user = await findOne('users', { fb_uid: providerData.uid })

    delete user.password

    const accessToken = jsonwebtoken.sign({ ...user }, accessTokenSecret, {
      expiresIn: '24h',
    })

    res.cookie('accessToken', accessToken)

    return res.json({
      message: 'success',
      code: '200',
      accessToken,
      user,
    })
  } else {
    const newUser = {
      username: providerData.displayName,
      email: providerData.email,
      fb_uid: providerData.uid,
      photo_url: providerData.photoURL,
    }

    await insertOne('users', newUser)

    const user = await findOne('users', { fb_uid: providerData.uid })

    delete user.password

    const accessToken = jsonwebtoken.sign({ ...user }, accessTokenSecret, {
      expiresIn: '24h',
    })

    res.cookie('accessToken', accessToken)

    return res.json({
      message: 'success',
      code: '200',
      accessToken,
      user,
    })
  }
})

export default router
