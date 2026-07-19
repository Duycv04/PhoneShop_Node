const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAuth } = require('../middleware/auth');

router.get('/', requireAuth, asyncHandler(async (req, res) => {
  const items = (await db.query(`SELECT w.*, p.productname, p.price, p.imageurl, b.brandname FROM wishlistitems w JOIN products p ON p.productid=w.productid LEFT JOIN brands b ON b.brandid=p.brandid WHERE w.userid=$1 ORDER BY w.createdat DESC NULLS LAST`, [req.session.user.userid])).rows;
  res.render('products/simple-list', { title: 'Sản phẩm yêu thích', products: items, emptyText: 'Bạn chưa có sản phẩm yêu thích.' });
}));
router.post('/toggle/:id', requireAuth, asyncHandler(async (req, res) => {
  const existed = await db.one('SELECT wishlistitemid FROM wishlistitems WHERE userid=$1 AND productid=$2', [req.session.user.userid, req.params.id]);
  if (existed) await db.query('DELETE FROM wishlistitems WHERE wishlistitemid=$1', [existed.wishlistitemid]);
  else await db.query('INSERT INTO wishlistitems(userid, productid, createdat) VALUES($1,$2,CURRENT_TIMESTAMP)', [req.session.user.userid, req.params.id]);
  res.redirect(req.get('referer') || '/wishlist');
}));
module.exports = router;
