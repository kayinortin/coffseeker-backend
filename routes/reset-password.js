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
        font-family: "Noto Sans", "Noto Sans TC Regular", Helvetica, Arial,
          "PingFang TC", "苹方-繁", "Heiti TC", "黑體-繁", "Microsoft JhengHei",
          "微軟正黑體", system-ui, -apple-system, "Segoe UI", Roboto,
          "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif,
          "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
          "Noto Color Emoji";
        font-size: 16px;
        line-height: 1.5;
      }
      .padding-setting {
        padding-inline: 10px;
      }
      .title {
        font-weight: 700;
      }
      .content {
        padding: 5px;
        margin-block: 10px;
        border: 1px solid gray;
      }
      .token-content {
        display: flex;
        justify-content: center;
        background-color: #1c262c;
        color: white;
        padding-block: 10px;
      }
      .tip {
        text-align: center;
        font-size: 20px;
        font-weight: 900;
      }
      .token {
        text-align: center;
        font-size: 30px;
        font-weight: 900;
      }
      .column {
        flex-direction: column;
        align-items: center;
      }
      .center {
        display: flex;
        justify-content: center;
      }
    </style>
  </head>
  <body>
    <div class="padding-setting">
      <p class="title">親愛的 COFFSEEKER 會員您好：</p>

      <div class="content">
        通知重設密碼所需要的驗證碼，<br />
        將以下6位驗證碼輸入於：<br />
        重設密碼頁面的《電子郵件驗證碼》欄位中。<br />
        <br />
        請注意驗證碼將於寄送後 30 分鐘後過期，<br />
        如有任何問題請洽 COFFSEEKER 客服人員
        <br />
        <br />
        <a href="mailto:coffseeker@gmail.com"
          >聯絡客服人員 >> coffseeker@gmail.com</a
        >
      </div>

      <div class="token-content">
        <div class="column">
          <div class="tip">請輸入以下的6位數字：</div>
          <div class="token">${otpToken}</div>
        </div>
      </div>

      <p>敬上</p>
      <p>COFFSEEKER 探索咖啡</p>
      <div class="center">
        <img
          src="https://i.imgur.com/oaBZVxk.png"
          alt="COFFSEEKER Logo"
          width="300"
        />
      </div>
    </div>
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
