<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Sidebar (ẩn mặc định) */
    .sidebar{
        height: 100%;
        width: 0; /* mặc định ẩn */
        position: fixed;
        top:0;
        left:0;
        background:linear-gradient(180deg,#0d6efd,#0b5ed7);
        overflow-x: hidden;
        transition: 0.3s;
        padding-top: 60px;
        z-index: 1000;
        box-shadow:2px 0 8px rgba(0,0,0,.08);
    }
    .sidebar h5{ text-align:center; font-weight:700; margin-bottom:1rem; color:#fff; }
    .sidebar .nav-link{ color:#fff; border-radius:8px; margin:4px 12px; padding:10px 14px; }
    .sidebar .nav-link:hover{ background:rgba(255,255,255,.18); }
    .sidebar .nav-link.active{ background:#ffc107; color:#000; font-weight:700; }
    .sidebar .close-btn{
        position:absolute; top:15px; right:20px;
        font-size:30px; color:#fff; cursor:pointer;
    }
</style>

<nav id="sidebar" class="sidebar">
    <span class="close-btn" onclick="closeSidebar()">×</span>
    <div class="px-3">
        <h5>Admin Panel</h5>
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="admin">Trang chủ</a></li>
            <li class="nav-item"><a class="nav-link" href="listProduct">Sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="donhang">Đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="addProduct">Thêm sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
        </ul>
    </div>
</nav>

<script>
    function openSidebar() {
        document.getElementById("sidebar").style.width = "240px";
    }
    function closeSidebar() {
        document.getElementById("sidebar").style.width = "0";
    }
</script>