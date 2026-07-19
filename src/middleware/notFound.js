function notFound(req, res) {
  res.status(404).render('error', {
    title: 'Không tìm thấy trang',
    message: 'Đường dẫn bạn truy cập không tồn tại.',
    detail: req.originalUrl,
  });
}

function errorHandler(err, req, res, next) {
  console.error(err);
  const message = err.code === '42P01'
    ? 'Database đang thiếu bảng. Hãy chạy đủ các file SQL nâng cấp Lan9 trong thư mục database trước khi chạy web.'
    : 'Có lỗi xảy ra khi xử lý yêu cầu.';
  res.status(500).render('error', {
    title: 'Lỗi hệ thống',
    message,
    detail: process.env.NODE_ENV === 'development' ? (err.stack || err.message) : err.message,
  });
}

module.exports = { notFound, errorHandler };
