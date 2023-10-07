import pool from '../config/db.js'

const checkProductCategory = async (product_id, category_id) => {
  const [checkCategory] = await pool.execute(
    'SELECT coffseeker_db.product.id, coffseeker_db.product_category.id FROM coffseeker_db.product INNER JOIN product_category ON product.product_category = product_category.id WHERE product.id = ? AND product_category.id = ?',
    [product_id, category_id]
  )
  console.log(checkCategory)
  return checkCategory
}
export { checkProductCategory }
