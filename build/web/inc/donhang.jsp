<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top:20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; vertical-align: middle; }
        th { background: #0d6efd; color: white; }
        tr:nth-child(even){ background: #f9f9f9; }
        .links {
            text-align: left;
            margin: 20px 0;
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
        
        /* Thêm style cho nút Xem */
        .btn-view {
            text-decoration: none;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <button class="open-btn" onclick="openSidebar()">☰ Menu</button>

    <jsp:include page="/inc/sidebar.jsp"/>
   
    <div class="container-fluid px-4">
        <h2>📦 Danh sách đơn hàng</h2>
        <table>
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền (VNĐ)</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th> </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.khachhang}</td>
                        <td>${o.ngaydat}</td>
                        <td>${o.tongtien}</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.trangthai == 'Hoàn thành'}">
                                    <span class="badge bg-success">${o.trangthai}</span>
                                </c:when>
                                <c:when test="${o.trangthai == 'Đã hủy'}">
                                    <span class="badge bg-secondary">${o.trangthai}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning text-dark">${o.trangthai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="order-detail?id=${o.id}" class="btn btn-sm btn-primary btn-view">
                                👁️ Xem
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>