<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="header.jsp" />
<c:import url="navbar.jsp" />

<div class="container py-5 min-vh-100">
    <div class="card bg-dark text-white border-secondary shadow-lg" style="border-radius: 15px;">
        <div class="card-header border-secondary p-4 d-flex justify-content-between align-items-center">
            <h4 class="text-info fw-bold mb-0">Chi tiết đơn hàng #${order.id}</h4>
            <span class="badge bg-warning text-dark px-3 py-2">${order.trangthai}</span>
        </div>
        <div class="card-body p-4">
            <div class="row mb-4">
                <div class="col-md-6">
                    <p class="mb-1 text-secondary">Khách hàng:</p>
                    <h6 class="text-white">${order.khachhang}</h6>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-1 text-secondary">Thời gian đặt:</p>
                    <h6 class="text-white">
                        <fmt:formatDate value="${order.ngaydat}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </h6>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle">
                    <thead class="text-secondary small text-uppercase">
                        <tr>
                            <th class="text-center">Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-center">Đơn giá</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Vòng lặp hiển thị từng sản phẩm --%>
                        <c:forEach var="d" items="${details}">
                            <tr>
                                <td class="text-center">
                                    <%-- Đường dẫn ảnh (Chú ý: phải đúng với cấu trúc thư mục của bạn) --%>
                                    <img src="./assets/images/${d.productImage}" width="60" class="rounded border border-secondary" alt="Ảnh sản phẩm">
                                </td>
                                <td class="fw-bold">${d.productName}</td>
                                <td class="text-center">${d.quantity}</td>
                                <td class="text-center">
                                    <fmt:formatNumber value="${d.price}" type="number"/> VNĐ
                                </td>
                                <td class="text-end text-info fw-bold">
                                    <fmt:formatNumber value="${d.price * d.quantity}" type="number"/> VNĐ
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <%-- Nếu không có sản phẩm nào thì hiện thông báo --%>
                <c:if test="${empty details}">
                    <p class="text-center py-3 text-secondary">Không có sản phẩm nào trong đơn hàng này.</p>
                </c:if>
            </div>
            
            <%-- Phần Tổng cộng được chỉnh nhỏ lại --%>
            <div class="text-end mt-4 border-top border-secondary pt-3">
                <h5 class="text-danger fw-bold" style="font-size: 1.1rem;">
                    TỔNG CỘNG: <fmt:formatNumber value="${order.tongtien}" type="number"/> VNĐ
                </h5>
            </div>
        </div>
        <div class="card-footer border-secondary text-end p-4">
            <button class="btn btn-outline-info px-4 fw-bold btn-sm" onclick="history.back()">QUAY LẠI</button>
        </div>
    </div>
</div>

<c:import url="footer.jsp" />