import express from 'express'
const router = express.Router()
import { createOtp, updatePassword } from '../models/otp.js'
import transporter from '../config/mail.js'
import 'dotenv/config.js'

// 電子郵件文字訊息樣版
const mailHtml = (otpToken) => `
<html>
<head>
    <style>
        body {
            font-family: '微軟正黑體', 'Roboto', 'Helvetica Neue', 'Arial', sans-serif;
            font-size: 16px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <p>親愛的 COFFSEEKER 會員您好：</p>
    
    <p>通知重設密碼所需要的驗證碼，<br>
    請輸入以下的6位數字，<br>
    重設密碼頁面的《電子郵件驗證碼》欄位中。<br>
    請注意驗證碼將於寄送後 30 分鐘後過期，<br>
    如有任何問題請洽 COFFSEEKER 客服人員：</p>
    

    <p>請輸入以下的6位數字：</p>
    <h2>${otpToken}</h2> <!-- 使用h2是為了強調OTP，您可以根據需要進行調整 -->

    <p>敬上</p>
   
    <p>COFFSEEKER 探索咖啡</p>
    <img src="https://i.imgur.com/oaBZVxk.png" alt="COFFSEEKER Logo" width="300">
</body>
</html>
`

// 使用時，將此HTML傳遞給您的電子郵件發送功能

router.post('/otp', async (req, res, next) => {
  const { email } = req.body
  if (!email) return res.json({ message: 'fail', code: '400' })

  const otp = await createOtp(email)
  if (!otp.token) return res.json({ message: 'fail', code: '400' })

  // 寄送email
  const mailOptions = {
    from: `"support"<${process.env.SMTP_TO_EMAIL}>`,
    to: email,
    subject: '重設密碼要求的電子郵件驗證碼',
    html: mailHtml(otp.token),
  }

  transporter.sendMail(mailOptions, (err, response) => {
    if (err) {
      return res.status(400).json({ message: 'fail', detail: err })
    } else {
      return res.json({ message: 'email sent', code: '200' })
    }
  })
})

// 重設密碼用
router.post('/reset', async (req, res, next) => {
  const { email, token, password } = req.body

  if (!token) return res.json({ message: 'fail', code: '400' })
  const result = await updatePassword(email, token, password)

  if (!result) return res.json({ message: 'fail', code: '400' })
  return res.json({ message: 'success', code: '200' })
})

export default router
