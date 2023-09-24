import nodemailer from 'nodemailer'
import 'dotenv/config.js'

let transport = null

// 定義所有email的寄送伺服器位置
transport = {
  host: 'smtp.gmail.com',
  port: 465,
  secure: true,
  auth: {
    user: process.env.SMTP_TO_EMAIL,
    pass: process.env.SMTP_TO_PASSWORD,
  },
}

const transporter = nodemailer.createTransport(transport)

// 驗證連線設定
transporter.verify((error, success) => {
  if (error) {
    console.error(error)
  } else {
    console.log('SMTP Server Connected. Ready to send mail!'.bgGreen)
  }
})

export default transporter
