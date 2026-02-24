<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thành công</title>
    <jsp:include page="../inc/header.jsp"/>
</head>
<body>
    <jsp:include page="../inc/navbar.jsp"/>
    <div class="container my-5 text-center">
        <div class="card p-5 shadow-sm">
            <h2 class="text-success mb-3">Đặt hàng thành công!</h2>
            <p>Đơn hàng của bạn đang được xử lý. Cảm ơn bạn đã mua sắm!</p>
            <a href="home" class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
        </div>
    </div>
    <jsp:include page="../inc/footer.jsp"/>
</body>
</html>