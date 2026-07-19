const router = require('express').Router();
const { v4: uuidv4 } = require('uuid');
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { hashPassword, verifyPassword } = require('../utils/passwordHasher');
const { requireAuth } = require('../middleware/auth');

router.get('/login', (req, res) => res.render('account/login', { title: 'Đăng nhập', returnUrl: req.query.returnUrl || '/' }));

router.post('/login', asyncHandler(async (req, res) => {
  const { email, password, returnUrl } = req.body;
  const user = await db.one(`SELECT u.*, r.rolename FROM users u LEFT JOIN roles r ON r.roleid=u.roleid WHERE lower(u.email)=lower($1) AND COALESCE(u.isactive,true)=true`, [email]);
  if (!user || !(await verifyPassword(password, user.passwordhash))) {
    req.flash('error', 'Email hoặc mật khẩu không đúng.');
    return res.redirect('/account/login');
  }
  await db.query('UPDATE users SET lastloginat=CURRENT_TIMESTAMP WHERE userid=$1', [user.userid]).catch(() => null);
  req.session.user = { userid: user.userid, fullname: user.fullname, email: user.email, roleid: user.roleid, roleName: user.rolename };
  req.flash('success', 'Đăng nhập thành công.');
  res.redirect(returnUrl || '/');
}));

router.get('/register', (req, res) => res.render('account/register', { title: 'Đăng ký' }));

router.post('/register', asyncHandler(async (req, res) => {
  const { fullname, email, phone, password, confirmPassword } = req.body;
  if (password !== confirmPassword) {
    req.flash('error', 'Mật khẩu xác nhận không khớp.');
    return res.redirect('/account/register');
  }
  const existed = await db.one('SELECT userid FROM users WHERE lower(email)=lower($1)', [email]);
  if (existed) {
    req.flash('error', 'Email đã tồn tại.');
    return res.redirect('/account/register');
  }
  const role = await db.one("SELECT roleid FROM roles WHERE rolename='User' LIMIT 1");
  const passwordhash = await hashPassword(password);
  await db.query('INSERT INTO users(userid, fullname, email, phone, passwordhash, roleid, isactive, createdat) VALUES($1,$2,$3,$4,$5,$6,true,CURRENT_TIMESTAMP)', [uuidv4(), fullname, email, phone, passwordhash, role?.roleid || 2]);
  req.flash('success', 'Đăng ký thành công. Hãy đăng nhập.');
  res.redirect('/account/login');
}));

router.post('/logout', (req, res) => {
  req.session.destroy(() => res.redirect('/'));
});

router.get('/profile', requireAuth, asyncHandler(async (req, res) => {
  const user = await db.one('SELECT * FROM users WHERE userid=$1', [req.session.user.userid]);
  const addresses = (await db.query('SELECT * FROM useraddresses WHERE userid=$1 ORDER BY COALESCE(isdefault,false) DESC, addressid DESC', [req.session.user.userid]).catch(() => ({ rows: [] }))).rows;
  res.render('account/profile', { title: 'Tài khoản', user, addresses });
}));

router.post('/profile', requireAuth, asyncHandler(async (req, res) => {
  await db.query('UPDATE users SET fullname=$1, phone=$2, address=$3 WHERE userid=$4', [req.body.fullname, req.body.phone, req.body.address, req.session.user.userid]);
  req.session.user.fullname = req.body.fullname;
  req.flash('success', 'Đã cập nhật thông tin.');
  res.redirect('/account/profile');
}));

router.post('/address', requireAuth, asyncHandler(async (req, res) => {
  if (req.body.isdefault) await db.query('UPDATE useraddresses SET isdefault=false WHERE userid=$1', [req.session.user.userid]);
  await db.query('INSERT INTO useraddresses(userid, receivername, phone, address, isdefault) VALUES($1,$2,$3,$4,$5)', [req.session.user.userid, req.body.receivername, req.body.phone, req.body.address, !!req.body.isdefault]);
  req.flash('success', 'Đã thêm địa chỉ giao hàng.');
  res.redirect('/account/profile');
}));

module.exports = router;
