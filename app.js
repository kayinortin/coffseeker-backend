import createError from 'http-errors'
import express from 'express'
import path from 'path'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import cors from 'cors'
import session from 'express-session'
// 使用檔案的session store，存在sessions資料夾
import sessionFileStore from 'session-file-store'
const FileStore = sessionFileStore(session)

import { fileURLToPath } from 'url'
const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

import { extendLog } from './utils/tool.js'
extendLog()
import 'colors'

// 檔案上傳
import fileUpload from 'express-fileupload'

// 以下對應路由函數導入
// 會員驗證jwt登入
import authJwtRouter from './routes/auth-jwt.js'
// 會員驗證session登入
import authRouter from './routes/auth.js'
// 寄送email
import emailRouter from './routes/email.js'
// 後端首頁 (pug渲染呈現)
import indexRouter from './routes/index.js'
// 導入產品路由
import productsRouter from './routes/products.js'
// 導入熱門產品路由
import popularProductsRouter from './routes/popular-products.js'
// 導入重設密碼路由
import resetPasswordRouter from './routes/reset-password.js'
// 導入會員路由
import usersRouter from './routes/users.js'
// 導入google登入路由
import googleLoginRouter from './routes/google-login.js'
// 導入line登入路由
import lineLoginRouter from './routes/line-login.js'
// 導入facebook登入路由
import facebookLoginRouter from './routes/facebook-login.js'
// 導入favorite路由
import favoriteRouter from './routes/favorite.js'
import orderRouter from './routes/order.js'
// 導入checkcategory路由
import checkCategoryRouter from './routes/checkcategory.js'
// 導入comment路由
import commentRouter from './routes/comment.js'
import newsRouter from './routes/news.js'
import courseRouter from './routes/course.js'
import couponRouter from './routes/coupons.js'
import courseComment from './routes/course-comment.js'
import ordercartRouter from './routes/ordercart.js'
// 以上為導入區，以下為使用區
const app = express()

// FB Messenger Bot
// Adds support for GET requests to our webhook
app.get('/webhook', (req, res) => {
  // Your verify token. Should be a random string.
  const VERIFY_TOKEN = '1234'
  // Parse the query params
  let mode = req.query['hub.mode']
  let token = req.query['hub.verify_token']
  let challenge = req.query['hub.challenge']
  // Checks if a token and mode is in the query string of the request
  if (mode && token) {
    // Checks the mode and token sent is correct
    if (mode === 'subscribe' && token === VERIFY_TOKEN) {
      // Responds with the challenge token from the request
      console.log('WEBHOOK_VERIFIED')
      res.status(200).send(challenge)
    } else {
      // Responds with '403 Forbidden' if verify tokens do not match
      res.sendStatus(403)
    }
  }
})
// Creates the endpoint for your webhook
app.post('/webhook', (req, res) => {
  let body = req.body

  // Checks if this is an event from a page subscription
  if (body.object === 'page') {
    // Iterates over each entry - there may be multiple if batched
    body.entry.forEach(function (entry) {
      // Gets the body of the webhook event
      let webhookEvent = entry.messaging[0]
      console.log(webhookEvent)

      // Get the sender PSID
      let senderPsid = webhookEvent.sender.id
      console.log('Sender PSID: ' + senderPsid)

      // Check if the event is a message or postback and
      // pass the event to the appropriate handler function
      if (webhookEvent.message) {
        handleMessage(senderPsid, webhookEvent.message)
      } else if (webhookEvent.postback) {
        handlePostback(senderPsid, webhookEvent.postback)
      }
    })

    // Returns a '200 OK' response to all requests
    res.status(200).send('EVENT_RECEIVED')
  } else {
    // Returns a '404 Not Found' if event is not from a page subscription
    res.sendStatus(404)
  }
})
// Handles messages events
function handleMessage(senderPsid, receivedMessage) {
  let response

  // Checks if the message contains text
  if (receivedMessage.text) {
    // Create the payload for a basic text message, which
    // will be added to the body of your request to the Send API
    response = {
      text: `You sent the message: '${receivedMessage.text}'. Now send me an attachment!`,
    }
  } else if (receivedMessage.attachments) {
    // Get the URL of the message attachment
    let attachmentUrl = receivedMessage.attachments[0].payload.url
    response = {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          elements: [
            {
              title: 'Is this the right picture?',
              subtitle: 'Tap a button to answer.',
              image_url: attachmentUrl,
              buttons: [
                {
                  type: 'postback',
                  title: 'Yes!',
                  payload: 'yes',
                },
                {
                  type: 'postback',
                  title: 'No!',
                  payload: 'no',
                },
              ],
            },
          ],
        },
      },
    }
  }

  // Send the response message
  callSendAPI(senderPsid, response)
}
// Handles messaging_postbacks events
function handlePostback(senderPsid, receivedPostback) {
  let response

  // Get the payload for the postback
  let payload = receivedPostback.payload

  // Set the response based on the postback payload
  if (payload === 'yes') {
    response = { text: 'Thanks!' }
  } else if (payload === 'no') {
    response = { text: 'Oops, try sending another image.' }
  }
  // Send the message to acknowledge the postback
  callSendAPI(senderPsid, response)
}
// Sends response messages via the Send API
function callSendAPI(senderPsid, response) {
  // The page access token we have generated in your app settings
  const PAGE_ACCESS_TOKEN = process.env.PAGE_ACCESS_TOKEN

  // Construct the message body
  let requestBody = {
    recipient: {
      id: senderPsid,
    },
    message: response,
  }

  // Send the HTTP request to the Messenger Platform
  request(
    {
      uri: 'https://graph.facebook.com/v2.6/me/messages',
      qs: { access_token: PAGE_ACCESS_TOKEN },
      method: 'POST',
      json: requestBody,
    },
    (err, _res, _body) => {
      if (!err) {
        console.log('Message sent!')
      } else {
        console.error('Unable to send message:' + err)
      }
    }
  )
}

