const db = require('../config/db');
const { cartCount } = require('../utils/cart');

module.exports = async function layoutData(req, res, next) {
  res.locals.flash = {
    success: req.flash('success'),
    error: req.flash('error'),
    info: req.flash('info'),
  };
  res.locals.cartCount = cartCount(req);
  res.locals.categories = [];
  res.locals.unreadCount = 0;
  try {
    const cats = await db.query('SELECT categoryid, categoryname FROM categories ORDER BY categoryname LIMIT 24');
    res.locals.categories = cats.rows;
    if (req.session.user) {
      const unread = await db.one('SELECT COUNT(*)::int AS count FROM notifications WHERE userid=$1 AND COALESCE(isread,false)=false', [req.session.user.userid]).catch(() => ({ count: 0 }));
      res.locals.unreadCount = unread?.count || 0;
    }
  } catch {
    // Nếu database chưa nâng cấp đủ, trang lỗi chính sẽ hiển thị hướng dẫn ở error handler.
  }
  next();
};
