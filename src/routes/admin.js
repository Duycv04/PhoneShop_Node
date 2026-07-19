const router = require('express').Router();
const { v4: uuidv4 } = require('uuid');
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAdmin } = require('../middleware/auth');
const { hashPassword } = require('../utils/passwordHasher');

router.use(requireAdmin);

router.get('/', asyncHandler(async (req, res) => {
  const stats = {};
  const tables = [
    ['products','products'], ['orders','orders'], ['users','users'], ['supporttickets','support'],
    ['warrantyrequests','warranty'], ['productbundles','bundles'], ['newsarticles','news'],
    ['homepagebanners','banners'], ['productpromotions','promotions']
  ];
  for (const [table, key] of tables) {
    stats[key] = (await db.one(`SELECT COUNT(*)::int AS count FROM ${table}`).catch(() => ({ count: 0 }))).count;
  }
  const revenue = await db.one("SELECT COALESCE(SUM(totalamount),0) AS total FROM orders WHERE status NOT IN ('Cancelled')").catch(() => ({ total: 0 }));
  const latestOrders = (await db.query('SELECT o.*, u.fullname FROM orders o LEFT JOIN users u ON u.userid=o.userid ORDER BY o.createdat DESC NULLS LAST LIMIT 8').catch(() => ({ rows: [] }))).rows;
  res.render('admin/dashboard', { title: 'Admin Dashboard', stats, revenue: revenue.total, latestOrders });
}));

router.get('/products', asyncHandler(async (req,res)=>{
  const products=(await db.query('SELECT p.*, b.brandname, c.categoryname FROM products p LEFT JOIN brands b ON b.brandid=p.brandid LEFT JOIN categories c ON c.categoryid=p.categoryid ORDER BY p.createdat DESC NULLS LAST LIMIT 200')).rows;
  const brands=(await db.query('SELECT * FROM brands ORDER BY brandname')).rows;
  const categories=(await db.query('SELECT * FROM categories ORDER BY categoryname')).rows;
  res.render('admin/products',{title:'Quản lý sản phẩm',products,brands,categories});
}));
router.post('/products', asyncHandler(async (req,res)=>{
  await db.query('INSERT INTO products(productname,price,quantity,description,imageurl,brandid,categoryid,isactive,createdat) VALUES($1,$2,$3,$4,$5,$6,$7,true,CURRENT_TIMESTAMP)',[req.body.productname,req.body.price||0,req.body.quantity||0,req.body.description,req.body.imageurl,req.body.brandid||null,req.body.categoryid||null]);
  req.flash('success','Đã thêm sản phẩm.'); res.redirect('/admin/products');
}));
router.post('/products/:id/delete', asyncHandler(async(req,res)=>{ await db.query('UPDATE products SET isactive=false WHERE productid=$1',[req.params.id]); req.flash('success','Đã ẩn sản phẩm.'); res.redirect('/admin/products'); }));

router.get('/categories', asyncHandler(async(req,res)=>{
  const items=(await db.query('SELECT c.*, COUNT(p.productid)::int productcount FROM categories c LEFT JOIN products p ON p.categoryid=c.categoryid GROUP BY c.categoryid ORDER BY c.categoryname')).rows;
  res.render('admin/categories',{title:'Danh mục sản phẩm',items});
}));
router.post('/categories', asyncHandler(async(req,res)=>{ await db.query('INSERT INTO categories(categoryname) VALUES($1)',[req.body.categoryname]); req.flash('success','Đã thêm danh mục.'); res.redirect('/admin/categories'); }));

router.get('/banners', asyncHandler(async(req,res)=>{
  const items=(await db.query('SELECT * FROM homepagebanners ORDER BY displayorder NULLS LAST, createdat DESC NULLS LAST').catch(()=>({rows:[]}))).rows;
  res.render('admin/banners',{title:'Banner trang chủ',items});
}));
router.post('/banners', asyncHandler(async(req,res)=>{ await db.query('INSERT INTO homepagebanners(title,subtitle,imageurl,targeturl,badgetext,displayorder,isactive,createdat) VALUES($1,$2,$3,$4,$5,$6,true,CURRENT_TIMESTAMP)',[req.body.title,req.body.subtitle,req.body.imageurl,req.body.targeturl,req.body.badgetext,req.body.displayorder||0]); req.flash('success','Đã thêm banner.'); res.redirect('/admin/banners'); }));

