const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAuth } = require('../middleware/auth');
router.get('/', requireAuth, asyncHandler(async (req,res)=>{
 const items=(await db.query('SELECT wr.*, p.productname FROM warrantyrequests wr LEFT JOIN products p ON p.productid=wr.productid WHERE wr.userid=$1 ORDER BY wr.createdat DESC NULLS LAST',[req.session.user.userid])).rows;
 res.render('warranty/index',{title:'Bảo hành / đổi trả',items});
}));
router.get('/create', requireAuth, asyncHandler(async (req,res)=>{
 const products=(await db.query('SELECT productid, productname FROM products ORDER BY productname LIMIT 200')).rows;
 res.render('warranty/create',{title:'Gửi yêu cầu bảo hành',products,query:req.query});
}));
router.post('/create', requireAuth, asyncHandler(async(req,res)=>{
 await db.query('INSERT INTO warrantyrequests(userid,orderid,productid,requesttype,status,reason,createdat,updatedat) VALUES($1,$2,$3,$4,$5,$6,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)',[req.session.user.userid,req.body.orderid||null,req.body.productid||null,req.body.requesttype||'Warranty','Pending',req.body.reason]);
 req.flash('success','Đã gửi yêu cầu.'); res.redirect('/warranty');
}));
module.exports=router;
