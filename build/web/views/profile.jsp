<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<%-- Khai báo Bean để lấy thời gian hiện tại dùng cho logic hủy đơn trong 3 tiếng --%>
<jsp:useBean id="now" class="java.util.Date" />

<section class="min-vh-100 py-5" style="background: #121212; color: #e0e0e0;">
    <div class="container">
        
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="card bg-dark border-secondary text-center p-4 shadow-lg" style="border-radius: 15px;">
                    <div class="position-relative d-inline-block mx-auto mb-3">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" 
                             class="rounded-circle shadow" style="width: 100px; border: 3px solid #0dcaf0;">
                    </div>
                    <h4 class="fw-bold text-info mb-1">${sessionScope.user.name}</h4>
                    <p class="text-secondary small mb-4">Khách hàng thành viên</p>
                    
                    <div class="nav flex-column nav-pills text-start" id="v-pills-tab" role="tablist">
                        <button class="nav-link active mb-2 py-2" data-bs-toggle="pill" data-bs-target="#tab-info" type="button">
                            <i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân
                        </button>
                        <button class="nav-link mb-2 py-2" data-bs-toggle="pill" data-bs-target="#tab-orders" type="button">
                            <i class="bi bi-bag-check-fill me-2"></i> Lịch sử đơn hàng
                        </button>
                        <button class="nav-link mb-2 py-2 text-warning" data-bs-toggle="pill" data-bs-target="#tab-password" type="button">
                            <i class="bi bi-key-fill me-2"></i> Đổi mật khẩu
                        </button>
                        
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card bg-dark border-secondary shadow-lg" style="border-radius: 15px;">
                    <div class="card-body p-4">
                        <div class="tab-content" id="v-pills-tabContent">
                            
                            <div class="tab-pane fade show active" id="tab-info">
                                <h4 class="text-info border-bottom border-secondary pb-3 mb-4">Thông tin cá nhân</h4>
                                <form action="profile" method="post">
                                    <div class="mb-3">
                                        <label class="form-label text-secondary small">Email (Định danh tài khoản)</label>
                                        <input type="email" name="email" class="form-control bg-secondary text-white border-0" 
                                               value="${sessionScope.user.email}" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label text-secondary small">Họ và tên</label>
                                        <input type="text" name="name" class="form-control bg-dark text-white border-secondary" 
                                               value="${sessionScope.user.name}" required>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label text-secondary small">Số điện thoại</label>
                                        <input type="text" name="phone" class="form-control bg-dark text-white border-secondary" 
                                               value="${sessionScope.user.phone}" required>
                                    </div>
                                    <button type="submit" class="btn btn-info w-100 fw-bold">LƯU THAY ĐỔI</button>
                                </form>
                            </div>

                            <div class="tab-pane fade" id="tab-orders">
                                <h4 class="text-info border-bottom border-secondary pb-3 mb-4">Lịch sử đặt hàng</h4>
                                <div class="table-responsive">
                                    <table class="table table-dark table-hover align-middle">
                                        <thead class="text-secondary small text-uppercase">
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng cộng</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="o" items="${orders}">
                                                <tr>
                                                    <td class="text-info fw-bold">#${o.id}</td>
                                                    <td class="small">
                                                        <fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${o.tongtien}" type="number" /> VNĐ
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${o.trangthai == 'Hoàn thành'}">
                                                                <span class="badge bg-success">Hoàn thành</span>
                                                            </c:when>
                                                            <c:when test="${o.trangthai == 'Đã hủy'}">
                                                                <span class="badge bg-secondary">Đã hủy</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning text-dark">Đang xử lý</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex justify-content-center gap-2">
                                                            <a href="order-detail?id=${o.id}" class="btn btn-sm btn-outline-info" title="Xem chi tiết">
                                                                Xem
                                                            </a>
                                                            
                                                            <c:set var="diff" value="${now.time - o.ngaydat.time}" />
                                                            <c:if test="${o.trangthai == 'Đang xử lý' && diff < 10800000}">
                                                                <a href="cancel-order?id=${o.id}" class="btn btn-sm btn-warning" 
                                                                   onclick="return confirm('Bạn muốn hủy đơn hàng này?')">Hủy</a>
                                                            </c:if>
                                                            
                                                            <c:if test="${o.trangthai == 'Đã hủy' || o.trangthai == 'Hoàn thành'}">
                                                                <a href="delete-order?id=${o.id}" class="btn btn-sm btn-danger" 
                                                                   onclick="return confirm('Xóa đơn hàng này khỏi lịch sử?')">Xóa</a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test="${empty orders}">
                                        <p class="text-center text-secondary py-4">Bạn chưa có đơn hàng nào.</p>
                                    </c:if>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="tab-password">
                                <h4 class="text-warning border-bottom border-secondary pb-3 mb-4">Bảo mật tài khoản</h4>
                                <form action="change-password" method="post">
                                    <div class="mb-3">
                                        <label class="form-label text-secondary small">Mật khẩu hiện tại</label>
                                        <input type="password" name="oldPass" class="form-control bg-dark text-white border-secondary" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label text-secondary small">Mật khẩu mới</label>
                                        <input type="password" name="newPass" class="form-control bg-dark text-white border-secondary" required>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label text-secondary small">Xác nhận mật khẩu mới</label>
                                        <input type="password" name="confirmPass" class="form-control bg-dark text-white border-secondary" required>
                                    </div>
                                    <button type="submit" class="btn btn-warning w-100 fw-bold">XÁC NHẬN ĐỔI MẬT KHẨU</button>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        var hash = window.location.hash; // Lấy phần sau dấu # (ví dụ: #tab-password)
        
        if (hash) {
            // Tìm nút button tương ứng với cái hash đó
            // Ví dụ: hash = #tab-password -> tìm button có data-bs-target="#tab-password"
            var triggerEl = document.querySelector('button[data-bs-target="' + hash + '"]');
            
            if (triggerEl) {
                // Kích hoạt tab
                var tab = new bootstrap.Tab(triggerEl);
                tab.show();
                
                // Cuộn xuống
                triggerEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
        
        // Fix thêm cho trường hợp hủy/xóa đơn hàng dùng hash #history cũ
        if (hash === "#history") {
             var triggerEl = document.querySelector('button[data-bs-target="#tab-orders"]');
             if (triggerEl) {
                var tab = new bootstrap.Tab(triggerEl);
                tab.show();
             }
        }
    });
</script>

<c:import url="/inc/footer.jsp" />