router.get('/promotions', asyncHandler(async(req,res)=>{
  const items=(await db.query('SELECT pp.*, p.productname FROM productpromotions pp LEFT JOIN products p ON p.productid=pp.productid ORDER BY pp.createdat DESC NULLS LAST').catch(()=>({rows:[]}))).rows;
  const products=(await db.query('SELECT productid, productname FROM products ORDER BY productname LIMIT 300')).rows;
  res.render('admin/promotions',{title:'Khuyến mãi',items,products});
}));
router.post('/promotions', asyncHandler(async(req,res)=>{ await db.query('INSERT INTO productpromotions(productid,title,badgetext,discountpercent,saleprice,startat,endat,isactive,createdat) VALUES($1,$2,$3,$4,$5,$6,$7,true,CURRENT_TIMESTAMP)',[req.body.productid,req.body.title,req.body.badgetext,req.body.discountpercent||null,req.body.saleprice||null,req.body.startat||null,req.body.endat||null]); req.flash('success','Đã thêm khuyến mãi.'); res.redirect('/admin/promotions'); }));


router.get('/users', asyncHandler(async (req, res) => {
  const q = (req.query.q || '').trim();
  const roleid = req.query.roleid || '';
  const status = req.query.status || 'all';
  const params = [];
  const where = ['1=1'];

  if (q) {
    params.push(`%${q.toLowerCase()}%`);
    where.push(`(
      LOWER(COALESCE(u.fullname,'')) LIKE $${params.length}
      OR LOWER(COALESCE(u.email,'')) LIKE $${params.length}
      OR COALESCE(u.phone,'') LIKE $${params.length}
    )`);
  }

  if (roleid) {
    params.push(roleid);
    where.push(`u.roleid = $${params.length}`);
  }

  if (status === 'active') where.push('COALESCE(u.isactive,true) = true');
  if (status === 'locked') where.push('COALESCE(u.isactive,true) = false');

  const users = (await db.query(`
    SELECT
      u.userid, u.fullname, u.email, u.phone, u.address, u.roleid,
      COALESCE(u.isactive,true) AS isactive,
      u.createdat, u.updatedat, u.lastloginat, u.lockedreason,
      r.rolename,
      (SELECT COUNT(*)::int FROM orders o WHERE o.userid = u.userid) AS ordercount,
      (SELECT COALESCE(SUM(o.totalamount),0) FROM orders o WHERE o.userid = u.userid AND COALESCE(o.status,'') <> 'Cancelled') AS totalspent
    FROM users u
    LEFT JOIN roles r ON r.roleid = u.roleid
    WHERE ${where.join(' AND ')}
    ORDER BY u.createdat DESC NULLS LAST, u.fullname ASC NULLS LAST
    LIMIT 300
  `, params)).rows;

  const roles = (await db.query('SELECT * FROM roles ORDER BY roleid').catch(() => ({ rows: [] }))).rows;
  const summary = {
    total: (await db.one('SELECT COUNT(*)::int AS count FROM users').catch(() => ({ count: 0 }))).count,
    active: (await db.one('SELECT COUNT(*)::int AS count FROM users WHERE COALESCE(isactive,true)=true').catch(() => ({ count: 0 }))).count,
    locked: (await db.one('SELECT COUNT(*)::int AS count FROM users WHERE COALESCE(isactive,true)=false').catch(() => ({ count: 0 }))).count,
    admins: (await db.one("SELECT COUNT(*)::int AS count FROM users u LEFT JOIN roles r ON r.roleid=u.roleid WHERE u.roleid=1 OR r.rolename='Admin'").catch(() => ({ count: 0 }))).count,
  };

  res.render('admin/users', {
    title: 'Quản lý người dùng',
    users,
    roles,
    summary,
    filters: { q, roleid, status }
  });
}));

router.get('/users/create', asyncHandler(async (req, res) => {
  const roles = (await db.query('SELECT * FROM roles ORDER BY roleid').catch(() => ({ rows: [] }))).rows;
  res.render('admin/user-form', {
    title: 'Thêm người dùng',
    mode: 'create',
    user: {},
    roles,
    defaultPassword: 'PhoneShop@123'
  });
}));

router.post('/users/create', asyncHandler(async (req, res) => {
  const existed = await db.one('SELECT userid FROM users WHERE lower(email)=lower($1)', [req.body.email]);
  if (existed) {
    req.flash('error', 'Email đã tồn tại.');
    return res.redirect('/admin/users/create');
  }

  const password = req.body.password || 'PhoneShop@123';
  const passwordhash = await hashPassword(password);
  await db.query(`
    INSERT INTO users(userid, fullname, email, phone, address, passwordhash, roleid, isactive, createdat, updatedat)
    VALUES($1,$2,$3,$4,$5,$6,$7,$8,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
  `, [
    uuidv4(),
    req.body.fullname,
    req.body.email,
    req.body.phone || null,
    req.body.address || null,
    passwordhash,
    req.body.roleid || 2,
    req.body.isactive === 'on'
  ]);

  req.flash('success', 'Đã tạo tài khoản người dùng.');
  res.redirect('/admin/users');
}));

