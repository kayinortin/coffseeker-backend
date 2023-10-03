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

// 以上為導入區，以下為使用區
const app = express()

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
