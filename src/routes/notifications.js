const router = require('express').Router();
const db = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const { requireAuth } = require('../middleware/auth');
router.get('/', requireAuth, asyncHandler(async (req,res)=>{
 const items=(await db.query('SELECT * FROM notifications WHERE userid=$1 ORDER BY createdat DESC NULLS LAST LIMIT 100',[req.session.user.userid])).rows;
 await db.query('UPDATE notifications SET isread=true WHERE userid=$1',[req.session.user.userid]).catch(()=>{});
 res.render('notifications/index',{title:'Thông báo',items});
}));
module.exports=router;