router.get('/users/:id', asyncHandler(async (req, res) => {
  const user = await db.one('SELECT u.*, r.rolename FROM users u LEFT JOIN roles r ON r.roleid=u.roleid WHERE u.userid=$1', [req.params.id]);
  if (!user) return res.status(404).render('error', { title: 'Không tìm thấy', message: 'Không tìm thấy người dùng.', detail: '' });

  const orders = (await db.query('SELECT * FROM orders WHERE userid=$1 ORDER BY createdat DESC NULLS LAST LIMIT 50', [req.params.id]).catch(() => ({ rows: [] }))).rows;
  const addresses = (await db.query('SELECT * FROM useraddresses WHERE userid=$1 ORDER BY COALESCE(isdefault,false) DESC, addressid DESC LIMIT 20', [req.params.id]).catch(() => ({ rows: [] }))).rows;
  const wishlist = (await db.query('SELECT w.*, p.productname, p.price FROM wishlistitems w LEFT JOIN products p ON p.productid=w.productid WHERE w.userid=$1 ORDER BY w.createdat DESC NULLS LAST LIMIT 30', [req.params.id]).catch(() => ({ rows: [] }))).rows;
  const reviews = (await db.query('SELECT rv.*, p.productname FROM reviews rv LEFT JOIN products p ON p.productid=rv.productid WHERE rv.userid=$1 ORDER BY rv.createdat DESC NULLS LAST LIMIT 30', [req.params.id]).catch(() => ({ rows: [] }))).rows;
  const supportTickets = (await db.query('SELECT * FROM supporttickets WHERE userid=$1 ORDER BY createdat DESC NULLS LAST LIMIT 30', [req.params.id]).catch(() => ({ rows: [] }))).rows;

  res.render('admin/user-details', {
    title: 'Chi tiết người dùng',
    user,
    orders,
    addresses,
    wishlist,
    reviews,
    supportTickets
  });
}));

router.get('/users/:id/edit', asyncHandler(async (req, res) => {
  const user = await db.one('SELECT u.*, r.rolename FROM users u LEFT JOIN roles r ON r.roleid=u.roleid WHERE u.userid=$1', [req.params.id]);
  if (!user) return res.status(404).render('error', { title: 'Không tìm thấy', message: 'Không tìm thấy người dùng.', detail: '' });
  const roles = (await db.query('SELECT * FROM roles ORDER BY roleid').catch(() => ({ rows: [] }))).rows;
  res.render('admin/user-form', { title: 'Sửa người dùng', mode: 'edit', user, roles, defaultPassword: '' });
}));

router.post('/users/:id/edit', asyncHandler(async (req, res) => {
  let isactive = req.body.isactive === 'on';
  let roleid = req.body.roleid || 2;
  const isSelf = String(req.params.id) === String(req.session.user.userid);

  if (isSelf) {
    isactive = true;
    roleid = req.session.user.roleid;
  }

  await db.query(`
    UPDATE users
    SET fullname=$1, email=$2, phone=$3, address=$4, roleid=$5, isactive=$6, lockedreason=$7, updatedat=CURRENT_TIMESTAMP
    WHERE userid=$8
  `, [
    req.body.fullname,
    req.body.email,
    req.body.phone || null,
    req.body.address || null,
    roleid,
    isactive,
    isactive ? null : (req.body.lockedreason || 'Khóa bởi Admin'),
    req.params.id
  ]);

  if (isSelf) {
    req.session.user.fullname = req.body.fullname;
    req.session.user.email = req.body.email;
  }

  req.flash('success', isSelf ? 'Đã cập nhật tài khoản của bạn. Không thể tự khóa hoặc tự hạ quyền Admin.' : 'Đã cập nhật người dùng.');
  res.redirect('/admin/users/' + req.params.id);
}));

router.post('/users/:id/toggle-active', asyncHandler(async (req, res) => {
  if (String(req.params.id) === String(req.session.user.userid)) {
    req.flash('error', 'Bạn không thể tự khóa tài khoản đang đăng nhập.');
    return res.redirect('/admin/users');
  }

  const user = await db.one('SELECT userid, COALESCE(isactive,true) AS isactive FROM users WHERE userid=$1', [req.params.id]);
  if (!user) {
    req.flash('error', 'Không tìm thấy người dùng.');
    return res.redirect('/admin/users');
  }

  const nextActive = !user.isactive;
  await db.query('UPDATE users SET isactive=$1, lockedreason=$2, updatedat=CURRENT_TIMESTAMP WHERE userid=$3', [
    nextActive,
    nextActive ? null : (req.body.lockedreason || 'Khóa bởi Admin'),
    req.params.id
  ]);
  req.flash('success', nextActive ? 'Đã mở khóa tài khoản.' : 'Đã khóa tài khoản.');
  res.redirect(req.get('referer') || '/admin/users');
}));

