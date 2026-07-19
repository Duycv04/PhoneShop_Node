const db = require('../config/db');
module.exports = async function dbCheck(req, res, next) {
  try {
    const tables = ['products','categories','brands','homepagebanners','productpromotions','productbundles','newsarticles','faqitems','orders','users','notifications'];
    const result = [];
    for (const table of tables) {
      const row = await db.one('SELECT to_regclass($1) AS name', [`public.${table}`]);
      result.push({ table, exists: !!row.name });
    }
    res.render('admin/db-check', { title: 'Kiểm tra database', result });
  } catch (err) { next(err); }
};
