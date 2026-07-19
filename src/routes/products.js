const router = require('express').Router();
const db = require('../config/db');
const productService = require('../services/productService');
const asyncHandler = require('../utils/asyncHandler');

router.get('/', asyncHandler(async (req, res) => {
  const page = Math.max(Number(req.query.page || 1), 1);
  const pageSize = 12;
  const [data, categories, brands] = await Promise.all([
    productService.listProducts({ q: req.query.q, categoryId: req.query.categoryId, brandId: req.query.brandId, sort: req.query.sort, page, pageSize }),
    productService.categories(),
    productService.brands(),
  ]);
  res.render('products/index', { title: 'Sản phẩm', ...data, categories, brands, query: req.query, totalPages: Math.ceil(data.total / pageSize) });
}));

router.get('/suggest', asyncHandler(async (req, res) => {
  const q = `%${req.query.term || req.query.q || ''}%`;
  const result = await db.query('SELECT productid, productname, imageurl, price FROM products WHERE COALESCE(isactive,true)=true AND productname ILIKE $1 ORDER BY productname LIMIT 8', [q]);
  res.json(result.rows);
}));

router.get('/:id', asyncHandler(async (req, res) => {
  const product = await productService.findById(req.params.id);
  if (!product) return res.status(404).render('error', { title: 'Không tìm thấy', message: 'Không tìm thấy sản phẩm.', detail: '' });
  await db.query('INSERT INTO productviews(productid, userid, sessionid, ipaddress, createdat) VALUES($1,$2,$3,$4,CURRENT_TIMESTAMP)', [product.productid, req.session.user?.userid || null, req.sessionID, req.ip]).catch(() => {});
  const related = (await productService.listProducts({ categoryId: product.categoryid, page: 1, pageSize: 4 })).products.filter(x => x.productid !== product.productid);
  res.render('products/details', { title: product.productname, product, related });
}));

router.post('/:id/question', asyncHandler(async (req, res) => {
  if (!req.session.user) {
    req.flash('error', 'Bạn cần đăng nhập để đặt câu hỏi.');
    return res.redirect('/account/login');
  }
  await db.query('INSERT INTO productquestions(productid, userid, question, status, isvisible, createdat) VALUES($1,$2,$3,$4,true,CURRENT_TIMESTAMP)', [req.params.id, req.session.user.userid, req.body.question, 'Pending']);
  req.flash('success', 'Đã gửi câu hỏi cho admin.');
  res.redirect(`/products/${req.params.id}`);
}));

router.post('/:id/review', asyncHandler(async (req, res) => {
  if (!req.session.user) {
    req.flash('error', 'Bạn cần đăng nhập để đánh giá.');
    return res.redirect('/account/login');
  }
  await db.query('INSERT INTO reviews(productid, userid, rating, comment, createdat) VALUES($1,$2,$3,$4,CURRENT_TIMESTAMP)', [req.params.id, req.session.user.userid, Number(req.body.rating), req.body.comment]);
  req.flash('success', 'Cảm ơn bạn đã đánh giá sản phẩm.');
  res.redirect(`/products/${req.params.id}`);
}));

module.exports = router;
