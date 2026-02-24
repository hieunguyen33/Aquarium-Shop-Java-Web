<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <title>Lịch sử mua hàng</title>
</head>
<body class="bg-dark text-white p-5">
    <div class="container">
        <h2>🛍️ Đơn hàng bạn đã đặt</h2>
        <table class="table table-dark table-hover mt-4">
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Ngày mua</th>
                    <th>Tổng tiền (VNĐ)</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td><fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td class="text-info">${o.tongtien}</td>
                        <td>
                            <span class="badge ${o.trangthai == 'Hoàn thành' ? 'bg-success' : 'bg-warning text-dark'}">
                                ${o.trangthai}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="home" class="btn btn-outline-light">Quay lại trang chủ</a>
    </div>
</body>
</html>