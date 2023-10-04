import jsonwebtoken from 'jsonwebtoken'
import 'dotenv/config.js'

const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET

export default function authenticate(req, res, next) {
  const token = req.cookies.accessToken
  console.log('token', token)

  if (!token) {
    return res.json({ message: 'Unauthorized', code: '401' })
  }

  jsonwebtoken.verify(token, accessTokenSecret, (err, user) => {
    if (err) {
      console.error(err)
      return res.json({ message: 'Forbidden', code: '403' })
    }
    req.user = user
    next()
  })
}
