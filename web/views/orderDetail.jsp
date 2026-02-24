<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.id} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">Admin Dashboard</span>
            <a href="${pageContext.request.contextPath}/admin" class="btn btn-sm btn-outline-light">Quay lại</a>
        </div>
    </nav>

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary">Chi tiết đơn hàng #${order.id}</h2>
            
            <c:choose>
                <c:when test="${order.trangthai == 'Hoàn thành'}">
                    <span class="badge bg-success fs-5">Hoàn thành</span>
                </c:when>
                <c:when test="${order.trangthai == 'Đã hủy'}">
                    <span class="badge bg-secondary fs-5">Đã hủy</span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-warning text-dark fs-5">${order.trangthai}</span>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white">Thông tin khách hàng</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Khách hàng:</strong> ${order.khachhang}</p>
                        <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.ngaydat}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
                    </div>
                    <div class="col-md-6 text-end">
                        <h4 class="text-danger">Tổng tiền: <fmt:formatNumber value="${order.tongtien}" type="number"/> VNĐ</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-secondary text-white">Danh sách sản phẩm</div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end pe-4">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="d" items="${details}">
                                <tr>
                                    <td class="ps-4">
                                        <img src="../assets/images/${d.productImage}" 
                                             class="rounded border" style="width: 60px; height: 60px; object-fit: cover;"
                                             onerror="this.src='https://via.placeholder.com/60'">
                                    </td>
                                    <td class="fw-bold text-primary">${d.productName}</td>
                                    <td class="text-center"><span class="badge bg-dark rounded-pill">${d.quantity}</span></td>
                                    <td class="text-end"><fmt:formatNumber value="${d.price}" type="number"/> VNĐ</td>
                                    <td class="text-end pe-4 fw-bold"><fmt:formatNumber value="${d.price * d.quantity}" type="number"/> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white text-end py-3">
                <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>