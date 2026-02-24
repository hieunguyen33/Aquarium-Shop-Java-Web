<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <title>Thêm sản phẩm</title>
    <style>
        body { font-family: Arial; background: #f5f7fa; padding: 20px; }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        form { max-width: 450px; margin: 0 auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        label { font-weight: bold; display: block; margin-top: 10px; color: #333; }
        input, select { width: 100%; padding: 10px; margin-bottom: 5px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        button[type="submit"] { background: #4CAF50; color: white; padding: 12px; border: none; border-radius: 5px; cursor: pointer; width: 100%; font-size: 1.1em; margin-top: 20px; }
        .open-btn { font-size: 20px; cursor: pointer; background: #0d6efd; color: white; border: none; padding: 10px 15px; border-radius: 6px; margin-bottom: 15px; }
        .alert { max-width: 450px; margin: 0 auto 15px auto; text-align: center; }
    </style>
</head>
<body>
    <button class="open-btn" onclick="openSidebar()">☰ Menu</button>
    <jsp:include page="/inc/sidebar.jsp"/>
    
    <div id="main-content">
        <h2>Thêm sản phẩm mới</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <b></b> ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <b></b> ${error}
            </div>
        </c:if>
        
        <form action="addProduct" method="post">        
            <label>Danh mục cá:</label>
            <select name="categoryId" required>
                <option value="" disabled selected>-- Chọn sản phẩm --</option>
                <c:forEach var="cat" items="${listCategory}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>

            <label>Tên sản phẩm:</label>
            <input type="text" name="name" placeholder="Ví dụ: Betta Halfmoon Red" required>

            <label>Hình ảnh (Tên file hoặc URL):</label>
            <input type="text" name="image" placeholder="Ví dụ: betta1.jpg" required>

            <label>Giá bán (VNĐ):</label>
            <input type="number" step="0.01" name="price" required>

            <label>Số lượng trong kho:</label>
            <input type="number" name="quantity" required>
            
            <label style="display: flex; align-items: center; gap: 10px; margin-top: 10px; cursor: pointer;">
                <input type="checkbox" name="status" checked style="width: auto; margin: 0;"> 
                Sẵn sàng (Hiển thị công khai)
            </label>
            
            <button type="submit">Xác nhận thêm sản phẩm</button>
        </form>
    </div>
</body>
</html>