// 檔案上傳
// 選項參考: https://github.com/richardgirges/express-fileupload
app.use(fileUpload())

// 圖片讀取
app.use('/uploads', express.static(path.join(__dirname, 'uploads')))

// 可以使用的CORS要求，options必要
// app.use(cors())
app.use(
  cors({
    origin: ['http://localhost:3000', 'https://localhost:9000'],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
  })
)

// view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'pug')
app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

// fileStore的選項
const fileStoreOptions = {}
// session-cookie使用
app.use(
  session({
    store: new FileStore(fileStoreOptions), // 使用檔案記錄session
    name: 'SESSION_ID', // cookie名稱，儲存在瀏覽器裡
    secret: '67f71af4602195de2450faeb6f8856c0',
    cookie: {
      maxAge: 30 * 86400000, // session保存30天
      // httpOnly: false,
      // sameSite: 'none',
    },
    resave: false,
    saveUninitialized: false,
  })
)

// 路由使用
app.use('/api/', indexRouter)
app.use('/api/auth-jwt', authJwtRouter)
app.use('/api/auth', authRouter)
app.use('/api/email', emailRouter)
app.use('/api/products', productsRouter)
app.use('/api/popular-products', popularProductsRouter)
app.use('/api/reset-password', resetPasswordRouter)
app.use('/api/users', usersRouter)
app.use('/api/google-login', googleLoginRouter)
app.use('/api/line-login', lineLoginRouter)
app.use('/api/facebook-login', facebookLoginRouter)
app.use('/api/favorite', favoriteRouter)
app.use('/api/checkcategory', checkCategoryRouter)
app.use('/api/order', orderRouter)

app.use('/api/comment', commentRouter)
app.use('/api/news', newsRouter)
app.use('/api/course', courseRouter)
app.use('/api/coupons', couponRouter)
app.use('/api/course-comment', courseComment)
app.use('/api/ordercart', ordercartRouter)
// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404))
})

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}

  // render the error page
  res.status(err.status || 500)
  // 更改為錯誤訊息預設為JSON格式
  res.status(500).send({ error: err })
})

export default app
