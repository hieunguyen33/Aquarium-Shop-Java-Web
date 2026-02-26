# 🐟 Aquarium Shop - Java Servlet/JSP E-commerce Project

> Một ứng dụng web bán hàng trực tuyến (chuyên về cá cảnh/thủy sinh) được xây dựng theo mô hình MVC sử dụng Java Servlet, JSP, JSTL và MySQL.

<img width="100%" alt="Aquarium Shop Banner" src="https://github.com/user-attachments/assets/05b1ee8b-5b7a-4458-a84e-649f6ea612ef" />

## 📖 Giới thiệu

Dự án này là một website thương mại điện tử hoàn chỉnh với đầy đủ các chức năng cho cả người dùng (Khách hàng) và Quản trị viên (Admin). Hệ thống tập trung vào trải nghiệm mua sắm mượt mà, quản lý giỏ hàng thông minh và quy trình thanh toán chặt chẽ với kiểm tra tồn kho thực tế.

## 🛠 Công nghệ sử dụng

* **Ngôn ngữ:** Java (JDK 1.8+)
* **Mô hình:** MVC (Model-View-Controller)
* **Backend:** Java Servlet, JDBC (MySQL Connector/J 8.0+)
* **Frontend:** JSP, JSTL, EL, HTML5, CSS3, JavaScript
* **Framework UI:** Bootstrap 5
* **Database:** MySQL
* **Server:** Apache Tomcat (9.0 hoặc 10.0)
* **IDE:** NetBeans / IntelliJ IDEA

## 🚀 Chức năng chính

### 👤 Khách hàng (User)
* **Đăng ký / Đăng nhập:** Bảo mật tài khoản bằng thuật toán băm **MD5**.
* **Trang chủ:** Hiển thị sản phẩm nổi bật (Best Seller) với hiệu ứng Carousel 3D đẹp mắt.
* **Xem sản phẩm:** Xem chi tiết sản phẩm, giá bán, tình trạng kho.
* **Giỏ hàng thông minh:**
    * Thêm/Sửa/Xóa sản phẩm.
    * **Tính năng Đồng bộ:** Giỏ hàng được lưu vào Database qua bảng `cart_items`, đảm bảo không mất hàng khi đăng xuất.
    * Tự động tính tổng tiền (Đã xử lý lỗi hiển thị số lớn Scientific Notation).
* **Thanh toán (Checkout):**
    * **Kiểm tra tồn kho:** Hệ thống tự động chặn đơn hàng nếu số lượng mua lớn hơn số lượng trong kho.
    * Tạo đơn hàng và lưu chi tiết vào cơ sở dữ liệu.
* **Hồ sơ cá nhân (Profile):**
    * Cập nhật thông tin cá nhân.
    * **Đổi mật khẩu:** Xác thực mật khẩu cũ an toàn bằng MD5.
    * **Lịch sử đơn hàng:** Xem lại các đơn đã đặt và trạng thái thời gian thực.

### 🛡️ Quản trị viên (Admin)
* **Dashboard:** Quản lý tổng quan hệ thống.
* **Quản lý đơn hàng:**
    * Xem danh sách toàn bộ đơn hàng của hệ thống.
    * **Chi tiết đơn hàng:** Xem cụ thể từng món hàng, số lượng và thành tiền trong đơn hàng của khách.
    * Cập nhật trạng thái đơn hàng (Duyệt/Hủy).
* **Quản lý sản phẩm:** Thực hiện các thao tác CRUD (Thêm, sửa, xóa) và cập nhật số lượng tồn kho.

## 🗄️ Cấu trúc Database (MySQL)

1.categories: Quản lý các danh mục sản phẩm (ví dụ: Cá cảnh, Thủy sinh, Phụ kiện).
2.products: Lưu trữ thông tin chi tiết sản phẩm, giá bán và số lượng tồn kho thực tế.
3.users: Quản lý thông tin tài khoản khách hàng và phân quyền (Admin/User).
4.orders: Lưu trữ thông tin tổng quan về các đơn hàng (ngày đặt, tổng tiền, trạng thái).
5.order_details: Chi tiết từng mặt hàng trong đơn hàng (liên kết giữa bảng orders và products).
6.cart_items: Lưu trữ giỏ hàng tạm thời, giúp đồng bộ hóa dữ liệu mua sắm cho khách hàng.
7.import_history: Nhật ký chi tiết lịch sử nhập kho, theo dõi biến động số lượng hàng hóa bởi Admin.

## ⚙️ Hướng dẫn cài đặt (Installation)

1. **Clone dự án:**
    ```bash
    git clone [https://github.com/username/project-name.git](https://github.com/username/project-name.git)
    ```
2. **Cấu hình Database:**
    * Tạo database tên `shopcacanh` trong MySQL.
    * Import file `database.sql` vào database vừa tạo.
    * Cấu hình kết nối tại file **`src/java/data/utils/Constants.java`**:
        ```java
        public static final String DB_URL="jdbc:mysql://localhost:3306/shopcacanh";
        public static final String USER="root"; // Thay bằng username của bạn
        public static final String PASS="";     // Thay bằng password của bạn
        ```
3. **Mở dự án & Chạy:**
    * Mở dự án bằng NetBeans hoặc IntelliJ.
    * Chuột phải vào Project chọn **Clean and Build**.
    * Nhấn **F6** để chạy ứng dụng trên Tomcat.

## 📸 Screenshots

### 1. Trang chủ & Best Seller Showcase
<img width="1832" alt="image" src="https://github.com/user-attachments/assets/05b1ee8b-5b7a-4458-a84e-649f6ea612ef" />
<img width="1831" alt="image" src="https://github.com/user-attachments/assets/f50db0d8-bfa1-432a-840a-6197619f577d" />

### 2. Giỏ hàng & Quản lý số lượng
<img width="1838" alt="image" src="https://github.com/user-attachments/assets/290aad27-e09f-40e4-8c69-3deca930d418" />

### 3. Nhập kho & Quản lý lịch sử nhập kho
<img width="1843" height="914" alt="image" src="https://github.com/user-attachments/assets/0d51db08-01b2-49e6-b726-90f937bf40ce" />
<img width="1856" height="883" alt="image" src="https://github.com/user-attachments/assets/b608f9f6-4e3c-4b70-b5f3-c5939eaf8680" />


### 4. Giao diện Admin - Quản lý chi tiết đơn hàng
<img width="1859" alt="image" src="https://github.com/user-attachments/assets/cf7549a4-4e80-4152-8075-6bce7a69bf7a" />

### 5. Hồ sơ cá nhân & Bảo mật tài khoản
<img width="1860" alt="image" src="https://github.com/user-attachments/assets/4c36b320-01ab-47f4-a919-9df3862c8d77" />
<img width="1858" height="892" alt="image" src="https://github.com/user-attachments/assets/27b2b4fd-0e8e-4a16-87c5-2f68eb9f8583" />


---
*Created by Hiệu.*
