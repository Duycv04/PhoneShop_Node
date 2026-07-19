const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAuth } = require('../middleware/auth');
const { getCart, addToCart, updateCart, cartTotal } = require('../utils/cart');
const productService = require('../services/productService');

router.get('/', (req, res) => res.render('cart/index', { title: 'Giỏ hàng', cart: getCart(req), total: cartTotal(req) }));

router.post('/add/:id', asyncHandler(async (req, res) => {
  const product = await productService.findById(req.params.id);
  if (!product) return res.redirect('/products');
  addToCart(req, product, Number(req.body.quantity || 1));
  req.flash('success', 'Đã thêm vào giỏ hàng.');
  res.redirect(req.get('referer') || '/cart');
}));

router.post('/update/:id', (req, res) => {
  updateCart(req, req.params.id, req.body.quantity);
  req.flash('success', 'Đã cập nhật giỏ hàng.');
  res.redirect('/cart');
});

router.post('/remove/:id', (req, res) => {
  updateCart(req, req.params.id, 0);
  res.redirect('/cart');
});

router.get('/checkout', requireAuth, asyncHandler(async (req, res) => {
  const cart = getCart(req);
  if (!cart.length) {
    req.flash('error', 'Giỏ hàng đang trống.');
    return res.redirect('/cart');
  }
  const address = await db.one('SELECT * FROM useraddresses WHERE userid=$1 ORDER BY COALESCE(isdefault,false) DESC, addressid DESC LIMIT 1', [req.session.user.userid]).catch(() => null);
  res.render('cart/checkout', { title: 'Thanh toán', cart, total: cartTotal(req), address });
}));

router.post('/checkout', requireAuth, asyncHandler(async (req, res) => {
  const cart = getCart(req);
  if (!cart.length) return res.redirect('/cart');
  const client = await db.pool.connect();
  try {
    await client.query('BEGIN');
    let subtotal = cartTotal(req);
    let discount = 0;
    let voucherid = null;
    if (req.body.voucherCode) {
      const voucher = (await client.query('SELECT * FROM vouchers WHERE upper(code)=upper($1) AND (expiredat IS NULL OR expiredat >= CURRENT_TIMESTAMP) AND COALESCE(quantity,1) > 0 LIMIT 1', [req.body.voucherCode])).rows[0];
      if (voucher) {
        voucherid = voucher.voucherid;
        discount = Math.min(subtotal * Number(voucher.discountpercent || 0) / 100, Number(voucher.maxdiscount || subtotal));
        await client.query('UPDATE vouchers SET quantity=GREATEST(COALESCE(quantity,0)-1,0) WHERE voucherid=$1', [voucherid]);
      }
    }
    const total = Math.max(subtotal - discount, 0);
    const code = 'PSN' + Date.now();
    const order = (await client.query(`INSERT INTO orders(userid, ordercode, totalamount, status, paymentmethod, voucherid, receivername, receiverphone, shippingaddress, note, subtotalamount, discountamount, createdat)
      VALUES($1,$2,$3,'Pending',$4,$5,$6,$7,$8,$9,$10,$11,CURRENT_TIMESTAMP) RETURNING orderid`, [req.session.user.userid, code, total, req.body.paymentmethod || 'COD', voucherid, req.body.receivername, req.body.receiverphone, req.body.shippingaddress, req.body.note, subtotal, discount])).rows[0];
    for (const item of cart) {
      await client.query('INSERT INTO orderdetails(orderid, productid, quantity, price) VALUES($1,$2,$3,$4)', [order.orderid, item.productid, item.quantity, item.price]);
      await client.query('UPDATE products SET quantity=GREATEST(COALESCE(quantity,0)-$1,0) WHERE productid=$2', [item.quantity, item.productid]);
      await client.query('INSERT INTO stockmovements(productid, userid, movementtype, quantitychange, note, createdat) VALUES($1,$2,$3,$4,$5,CURRENT_TIMESTAMP)', [item.productid, req.session.user.userid, 'Order', -Math.abs(item.quantity), `Đơn hàng ${code}`]).catch(() => {});
    }
    await client.query('INSERT INTO notifications(userid,title,message,type,targeturl,createdat) VALUES($1,$2,$3,$4,$5,CURRENT_TIMESTAMP)', [req.session.user.userid, 'Đặt hàng thành công', `Đơn hàng ${code} đã được tạo.`, 'Order', `/orders/${order.orderid}`]).catch(() => {});
    await client.query('COMMIT');
    req.session.cart = [];
    req.flash('success', 'Đặt hàng thành công.');
    res.redirect(`/orders/${order.orderid}`);
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}));

module.exports = router;
