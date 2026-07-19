function currentUser(req, res, next) {
  res.locals.currentUser = req.session.user || null;
  res.locals.isAuthenticated = !!req.session.user;
  res.locals.isAdmin = req.session.user?.roleName === 'Admin' || req.session.user?.roleid === 1;
  next();
}

function requireAuth(req, res, next) {
  if (!req.session.user) {
    req.flash('error', 'Bạn cần đăng nhập để sử dụng chức năng này.');
    return res.redirect('/account/login?returnUrl=' + encodeURIComponent(req.originalUrl));
  }
  next();
}

function requireAdmin(req, res, next) {
  const isAdmin = req.session.user?.roleName === 'Admin' || req.session.user?.roleid === 1;
  if (!isAdmin) {
    req.flash('error', 'Bạn không có quyền truy cập trang quản trị.');
    return res.redirect('/account/login');
  }
  next();
}

module.exports = { currentUser, requireAuth, requireAdmin };
