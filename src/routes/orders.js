const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAuth } = require('../middleware/auth');

router.get('/', requireAuth, asyncHandler(async (req, res) => {
  const orders = (await db.query('SELECT * FROM orders WHERE userid=$1 ORDER BY createdat DESC NULLS LAST', [req.session.user.userid])).rows;
  res.render('orders/index', { title: 'Đơn hàng của tôi', orders });
}));

router.get('/history', requireAuth, (req, res) => res.redirect('/orders'));

router.get('/:id', requireAuth, asyncHandler(async (req, res) => {
  const order = await db.one('SELECT * FROM orders WHERE orderid=$1 AND userid=$2', [req.params.id, req.session.user.userid]);
  if (!order) return res.status(404).render('error', { title: 'Không tìm thấy', message: 'Không tìm thấy đơn hàng.', detail: '' });
  const items = (await db.query('SELECT od.*, p.productname, p.imageurl FROM orderdetails od LEFT JOIN products p ON p.productid=od.productid WHERE od.orderid=$1', [order.orderid])).rows;
  const shipments = (await db.query('SELECT os.*, sp.providername FROM ordershipments os LEFT JOIN shippingproviders sp ON sp.providerid=os.providerid WHERE os.orderid=$1', [order.orderid]).catch(() => ({ rows: [] }))).rows;
  const payments = (await db.query('SELECT * FROM paymenttransactions WHERE orderid=$1 ORDER BY createdat DESC NULLS LAST', [order.orderid]).catch(() => ({ rows: [] }))).rows;
  res.render('orders/details', { title: `Đơn hàng ${order.ordercode}`, order, items, shipments, payments });
}));

router.post('/:id/cancel', requireAuth, asyncHandler(async (req, res) => {
  const order = await db.one("SELECT * FROM orders WHERE orderid=$1 AND userid=$2 AND status IN ('Pending','Confirmed')", [req.params.id, req.session.user.userid]);
  if (!order) {
    req.flash('error', 'Đơn hàng không thể hủy.');
    return res.redirect('/orders');
  }
  await db.query("UPDATE orders SET status='Cancelled' WHERE orderid=$1", [order.orderid]);
  req.flash('success', 'Đã gửi hủy đơn hàng.');
  res.redirect(`/orders/${order.orderid}`);
}));

module.exports = router;
