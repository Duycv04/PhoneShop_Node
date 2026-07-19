(function(){
  const key='phoneshop_compare_ids';
  document.querySelectorAll('.js-compare').forEach(btn=>btn.addEventListener('click',()=>{
    const id=btn.dataset.id; let ids=JSON.parse(localStorage.getItem(key)||'[]');
    if(ids.includes(id)) ids=ids.filter(x=>x!==id); else ids.push(id);
    ids=ids.slice(-4); localStorage.setItem(key,JSON.stringify(ids));
    btn.textContent='✓';
    if(confirm('Đã cập nhật danh sách so sánh. Mở trang so sánh?')) location.href='/compare?ids='+ids.join(',');
  }));
})();
