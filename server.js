require('dotenv').config();

const express = require('express');
const path = require('path');
const session = require('express-session');
const flash = require('connect-flash');
const methodOverride = require('method-override');
const helmet = require('helmet');
const morgan = require('morgan');
const expressLayouts = require('express-ejs-layouts');

const { currentUser } = require('./src/middleware/auth');
const layoutData = require('./src/middleware/layoutData');
const { notFound, errorHandler } = require('./src/middleware/notFound');
const format = require('./src/utils/format');

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));
app.use(expressLayouts);
app.set('layout', 'layouts/main');

app.use(helmet({ contentSecurityPolicy: false }));
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: process.env.SESSION_SECRET || 'phoneshop-node-secret',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 1000 * 60 * 60 * 24 * 7 }
}));
app.use(flash());
app.use(currentUser);
app.use(layoutData);

app.locals.format = format;
app.locals.appName = 'PhoneShop Node';

app.use('/', require('./src/routes/home'));
app.use('/products', require('./src/routes/products'));
app.use('/product', require('./src/routes/products')); // alias giống bản C#
app.use('/cart', require('./src/routes/cart'));
app.use('/account', require('./src/routes/account'));
app.use('/orders', require('./src/routes/orders'));
app.use('/order', require('./src/routes/orders'));
app.use('/wishlist', require('./src/routes/wishlist'));
app.use('/compare', require('./src/routes/compare'));
app.use('/notifications', require('./src/routes/notifications'));
app.use('/notification', require('./src/routes/notifications'));
app.use('/support', require('./src/routes/support'));
app.use('/warranty', require('./src/routes/warranty'));
app.use('/installment', require('./src/routes/installment'));
app.use('/tradein', require('./src/routes/tradein'));
app.use('/shipping', require('./src/routes/shipping'));
app.use('/refund', require('./src/routes/refund'));
app.use('/store', require('./src/routes/store'));
app.use('/bundle', require('./src/routes/bundle'));
app.use('/news', require('./src/routes/news'));
app.use('/chatbot', require('./src/routes/chatbot'));
app.use('/loyalty', require('./src/routes/loyalty'));
app.use('/newsletter', require('./src/routes/newsletter'));
app.use('/admin', require('./src/routes/admin'));

app.get('/db-check', require('./src/routes/dbCheck'));

app.use(notFound);
app.use(errorHandler);

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`PhoneShop Node Express đang chạy: http://localhost:${port}`);
});
