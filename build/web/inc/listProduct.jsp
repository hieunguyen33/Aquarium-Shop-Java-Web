<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <title>Quản lý sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn {
            background: #4CAF50;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background: #45a049;
        }
        .search-form input[type="text"] {
            padding: 6px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-form input[type="submit"] {
            padding: 7px 15px;
            border: none;
            border-radius: 5px;
            background: #2196F3;
            color: white;
            cursor: pointer;
        }
        .search-form input[type="submit"]:hover {
            background: #1976D2;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            vertical-align: middle;
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #4CAF50;
            color: white;
        }
        tr:hover {
            background: #f1f1f1;
        }
        img {
            max-width: 80px;
            border-radius: 5px;
        }
        
        .actions a {
            text-decoration: none;
            padding: 4px 8px;
            border-radius: 5px;
            color: #4CAF50;         /* màu chữ xanh lá */
            background: transparent; /* không có nền */
            border: none;           /* không viền */
            font-weight: bold;
            transition: color 0.2s ease;
        }

        .actions a:hover {
            color: #1976D2;          /* đổi màu chữ khi hover */
            background: transparent; /* giữ nền trong suốt */
            border: none;            /* không viền khi hover */
        }

        .open-btn {
            font-size: 20px;
            cursor: pointer;
            background: #0d6efd;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            margin:10px;
        }
    </style>
</head>
<body>
    <button class="open-btn" onclick="openSidebar()">☰ Menu</button>

    <jsp:include page="/inc/sidebar.jsp"/>
    <h2>Danh sách sản phẩm</h2>

    <div class="top-bar">
        <a href="addProduct" class="btn">+ Thêm sản phẩm</a>

        <form action="findProduct" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="Nhập tên sản phẩm...">
            <input type="submit" value="Tìm kiếm">
        </form>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Hình ảnh</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Danh mục</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <c:if test="${not empty requestScope.list}">
            <c:forEach var="p" items="${requestScope.list}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <td><img src="./assets/images/${p.image}" width="80"></td>
                    <td>${p.price}</td>
                    <td>${p.quantity}</td>
                    <td>${p.id_category}</td>
                    <td>
                        <c:if test="${p.status}">Sẵn sàng</c:if>
                        <c:if test="${!p.status}">Chưa sẵn sàng</c:if>
                    </td>
                    <td class="actions">
                        <a href="updateProduct?id=${p.id}">Sửa</a>
                        <a href="deleteProduct?id=${p.id}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty requestScope.list}">
            <tr><td colspan="8">Không có sản phẩm nào</td></tr>
        </c:if>
    </table>
    <br>
</body>
</html>