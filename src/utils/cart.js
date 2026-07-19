function getCart(req) {
  if (!req.session.cart) req.session.cart = [];
  return req.session.cart;
}

function cartCount(req) {
  return getCart(req).reduce((sum, item) => sum + Number(item.quantity || 0), 0);
}

function addToCart(req, product, quantity = 1) {
  const cart = getCart(req);
  const id = Number(product.productid);
  const found = cart.find(x => Number(x.productid) === id);
  const price = Number(product.finalprice || product.saleprice || product.price || 0);
  if (found) found.quantity += Number(quantity || 1);
  else cart.push({
    productid: id,
    productname: product.productname,
    imageurl: product.imageurl,
    price,
    quantity: Number(quantity || 1),
  });
  req.session.cart = cart;
}

function updateCart(req, productid, quantity) {
  const cart = getCart(req);
  const q = Number(quantity || 0);
  req.session.cart = q <= 0 ? cart.filter(x => Number(x.productid) !== Number(productid)) : cart.map(x => Number(x.productid) === Number(productid) ? { ...x, quantity: q } : x);
}

function cartTotal(req) {
  return getCart(req).reduce((sum, item) => sum + Number(item.price || 0) * Number(item.quantity || 0), 0);
}

module.exports = { getCart, cartCount, addToCart, updateCart, cartTotal };
