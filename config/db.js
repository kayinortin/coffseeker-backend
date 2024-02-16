import mysql from 'mysql2/promise.js'
import 'dotenv/config.js'

// 資料庫連結資訊
const pool = mysql.createPool(process.env.DATABASE_URL)

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
