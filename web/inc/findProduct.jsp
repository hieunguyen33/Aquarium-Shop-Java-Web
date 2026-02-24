<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sản phẩm</title>
</head>
<body>
    <h2>Chi tiết sản phẩm</h2>
    <c:if test="${not empty product}">
        <p>ID: ${product.id}</p>
        <p>Tên: ${product.name}</p>
        <p><img src="${product.image}" width="150"></p>
        <p>Giá: ${product.price}</p>
        <p>Số lượng: ${product.quantity}</p>
        <p>Danh mục: ${product.id_category}</p>
        <p>Trạng thái: <c:if test="${product.status}">Còn hàng</c:if><c:if test="${!product.status}">Hết hàng</c:if></p>
    </c:if>
    <br>
    <a href="listProduct">Quay lại danh sách</a>
</body>
</html>
