const db = require('../config/db');

const productSelect = `
  SELECT p.productid, p.productname, p.price, p.quantity, p.description, p.imageurl, p.createdat,
         b.brandname, c.categoryname, c.categoryid, b.brandid,
         COALESCE(ROUND(AVG(r.rating)::numeric, 1), 0) AS average_rating,
         COUNT(DISTINCT r.reviewid)::int AS review_count,
         COUNT(DISTINCT pv.viewid)::int AS view_count,
         promo.saleprice, promo.discountpercent, promo.badgetext,
         CASE WHEN promo.saleprice IS NOT NULL THEN promo.saleprice
              WHEN promo.discountpercent IS NOT NULL THEN ROUND(p.price * (100 - promo.discountpercent) / 100, 0)
              ELSE p.price END AS finalprice
  FROM products p
  LEFT JOIN brands b ON b.brandid = p.brandid
  LEFT JOIN categories c ON c.categoryid = p.categoryid
  LEFT JOIN reviews r ON r.productid = p.productid
  LEFT JOIN productviews pv ON pv.productid = p.productid
  LEFT JOIN LATERAL (
      SELECT pp.saleprice, pp.discountpercent, pp.badgetext
      FROM productpromotions pp
      WHERE pp.productid = p.productid
        AND COALESCE(pp.isactive, true)=true
        AND (pp.startat IS NULL OR pp.startat <= CURRENT_TIMESTAMP)
        AND (pp.endat IS NULL OR pp.endat >= CURRENT_TIMESTAMP)
      ORDER BY pp.createdat DESC NULLS LAST, pp.promotionid DESC
      LIMIT 1
  ) promo ON true
`;

async function listProducts({ q, categoryId, brandId, sort = 'newest', page = 1, pageSize = 12 }) {
  const where = ['COALESCE(p.isactive, true)=true'];
  const params = [];
  if (q) {
    params.push(`%${q}%`);
    where.push(`(p.productname ILIKE $${params.length} OR p.description ILIKE $${params.length} OR b.brandname ILIKE $${params.length})`);
  }
  if (categoryId) { params.push(Number(categoryId)); where.push(`p.categoryid=$${params.length}`); }
  if (brandId) { params.push(Number(brandId)); where.push(`p.brandid=$${params.length}`); }
  const order = sort === 'price_asc' ? 'finalprice ASC' : sort === 'price_desc' ? 'finalprice DESC' : sort === 'popular' ? 'view_count DESC, p.createdat DESC' : 'p.createdat DESC';
  const offset = (Number(page) - 1) * Number(pageSize);
  const count = await db.one(`SELECT COUNT(*)::int AS total FROM products p LEFT JOIN brands b ON b.brandid=p.brandid WHERE ${where.join(' AND ')}`, params);
  params.push(Number(pageSize)); params.push(offset);
  const result = await db.query(`${productSelect} WHERE ${where.join(' AND ')} GROUP BY p.productid,b.brandname,c.categoryname,c.categoryid,b.brandid,promo.saleprice,promo.discountpercent,promo.badgetext ORDER BY ${order} LIMIT $${params.length-1} OFFSET $${params.length}`, params);
  return { products: result.rows, total: count.total, page: Number(page), pageSize: Number(pageSize) };
}

async function featured(take = 12) {
  const result = await db.query(`${productSelect} WHERE COALESCE(p.isactive, true)=true GROUP BY p.productid,b.brandname,c.categoryname,c.categoryid,b.brandid,promo.saleprice,promo.discountpercent,promo.badgetext ORDER BY p.createdat DESC NULLS LAST LIMIT $1`, [take]);
  return result.rows;
}

async function popular(take = 8) {
  const result = await db.query(`${productSelect} WHERE COALESCE(p.isactive, true)=true GROUP BY p.productid,b.brandname,c.categoryname,c.categoryid,b.brandid,promo.saleprice,promo.discountpercent,promo.badgetext ORDER BY view_count DESC, p.createdat DESC NULLS LAST LIMIT $1`, [take]);
  return result.rows;
}

async function findById(id) {
  const result = await db.one(`${productSelect} WHERE p.productid=$1 GROUP BY p.productid,b.brandname,c.categoryname,c.categoryid,b.brandid,promo.saleprice,promo.discountpercent,promo.badgetext`, [id]);
  if (!result) return null;
  result.images = (await db.query('SELECT * FROM productimages WHERE productid=$1 ORDER BY displayorder NULLS LAST, imageid', [id]).catch(() => ({ rows: [] }))).rows;
  result.specs = (await db.query(`SELECT s.specname, ps.specvalue FROM productspecifications ps JOIN specifications s ON s.specid=ps.specid WHERE ps.productid=$1 ORDER BY s.specname`, [id]).catch(() => ({ rows: [] }))).rows;
  result.reviews = (await db.query(`SELECT r.*, u.fullname FROM reviews r LEFT JOIN users u ON u.userid=r.userid WHERE r.productid=$1 ORDER BY r.createdat DESC NULLS LAST`, [id]).catch(() => ({ rows: [] }))).rows;
  result.questions = (await db.query(`SELECT q.*, u.fullname FROM productquestions q LEFT JOIN users u ON u.userid=q.userid WHERE q.productid=$1 AND COALESCE(q.isvisible,true)=true ORDER BY q.createdat DESC NULLS LAST`, [id]).catch(() => ({ rows: [] }))).rows;
  return result;
}

async function categories() {
  return (await db.query('SELECT categoryid, categoryname FROM categories ORDER BY categoryname')).rows;
}
async function brands() {
  return (await db.query('SELECT brandid, brandname FROM brands ORDER BY brandname')).rows;
}

module.exports = { listProducts, featured, popular, findById, categories, brands };
