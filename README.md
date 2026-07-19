# PhoneShop Node.js

Dự án **PhoneShop Node.js** là website bán điện thoại được xây dựng bằng **Node.js**, **Express.js**, **EJS** và **PostgreSQL**. Hệ thống hỗ trợ đầy đủ chức năng dành cho khách hàng và quản trị viên như xem sản phẩm, giỏ hàng, đặt hàng, quản lý sản phẩm, quản lý đơn hàng, banner, khuyến mãi và báo cáo.

## Công nghệ sử dụng

- Node.js
- Express.js
- EJS Template Engine
- PostgreSQL
- Thư viện `pg` để kết nối database
- `express-session` để quản lý phiên đăng nhập
- CSS thuần kết hợp giao diện responsive
- Bcrypt để mã hóa mật khẩu tài khoản mới

## Chức năng khách hàng

- Trang chủ hiện đại, hiển thị banner động từ bảng `homepagebanners`
- Navbar mới, hỗ trợ mega menu danh mục và tìm kiếm sản phẩm
- Danh sách sản phẩm
- Lọc sản phẩm theo danh mục, thương hiệu
- Sắp xếp sản phẩm theo giá và lượt xem
- Xem chi tiết sản phẩm
- Gallery hình ảnh sản phẩm
- Hiển thị thông số kỹ thuật, đánh giá, hỏi đáp sản phẩm
- Thêm sản phẩm vào giỏ hàng bằng session
- Thanh toán và tạo đơn hàng vào bảng `orders`, `orderdetails`
- Wishlist theo tài khoản người dùng
- So sánh sản phẩm bằng `localStorage`
- Xem danh sách đơn hàng của tôi
- Xem chi tiết đơn hàng
- Hủy đơn hàng
- Nhận thông báo khách hàng
- Gửi ticket hỗ trợ
- Quản lý yêu cầu bảo hành, đổi trả
- Đăng ký trả góp
- Đăng ký thu cũ đổi mới
- Tra cứu vận đơn
- Theo dõi hoàn tiền
- Xem hệ thống cửa hàng
- Đặt lịch nhận hàng tại cửa hàng
- Xem combo sản phẩm
- Đọc tin tức công nghệ
- FAQ và chatbot nhanh
- Tích điểm thành viên
- Đăng ký nhận tin khuyến mãi

## Chức năng quản trị viên

- Dashboard thống kê tổng quan
- Quản lý sản phẩm
- Quản lý danh mục
- Quản lý thương hiệu
- Quản lý đơn hàng
- Quản lý banner trang chủ
- Quản lý khuyến mãi
- Quản lý Flash Sale
- Quản lý ticket hỗ trợ
- Quản lý bảo hành, đổi trả
- Xem báo cáo doanh thu
- Xem báo cáo sản phẩm bán chạy
- Xem báo cáo sản phẩm tồn kho thấp
- Xem nhanh các bảng mở rộng như trả góp, thu cũ, hoàn tiền, vận đơn
- Trang `/db-check` để kiểm tra các bảng cần có trong database

## Cấu trúc thư mục

```text
PhoneShop/
├── database/
│   └── phoneshop_database.sql
├── public/
│   ├── css/
│   ├── js/
│   ├── images/
│   └── uploads/
├── src/
│   ├── controllers/
│   ├── middlewares/
│   ├── routes/
│   ├── services/
│   ├── views/
│   └── config/
├── .env.example
├── .gitignore
├── package.json
├── package-lock.json
├── server.js
└── README.md
```

## Yêu cầu cài đặt

Trước khi chạy dự án, máy cần có:

- Node.js 20 trở lên
- PostgreSQL
- pgAdmin4 hoặc công cụ quản lý PostgreSQL tương đương
- Git nếu muốn clone hoặc đẩy dự án lên GitHub

Kiểm tra Node.js và npm:

```bash
node -v
npm -v
```

## Hướng dẫn cài đặt dự án

### 1. Clone hoặc tải dự án

Nếu tải từ GitHub:

```bash
git clone https://github.com/tuducduybg/PhoneShop-Node-Express.git
cd PhoneShop-Node-Express
```

Nếu đã có sẵn thư mục dự án, mở terminal tại thư mục chứa file `package.json`.

### 2. Cài đặt package

```bash
npm install
```

### 3. Tạo file môi trường `.env`

Copy file mẫu:

```bash
copy .env.example .env
```

Nếu dùng PowerShell có thể dùng:

```powershell
Copy-Item .env.example .env
```

Sau đó mở file `.env` và sửa thông tin kết nối database cho đúng máy của bạn.

Ví dụ:

```env
NODE_ENV=development
PORT=3000
SESSION_SECRET=change-this-secret

DATABASE_URL=postgres://postgres:123456@localhost:5432/phoneshop1
```

Trong đó:

```text
postgres      là tài khoản PostgreSQL
123456        là mật khẩu PostgreSQL
localhost     là máy đang chạy database
5432          là cổng mặc định của PostgreSQL
phoneshop1    là tên database
```

