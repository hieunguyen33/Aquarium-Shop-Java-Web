<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Nhập Kho</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: Arial, sans-serif; background: #f5f7fa; padding: 20px; }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        
        /* Style cho nút mở Sidebar đồng bộ với trang addProduct */
        .open-btn { 
            font-size: 20px; 
            cursor: pointer; 
            background: #0d6efd; 
            color: white; 
            border: none; 
            padding: 10px 15px; 
            border-radius: 6px; 
            margin-bottom: 15px; 
        }

        /* Container cho bảng lịch sử */
        .history-container {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #4CAF50; color: white; text-align: center; padding: 12px; }
        td { padding: 10px; border-bottom: 1px solid #ddd; vertical-align: middle; }
        tr:hover { background: #f1f1f1; }
        
        .badge-import { font-size: 0.9rem; font-weight: bold; }
    </style>
</head>
<body>
    <button class="open-btn" onclick="openSidebar()">☰ Menu</button>
    
    <jsp:include page="/inc/sidebar.jsp"/>
    
    <div id="main-content">
        <h2>📦 Nhật ký nhập kho sản phẩm</h2>

        <div class="history-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th style="width: 50px;">STT</th>
                        <th>Sản phẩm</th>
                        <th>Admin thực hiện</th>
                        <th class="text-center">Số lượng</th>
                        <th>Ngày giờ nhập</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty historyList}">
                        <c:forEach var="h" items="${historyList}" varStatus="loop">
                            <tr>
                                <td class="text-center">${loop.index + 1}</td>
                                <td>
                                    <strong>${h.productName}</strong><br>
                                    <small class="text-muted">ID SP: #${h.productId}</small>
                                </td>
                                <td>
                                    <i class="fas fa-user-shield text-primary me-1"></i> 
                                    ${h.adminName}
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-success badge-import">+ ${h.quantity}</span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${h.importDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                </td>
                                <td class="text-secondary small italic">
                                    ${empty h.note ? "---" : h.note}
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty historyList}">
                        <tr>
                            <td colspan="6" class="text-center py-4">Chưa có lịch sử nhập hàng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>