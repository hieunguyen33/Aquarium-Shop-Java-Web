<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="h-100 h-custom" style="background-color: #eee;">
    <div class="container py-5 h-100">
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i> <strong>Thông báo:</strong> ${sessionScope.error}
                
                <%-- Quan trọng: Hiển thị xong phải xóa ngay để F5 không còn hiện nữa --%>
                <c:remove var="error" scope="session"/>
                
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12">
                <div class="card">
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col-lg-7">
                                <h5 class="mb-3"><a href="home" class="text-body"><i
                                            class="fas fa-long-arrow-alt-left me-2"></i>Tiếp tục mua sắm</a></h5>
                                <hr>
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <p class="mb-0">Giỏ hàng (<c:out value="${sessionScope.cart.totalItems}" /> sản phẩm)</p>
                                    <a href="clear-cart" class="btn btn-warning btn-sm"
                                       onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm trong giỏ hàng?');">
                                        Xóa tất cả
                                    </a>
                                </div>
                                <c:if test="${sessionScope.cart != null && !sessionScope.cart.items.isEmpty()}">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th scope="col">Sản phẩm</th>
                                                <th scope="col">Giá</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Tổng tiền</th>
                                                <th scope="col"></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="item" items="${sessionScope.cart.items}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/${item.product.image}"
                                                                 class="img-fluid rounded" alt="${item.product.name}" style="width: 65px;">
                                                            <div class="ms-3">
                                                                <p class="mb-0">${item.product.name}</p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-end">${item.product.price} VNĐ</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <form action="update-cart" method="post" id="updateForm_${item.product.id}">
                                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                                <input type="number" name="quantity" value="${item.quantity}" min="1"
                                                                       class="form-control form-control-sm text-center" style="width: 60px;"
                                                                       onchange="document.getElementById('updateForm_${item.product.id}').submit()">
                                                            </form>
                                                        </div>
                                                    </td>
                                                    <td class="text-end">${item.totalPrice} VNĐ</td>
                                                    <td>
                                                        <a href="remove-from-cart?productId=${item.product.id}"
                                                           class="btn btn-danger btn-sm">Xóa</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.cart == null || sessionScope.cart.items.isEmpty()}">
                                    <p class="text-center">Giỏ hàng của bạn đang trống.</p>
                                </c:if>
                            </div>

                            <div class="col-lg-5">
                                <div class="card bg-primary text-white rounded-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                                        </div>
                                        <hr class="my-4">
                                        <div class="d-flex justify-content-between">
                                            <p class="mb-2">Tổng phụ</p>
                                            <p class="mb-2"><c:out value="${sessionScope.cart.totalPrice}" /> VNĐ</p>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <p class="mb-2">Phí vận chuyển</p>
                                            <p class="mb-2">30000.0 VNĐ</p>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <p class="mb-2">Tổng cộng</p>
                                            <p class="mb-2"><c:out value="${sessionScope.cart.totalPrice + 30000}" /> VNĐ</p>
                                        </div>
                                        
                                        <a href="checkout" class="btn btn-info btn-lg w-100 d-flex justify-content-between align-items-center">
                                            <span class="fs-5"><c:out value="${sessionScope.cart.totalPrice + 30000}" /> VNĐ</span>
                                            <span class="fs-5">Đặt hàng</span>
                                        </a>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>