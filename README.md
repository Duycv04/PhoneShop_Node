# PhoneShop Node

## Công nghệ

- Node.js
- Express.js
- EJS template engine
- PostgreSQL qua thư viện `pg`
- Session đăng nhập bằng `express-session`
- Giao diện shop responsive bằng CSS thuần

## Chức năng đã chuyển

### Khách hàng

- Trang chủ hiện đại, banner động từ bảng `homepagebanners`
- Navbar mới, mega menu danh mục, tìm kiếm sản phẩm
- Danh sách sản phẩm, lọc danh mục/thương hiệu, sắp xếp giá/xem nhiều
- Chi tiết sản phẩm, gallery, thông số, đánh giá, hỏi đáp
- Giỏ hàng bằng session
- Thanh toán, tạo đơn hàng vào bảng `orders`, `orderdetails`
- Wishlist theo tài khoản
- So sánh sản phẩm bằng localStorage
- Đơn hàng của tôi, chi tiết đơn hàng, hủy đơn
- Thông báo khách hàng
- Hỗ trợ/ticket
- Bảo hành/đổi trả
- Trả góp
- Thu cũ đổi mới
- Tra cứu vận đơn
- Hoàn tiền
- Hệ thống cửa hàng / đặt lịch nhận hàng
- Combo sản phẩm
- Tin tức công nghệ
- FAQ / chatbot nhanh
- Điểm thành viên
- Đăng ký nhận tin

### Admin

- Dashboard thống kê
- Quản lý sản phẩm
- Quản lý danh mục
- Quản lý đơn hàng
- Quản lý banner
- Quản lý khuyến mãi / Flash Sale
- Quản lý ticket hỗ trợ
- Quản lý bảo hành/đổi trả
- Báo cáo doanh thu, top sản phẩm, tồn kho thấp
- Xem nhanh các bảng mở rộng như trả góp, thu cũ, hoàn tiền, vận đơn
- Trang `/db-check` kiểm tra bảng database cần có

## Cách chạy

### 1. Cài Node.js

Nên dùng Node.js 20 trở lên.

Kiểm tra:

```bash
node -v
npm -v
```

### 2. Cài package

Trong thư mục dự án:

```bash
npm install
```

### 3. Tạo file `.env`

Copy file mẫu:

```bash
copy .env.example .env
```

## Cài đặt database

1. Mở PostgreSQL hoặc pgAdmin4.
2. Tạo database mới:

````sql
CREATE DATABASE phoneshop1;

```env
DATABASE_URL=postgres://postgres:123456@localhost:5432/phoneshop1
````

Sau đó mở:

```text
http://localhost:3000/db-check
```

để kiểm tra bảng còn thiếu.

### 5. Chạy web

```bash
npm run dev
```

hoặc:

```bash
npm start
```

Mở:

```text
http://localhost:3000
```

## Lưu ý về tài khoản cũ

Dự án Node.js có hỗ trợ kiểm tra password hash ASP.NET Identity v3 ở mức cơ bản. Nếu tài khoản cũ trong database dùng hash đúng chuẩn ASP.NET Identity, bạn có thể đăng nhập lại bằng mật khẩu cũ. Tài khoản tạo mới bằng Node.js sẽ dùng bcrypt.

Nếu không đăng nhập được tài khoản cũ, tạo tài khoản mới ở `/account/register`, sau đó đổi `roleid` trong bảng `users` sang role Admin nếu cần.