router.post('/users/:id/reset-password', asyncHandler(async (req, res) => {
  const newPassword = req.body.newPassword || 'PhoneShop@123';
  const passwordhash = await hashPassword(newPassword);
  await db.query('UPDATE users SET passwordhash=$1, updatedat=CURRENT_TIMESTAMP WHERE userid=$2', [passwordhash, req.params.id]);
  req.flash('success', `Đã đặt lại mật khẩu. Mật khẩu mới: ${newPassword}`);
  res.redirect('/admin/users/' + req.params.id);
}));

router.get('/orders', asyncHandler(async(req,res)=>{
  const orders=(await db.query('SELECT o.*, u.fullname FROM orders o LEFT JOIN users u ON u.userid=o.userid ORDER BY o.createdat DESC NULLS LAST LIMIT 300')).rows;
  res.render('admin/orders',{title:'Quản lý đơn hàng',orders});
}));
router.post('/orders/:id/status', asyncHandler(async(req,res)=>{ await db.query('UPDATE orders SET status=$1 WHERE orderid=$2',[req.body.status,req.params.id]); req.flash('success','Đã cập nhật trạng thái đơn hàng.'); res.redirect('/admin/orders'); }));

router.get('/support', asyncHandler(async(req,res)=>{ const items=(await db.query('SELECT * FROM supporttickets ORDER BY createdat DESC NULLS LAST').catch(()=>({rows:[]}))).rows; res.render('admin/support',{title:'Ticket hỗ trợ',items}); }));
router.post('/support/:id/reply', asyncHandler(async(req,res)=>{ await db.query("UPDATE supporttickets SET adminreply=$1,status='Answered',repliedat=CURRENT_TIMESTAMP,updatedat=CURRENT_TIMESTAMP WHERE ticketid=$2",[req.body.adminreply,req.params.id]); req.flash('success','Đã phản hồi ticket.'); res.redirect('/admin/support'); }));

router.get('/warranty', asyncHandler(async(req,res)=>{ const items=(await db.query('SELECT wr.*, u.fullname, p.productname FROM warrantyrequests wr LEFT JOIN users u ON u.userid=wr.userid LEFT JOIN products p ON p.productid=wr.productid ORDER BY wr.createdat DESC NULLS LAST').catch(()=>({rows:[]}))).rows; res.render('admin/warranty',{title:'Bảo hành / đổi trả',items}); }));
router.post('/warranty/:id/status', asyncHandler(async(req,res)=>{ await db.query('UPDATE warrantyrequests SET status=$1,adminnote=$2,updatedat=CURRENT_TIMESTAMP WHERE warrantyrequestid=$3',[req.body.status,req.body.adminnote,req.params.id]); req.flash('success','Đã cập nhật yêu cầu.'); res.redirect('/admin/warranty'); }));

router.get('/reports', asyncHandler(async(req,res)=>{
  const revenueByDay=(await db.query("SELECT date_trunc('day', createdat)::date day, COALESCE(SUM(totalamount),0) revenue, COUNT(*) orders FROM orders GROUP BY 1 ORDER BY 1 DESC LIMIT 14").catch(()=>({rows:[]}))).rows;
  const topProducts=(await db.query('SELECT p.productname, SUM(od.quantity)::int sold FROM orderdetails od JOIN products p ON p.productid=od.productid GROUP BY p.productname ORDER BY sold DESC LIMIT 10').catch(()=>({rows:[]}))).rows;
  const lowStock=(await db.query('SELECT productid, productname, quantity FROM products WHERE COALESCE(quantity,0) <= 5 ORDER BY quantity ASC NULLS FIRST LIMIT 20').catch(()=>({rows:[]}))).rows;
  res.render('admin/reports',{title:'Báo cáo kinh doanh',revenueByDay,topProducts,lowStock});
}));

router.get('/table/:name', asyncHandler(async(req,res)=>{
  const allowed=['installmentrequests','tradeinrequests','refundrequests','ordershipments','pickupappointments','paymenttransactions','marketingcampaigns','faqitems','newsarticles','productbundles','adminactivitylogs','customerbehaviors'];
  if(!allowed.includes(req.params.name)) return res.status(404).render('error',{title:'Không hỗ trợ',message:'Bảng này chưa có trang quản trị nhanh.',detail:''});
  const rows=(await db.query(`SELECT * FROM ${req.params.name} ORDER BY 1 DESC LIMIT 200`).catch(()=>({rows:[]}))).rows;
  res.render('admin/generic',{title:req.params.name,rows,table:req.params.name});
}));

module.exports = router;
