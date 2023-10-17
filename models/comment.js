import pool from '../config/db.js'

const getComment = async (product_id) => {
  const [commentData] = await pool.execute(
    'SELECT * FROM coffseeker_db.comments WHERE product_id = ? ORDER BY create_at DESC',
    [product_id]
  )
  return commentData
}

const checkOrder = async (product_id, user_id) => {
  // 將order_items 跟 order_details 透過order_items的order_id跟order_details的id做關聯
  const [checkResult] = await pool.execute(
    'SELECT coffseeker_db.order_product.product_id, coffseeker_db.order_details.user_id FROM coffseeker_db.order_product INNER JOIN order_details ON order_product.tracking_number = order_details.tracking_number WHERE product_id = ? AND user_id = ?',
    [product_id, user_id]
  )
  return checkResult
}

const addComment = async (
  product_id,
  user_id,
  user_email,
  user_name,
  comment,
  date,
  rating
) => {
  // 檢查是否已有同天同商品同一人的評論存在
  const [checkComment] = await pool.execute(
    'SELECT product_id, user_id FROM coffseeker_db.comments WHERE create_at = ? AND user_id = ? AND product_id = ?',
    [date, user_id, product_id]
  )
  if (checkComment.length !== 0) {
    return checkComment
  } else {
    const [newComment] = await pool.execute(
      'INSERT INTO coffseeker_db.comments (product_id, user_id, user_email, user_name, comment, create_at, rating) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [product_id, user_id, user_email, user_name, comment, date, rating]
    )
    return newComment
  }
}

export { getComment, checkOrder, addComment }
