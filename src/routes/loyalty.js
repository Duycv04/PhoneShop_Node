const router=require('express').Router(); const db=require('../config/db'); const asyncHandler=require('../utils/asyncHandler'); const {requireAuth}=require('../middleware/auth');
router.get('/', requireAuth, asyncHandler(async(req,res)=>{ const items=(await db.query('SELECT * FROM loyaltypointtransactions WHERE userid=$1 ORDER BY createdat DESC NULLS LAST',[req.session.user.userid]).catch(()=>({rows:[]}))).rows; const points=items.reduce((s,x)=>s+Number(x.points||0),0); res.render('loyalty/index',{title:'Điểm thành viên',items,points}); }));
module.exports=router;
