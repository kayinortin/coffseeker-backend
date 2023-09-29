import jsonwebtoken from 'jsonwebtoken'
import 'dotenv/config.js'

const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET

export default function authenticate(req, res, next) {
  const token = req.cookies.accessToken

  if (!token) {
    return res.json({ message: 'Forbidden', code: '403' })
  }

  if (token) {
    jsonwebtoken.verify(token, accessTokenSecret, (err, user) => {
      if (err) {
        console.error(err)
        return res.json({ message: 'Forbidden', code: '403' })
      }

      // 將user資料加到req中
      // postman header authorization Bearer token
      req.user = user
      next()
    })
  } else {
    return res.json({ message: 'Unauthorized', code: '401' })
  }
}
