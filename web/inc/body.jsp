<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container my-5">
    <h2 class="mb-4">
        <c:choose>
            <c:when test="${not empty searchResults}">
                Kết quả tìm kiếm cho: "${keyword}"
            </c:when>
            <c:otherwise>
                Sản phẩm nổi bật
            </c:otherwise>
        </c:choose>
    </h2>

    <div class="row">
        <%-- PHẦN 1: HIỂN THỊ KẾT QUẢ TÌM KIẾM --%>
        <c:if test="${not empty searchResults}">
            <c:forEach var="p" items="${searchResults}">
                <div class="col-lg-3 col-md-6 d-flex">
                    <div class="card w-100 my-2 shadow-2-strong ${p.quantity <= 0 ? 'opacity-75' : ''}">
                        <img src="assets/images/${p.image}" class="card-img-top" style="aspect-ratio: 1/1; object-fit: cover;"/>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${p.name}</h5>
                            <p class="card-text">${p.price} VNĐ</p>
                            
                            <p class="card-text">
                                <small class="text-muted">Số lượng: </small>
                                <span class="badge ${p.quantity > 0 ? 'bg-info' : 'bg-danger'}">
                                    ${p.quantity > 0 ? p.quantity : 'Hết hàng'}
                                </span>
                            </p>

                            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                <form action="add-to-cart" method="post" class="w-100">
                                    <input type="hidden" name="id" value="${p.id}"/>
                                    <button type="submit" class="btn btn-primary w-100 shadow-0" ${p.quantity <= 0 ? 'disabled' : ''}>
                                        <c:choose>
                                            <c:when test="${p.quantity > 0}">Add to cart</c:when>
                                            <c:otherwise>Out of stock</c:otherwise>
                                        </c:choose>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <%-- PHẦN 2: HIỂN THỊ THEO DANH MỤC (KHI KHÔNG TÌM KIẾM) --%>
        <c:if test="${empty searchResults}">
            <%-- TRƯỜNG HỢP: XEM TẤT CẢ DANH MỤC --%>
            <c:if test="${id_category == null}">
                <c:forEach var="c" items="${listCategory}">
                    <div class="col-12 mt-5">
                        <header class="mb-4 border-bottom pb-2">
                            <h3 class="text-uppercase fw-bold">${c.getName()}</h3>
                        </header>
                    </div>
                    <c:forEach var="p" items="${listProduct}">
                        <c:if test="${c.getId() == p.getId_category() && p.isStatus() == true}">
                            <div class="col-lg-3 col-md-6 d-flex">
                                <div class="card w-100 my-2 shadow-sm ${p.quantity <= 0 ? 'opacity-75' : ''}">
                                    <img src="assets/images/${p.image}" class="card-img-top" style="aspect-ratio: 1/1; object-fit: cover;"/>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${p.getName()}</h5>
                                        <p class="card-text text-danger fw-bold">${p.getPrice()} VNĐ</p>
                                        
                                        <p class="card-text">
                                            <small class="text-muted">Số lượng: </small>
                                            <span class="badge ${p.quantity > 0 ? 'bg-info' : 'bg-danger'}">
                                                ${p.quantity > 0 ? p.quantity : 'Hết hàng'}
                                            </span>
                                        </p>

                                        <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                            <form action="add-to-cart" method="post" class="w-100">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <button type="submit" class="btn btn-primary w-100" ${p.quantity <= 0 ? 'disabled' : ''}>
                                                    ${p.quantity > 0 ? 'Add to cart' : 'Out of stock'}
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:if>

            <%-- TRƯỜNG HỢP: LỌC THEO MỘT DANH MỤC CỤ THỂ --%>
            <c:if test="${id_category != null}">
                <c:forEach var="c" items="${listCategory}">
                    <c:if test="${c.id == id_category}">
                        <div class="col-12">
                            <header class="mb-4 border-bottom pb-2">
                                <h3 class="text-uppercase fw-bold">${c.getName()}</h3>
                            </header>
                        </div>
                        <c:forEach var="p" items="${listProduct}">
                            <c:if test="${c.getId() == p.getId_category() && p.isStatus() == true}">
                                <div class="col-lg-3 col-md-6 d-flex">
                                    <div class="card w-100 my-2 shadow-sm ${p.quantity <= 0 ? 'opacity-75' : ''}">
                                        <img src="assets/images/${p.image}" class="card-img-top" style="aspect-ratio: 1/1; object-fit: cover;"/>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title">${p.getName()}</h5>
                                            <p class="card-text text-danger fw-bold">${p.getPrice()} VNĐ</p>
                                            
                                            <p class="card-text">
                                                <small class="text-muted">Kho: </small>
                                                <span class="badge ${p.quantity > 0 ? 'bg-info' : 'bg-danger'}">
                                                    ${p.quantity > 0 ? p.quantity : 'Hết hàng'}
                                                </span>
                                            </p>

                                            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                                <form action="add-to-cart" method="post" class="w-100">
                                                    <input type="hidden" name="id" value="${p.id}"/>
                                                    <button type="submit" class="btn btn-primary w-100" ${p.quantity <= 0 ? 'disabled' : ''}>
                                                        ${p.quantity > 0 ? 'Add to cart' : 'Out of stock'}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:if>

        <%-- THÔNG BÁO KHÔNG TÌM THẤY --%>
        <c:if test="${empty searchResults && not empty keyword}">
            <div class="col-12">
                <p class="text-center text-muted my-5">Không tìm thấy sản phẩm nào khớp với từ khóa "${keyword}".</p>
            </div>
        </c:if>
    </div>
</div>