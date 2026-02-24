<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Sửa sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="checkbox"] {
            margin-right: 5px;
        }

        button[type="submit"] {
            background: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1em;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background: #45a049;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            text-decoration: none;
            color: #1976D2;
            font-weight: bold;
            margin: 0 10px;
        }

        .links a:hover {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <h2>Sửa sản phẩm</h2>
    <form action="updateProduct" method="post">
        <input type="hidden" name="id" value="${product.id}">

        <label for="categoryId">Danh mục (ID):</label>
        <input type="number" id="categoryId" name="categoryId" value="${product.id_category}" required>

        <label for="name">Tên sản phẩm:</label>
        <input type="text" id="name" name="name" value="${product.name}" required>

        <label for="image">Hình ảnh (URL):</label>
        <input type="text" id="image" name="image" value="${product.image}" required>

        <label for="price">Giá:</label>
        <input type="number" step="0.01" id="price" name="price" value="${product.price}" required>

        <label for="quantity">Số lượng:</label>
        <input type="number" id="quantity" name="quantity" value="${product.quantity}" required>

        <label for="status">Trạng thái:</label>
        <input type="checkbox" id="status" name="status" <c:if test="${product.status}">checked</c:if>>
        
        <button type="submit">Cập nhật</button>
    </form>
    <br>
    <div class="links">
        <a href="listProduct">Quay lại danh sách</a>
    </div>
</body>
</html>