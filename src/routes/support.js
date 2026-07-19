const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
router.get('/', (req,res)=>res.render('support/index',{title:'Trung tâm hỗ trợ'}));
router.post('/', asyncHandler(async (req,res)=>{
 await db.query('INSERT INTO supporttickets(userid,fullname,email,phone,subject,message,status,createdat,updatedat) VALUES($1,$2,$3,$4,$5,$6,$7,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)',[req.session.user?.userid||null,req.body.fullname,req.body.email,req.body.phone,req.body.subject,req.body.message,'Open']);
 req.flash('success','Đã gửi yêu cầu hỗ trợ.'); res.redirect('/support/my-tickets');
}));
router.get('/my-tickets', asyncHandler(async (req,res)=>{
 const email=req.query.email || req.session.user?.email;
 const tickets=email?(await db.query('SELECT * FROM supporttickets WHERE lower(email)=lower($1) ORDER BY createdat DESC NULLS LAST',[email])).rows:[];
 res.render('support/my-tickets',{title:'Ticket hỗ trợ',tickets,email});
}));
router.get('/warranty-policy',(req,res)=>res.render('support/warranty-policy',{title:'Chính sách bảo hành'}));
module.exports=router;
