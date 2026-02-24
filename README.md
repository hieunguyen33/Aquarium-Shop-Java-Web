# 🐟 Aquarium Shop - Java Servlet/JSP E-commerce Project

> Một ứng dụng web bán hàng trực tuyến (chuyên về cá cảnh/thủy sinh) được xây dựng theo mô hình MVC sử dụng Java Servlet, JSP, JSTL và MySQL.

<img width="1832" height="909" alt="image" src="https://github.com/user-attachments/assets/05b1ee8b-5b7a-4458-a84e-649f6ea612ef" />


## 📖 Giới thiệu

Dự án này là một website thương mại điện tử hoàn chỉnh với đầy đủ các chức năng cho cả người dùng (Khách hàng) và Quản trị viên (Admin). Hệ thống tập trung vào trải nghiệm mua sắm mượt mà, quản lý giỏ hàng thông minh và quy trình thanh toán chặt chẽ với kiểm tra tồn kho thực tế.

## 🛠 Công nghệ sử dụng

* **Ngôn ngữ:** Java (JDK 1.8+)
* **Mô hình:** MVC (Model-View-Controller)
* **Backend:** Java Servlet, JDBC
* **Frontend:** JSP, JSTL, EL, HTML5, CSS3, JavaScript
* **Framework UI:** Bootstrap 5
* **Database:** MySQL
* **Server:** Apache Tomcat (9.0 hoặc 10.0)
* **IDE:** NetBeans / IntelliJ IDEA

## 🚀 Chức năng chính

### 👤 Khách hàng (User)
* **Đăng ký / Đăng nhập:** Bảo mật tài khoản người dùng.
* **Trang chủ:** Hiển thị sản phẩm nổi bật (Best Seller) với hiệu ứng Carousel 3D đẹp mắt.
* **Xem sản phẩm:** Xem chi tiết sản phẩm, giá bán, tình trạng kho.
* **Giỏ hàng thông minh:**
    * Thêm/Sửa/Xóa sản phẩm.
    * **Tính năng Đồng bộ:** Giỏ hàng được lưu vào Database, đảm bảo không mất hàng khi đăng xuất hoặc đổi thiết bị.
    * Tự động tính tổng tiền.
* **Thanh toán (Checkout):**
    * **Kiểm tra tồn kho:** Hệ thống tự động chặn đơn hàng nếu số lượng mua lớn hơn số lượng trong kho.
    * Tạo đơn hàng và lưu chi tiết vào cơ sở dữ liệu.
* **Hồ sơ cá nhân (Profile):**
    * Cập nhật thông tin cá nhân.
    * **Đổi mật khẩu:** Có xác thực mật khẩu cũ an toàn.
    * **Lịch sử đơn hàng:** Xem lại các đơn đã đặt, trạng thái đơn hàng.
    * **Hủy đơn hàng:** Cho phép hủy đơn trong khoảng thời gian quy định nếu đơn chưa được xử lý.

### 🛡️ Quản trị viên (Admin)
* **Dashboard:** Tổng quan hệ thống.
* **Quản lý đơn hàng:**
    * Xem danh sách tất cả đơn hàng.
    * **Xem chi tiết đơn hàng:** Xem danh sách sản phẩm, số lượng, giá tiền của từng đơn.
    * Duyệt đơn / Hủy đơn.
* **Quản lý sản phẩm:** Thêm, sửa, xóa, cập nhật tồn kho (CRUD).

## 🗄️ Cấu trúc Database (MySQL)

Dự án sử dụng các bảng chính sau:

1.  **users**: Lưu thông tin người dùng (id, name, email, password, role...).
2.  **products**: Lưu thông tin sản phẩm (id, name, image, price, quantity, description...).
3.  **orders**: Lưu đơn hàng (id, user_id, total_money, status, date...).
4.  **order_details**: Lưu chi tiết sản phẩm trong đơn hàng.
5.  **cart_items**: Lưu giỏ hàng tạm thời của user (hỗ trợ tính năng đồng bộ).

## ⚙️ Hướng dẫn cài đặt (Installation)

1.  **Clone dự án:**
    ```bash
    git clone [https://github.com/username/project-name.git](https://github.com/username/project-name.git)
    ```
2.  **Cấu hình Database:**
    * Mở MySQL Workbench hoặc phpMyAdmin.
    * Tạo database tên `shopcacanh` (hoặc tên tùy chọn).
    * Import file `database.sql` (nằm trong thư mục root hoặc db).
    * Mở file src/java/data/utils/Constants.java và cập nhật thông số kết nối của bạn:
        ```java
        public static final String DB_URL="jdbc:mysql://localhost:3306/shopcacanh";
        public static final String USER="root"; 
        public static final String PASS=""; 
        ```
3.  **Mở dự án:**
    * Mở NetBeans/IntelliJ -> File -> Open Project.
4.  **Clean & Build:**
    * Chuột phải vào Project -> Clean and Build.
5.  **Chạy dự án:**
    * Nhấn Run (hoặc F6).
    * Trình duyệt sẽ tự động mở tại `http://localhost:8080/Shopping4`.

## 📸 Screenshots

### 1. Trang chủ & Best Seller
<img width="1832" height="909" alt="image" src="https://github.com/user-attachments/assets/05b1ee8b-5b7a-4458-a84e-649f6ea612ef" />
<img width="1831" height="905" alt="image" src="https://github.com/user-attachments/assets/f50db0d8-bfa1-432a-840a-6197619f577d" />
<img width="1829" height="897" alt="image" src="https://github.com/user-attachments/assets/86fdaf1f-4ff7-45f0-a6d9-bc135b2d9925" />
<img width="1832" height="902" alt="image" src="https://github.com/user-attachments/assets/b0ac9d6e-3814-4e2d-ad11-0bf6386e261d" />
<img width="1832" height="782" alt="image" src="https://github.com/user-attachments/assets/16f19c68-a646-4b23-902f-f4e5e3112638" />

### 2. Giỏ hàng & Kiểm tra tồn kho
<img width="1838" height="903" alt="image" src="https://github.com/user-attachments/assets/290aad27-e09f-40e4-8c69-3deca930d418" />

### 3. Chi tiết đơn hàng (Giao diện Admin)
<img width="1859" height="861" alt="image" src="https://github.com/user-attachments/assets/cf7549a4-4e80-4152-8075-6bce7a69bf7a" />

### 4. Đổi mật khẩu & Profile
<img width="1860" height="913" alt="image" src="https://github.com/user-attachments/assets/4c36b320-01ab-47f4-a919-9df3862c8d77" />
<img width="1863" height="909" alt="image" src="https://github.com/user-attachments/assets/7393c718-45fe-4e3e-9137-cdadf29c1765" />


## 🤝 Đóng góp (Contributing)

Mọi đóng góp đều được hoan nghênh. Vui lòng mở Pull Request hoặc tạo Issue nếu bạn tìm thấy lỗi.

## 📄 License

Dự án này được phát hành dưới giấy phép [MIT License](LICENSE).

---
*Created by Hiệu.*chuẩn rồi nhỉ
