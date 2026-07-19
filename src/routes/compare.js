const router = require('express').Router();
const productService = require('../services/productService');
const asyncHandler = require('../utils/asyncHandler');
router.get('/', asyncHandler(async (req,res)=>{
 const ids=(req.query.ids || '').split(',').map(x=>Number(x)).filter(Boolean).slice(0,4);
 const products=[];
 for(const id of ids){ const p=await productService.findById(id); if(p) products.push(p); }
 res.render('compare/index',{title:'So sánh sản phẩm',products});
}));
module.exports=router;
