function money(value) {
  const n = Number(value || 0);
  return n.toLocaleString('vi-VN') + ' đ';
}

function date(value) {
  if (!value) return '';
  return new Date(value).toLocaleDateString('vi-VN');
}

function datetime(value) {
  if (!value) return '';
  return new Date(value).toLocaleString('vi-VN');
}

function salePrice(product) {
  const price = Number(product.price || 0);
  if (product.saleprice) return Number(product.saleprice);
  if (product.discountpercent) return Math.round(price * (100 - Number(product.discountpercent)) / 100);
  return price;
}

function short(text, length = 120) {
  if (!text) return '';
  return text.length > length ? text.slice(0, length).trim() + '...' : text;
}

module.exports = { money, date, datetime, salePrice, short };