## Cài đặt database PostgreSQL

### 1. Tạo database mới

Mở pgAdmin4 hoặc Query Tool trong PostgreSQL, sau đó chạy:

```sql
CREATE DATABASE phoneshop1;
```

### 2. Import database từ file SQL

Nếu dự án có sẵn file:

```text
database/phoneshop_database.sql
```

Bạn có thể import bằng lệnh:

```bash
psql -U postgres -d phoneshop1 -f database/phoneshop_database.sql
```

Nếu chạy lệnh trên bị lỗi `psql is not recognized`, hãy mở terminal tại thư mục `bin` của PostgreSQL.

Ví dụ PostgreSQL 16:

```powershell
cd "C:\Program Files\PostgreSQL\16\bin"
```

Sau đó chạy:

```powershell
.\psql.exe -U postgres -d phoneshop1 -f "C:\duong-dan-du-an\PhoneShop\database\phoneshop_database.sql"
```

Thay `C:\duong-dan-du-an\PhoneShop` bằng đường dẫn thật tới thư mục dự án của bạn.

### 3. Kiểm tra database

Sau khi import xong, chạy dự án rồi mở đường dẫn:

```text
http://localhost:3000/db-check
```

Trang này dùng để kiểm tra các bảng cần có trong database. Nếu bảng nào còn thiếu, hệ thống sẽ báo để bạn bổ sung.

## Chạy dự án

Chạy ở chế độ development:

```bash
npm run dev
```

Hoặc chạy bình thường:

```bash
npm start
```

Sau đó mở trình duyệt:

```text
http://localhost:3000
```

## Tài khoản và đăng nhập

Dự án hỗ trợ tài khoản khách hàng và tài khoản quản trị viên.

Tài khoản người dùng có thể được tạo tại:

```text
/account/register
```

Sau khi đăng ký, tài khoản mới sẽ sử dụng mật khẩu được mã hóa bằng bcrypt.

## Lưu ý về tài khoản cũ từ ASP.NET Identity

Dự án Node.js có hỗ trợ kiểm tra password hash ASP.NET Identity v3 ở mức cơ bản.

Nếu tài khoản cũ trong database dùng đúng chuẩn hash của ASP.NET Identity, người dùng có thể đăng nhập lại bằng mật khẩu cũ.

Nếu không đăng nhập được tài khoản cũ, bạn có thể:

1. Tạo tài khoản mới tại:

```text
/account/register
```

2. Mở bảng `users` trong PostgreSQL.

3. Đổi `roleid` của tài khoản đó sang role Admin nếu cần quyền quản trị.

## Các file không nên đưa lên GitHub

Không nên đưa các file và thư mục sau lên GitHub:

```text
node_modules/
.env
public/uploads/
*.log
```

File `.gitignore` nên có nội dung:

```gitignore
node_modules/
.env
.DS_Store
npm-debug.log*
public/uploads/
*.log
.vscode/
.idea/
```

## Các file nên đưa lên GitHub

Nên đưa các file sau lên GitHub:

```text
README.md
package.json
package-lock.json
server.js
src/
public/
database/phoneshop_database.sql
.env.example
.gitignore
```

## Cách cập nhật dự án lên GitHub

Sau khi sửa code, sửa README hoặc thêm database, chạy các lệnh sau:

```bash
git status
git add .
git commit -m "Update PhoneShop project"
git push
```

Nếu là lần đầu đưa dự án lên GitHub:

```bash
git init
git add .
git commit -m "Initial commit PhoneShop Node.js project"
git branch -M main
git remote add origin https://github.com/tuducduybg/PhoneShop-Node-Express.git
git push -u origin main
```

Nhớ thay link repository GitHub cho đúng với tài khoản và tên repo của bạn.

## Một số lỗi thường gặp

### Lỗi `npm is not recognized`

Nguyên nhân: máy chưa nhận npm trong biến môi trường PATH.

Cách xử lý:

- Kiểm tra đã cài Node.js chưa
- Mở lại terminal hoặc VS Code
- Chạy lại:

```bash
node -v
npm -v
```

### Lỗi kết nối PostgreSQL

Kiểm tra lại file `.env`:

```env
DATABASE_URL=postgres://postgres:123456@localhost:5432/phoneshop1
```

Cần đảm bảo:

- PostgreSQL đang chạy
- Tên database đúng
- Tài khoản PostgreSQL đúng
- Mật khẩu PostgreSQL đúng
- Cổng PostgreSQL đúng, thường là `5432`

### Lỗi thiếu bảng database

Mở:

```text
http://localhost:3000/db-check
```

Sau đó kiểm tra bảng nào còn thiếu và import lại file SQL trong thư mục `database`.

## Tác giả

Sinh viên thực hiện: **Từ Đức Duy**

Dự án: **Website bán điện thoại bằng Node.js, Express.js và PostgreSQL**
