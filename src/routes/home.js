const router = require('express').Router();
const db = require('../config/db');
const productService = require('../services/productService');
const asyncHandler = require('../utils/asyncHandler');

router.get('/', asyncHandler(async (req, res) => {
  const [featured, popular, categories, brands] = await Promise.all([
    productService.featured(12),
    productService.popular(8),
    productService.categories(),
    productService.brands(),
  ]);
  const banners = (await db.query(`SELECT * FROM homepagebanners WHERE COALESCE(isactive,true)=true AND (startat IS NULL OR startat <= CURRENT_TIMESTAMP) AND (endat IS NULL OR endat >= CURRENT_TIMESTAMP) ORDER BY displayorder NULLS LAST, createdat DESC NULLS LAST LIMIT 5`).catch(() => ({ rows: [] }))).rows;
  const bundles = (await db.query(`SELECT * FROM productbundles WHERE COALESCE(isactive,true)=true ORDER BY displayorder NULLS LAST, createdat DESC NULLS LAST LIMIT 3`).catch(() => ({ rows: [] }))).rows;
  const articles = (await db.query(`SELECT a.*, cc.categoryname FROM newsarticles a LEFT JOIN contentcategories cc ON cc.categoryid=a.categoryid WHERE COALESCE(a.ispublished,true)=true ORDER BY COALESCE(a.publishedat,a.createdat) DESC NULLS LAST LIMIT 3`).catch(() => ({ rows: [] }))).rows;
  res.render('home/index', { title: 'Trang chủ', featured, popular, categories, brands, banners, bundles, articles });
}));

router.get('/privacy', (req, res) => res.render('home/privacy', { title: 'Chính sách' }));

module.exports = router;
