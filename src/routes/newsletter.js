const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
router.post('/', asyncHandler(async (req,res)=>{
 await db.query('INSERT INTO newslettersubscribers(email, isactive, createdat) VALUES($1,true,CURRENT_TIMESTAMP) ON CONFLICT DO NOTHING',[req.body.email]).catch(()=>{});
 req.flash('success','Đã đăng ký nhận tin khuyến mãi.');
 res.redirect(req.get('referer') || '/');
}));
module.exports=router;
