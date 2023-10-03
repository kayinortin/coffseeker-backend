import mysql from 'mysql2/promise.js'
import 'dotenv/config.js'

// 資料庫連結資訊
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USERNAME,
  port: process.env.DB_PORT,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  dateStrings: true,
})

// 啟動時測試連線
pool
  .getConnection()
  .then((connection) => {
    console.log('Database Connected Successfully'.bgGreen)
    connection.release()
  })
  .catch((error) => {
    console.log('Database Connection Failed'.bgRed)
    console.log(error)
  })

export default pool
