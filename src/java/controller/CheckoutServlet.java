package controller;

import data.dao.Database;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        // 1. Kiểm tra giỏ hàng và đăng nhập
        if (cart == null || cart.getItems().isEmpty()) {
            // SỬA LỖI: Chuyển về "cart" (Servlet) thay vì "cart.jsp"
            response.sendRedirect("cart"); 
            return;
        }
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ==================================================================
        // BƯỚC 1: KIỂM TRA TỒN KHO
        // ==================================================================
        for (CartItem item : cart.getItems()) {
            // Lấy thông tin mới nhất từ Database
            Product dbProduct = Database.getProductDao().find(item.getProduct().getId());
            
            // a) Sản phẩm không còn tồn tại
            if (dbProduct == null) {
                session.setAttribute("error", "Sản phẩm " + item.getProduct().getName() + " không còn tồn tại!");
                response.sendRedirect("cart"); // SỬA LỖI: Chuyển về Servlet "cart"
                return; 
            }

            // b) Số lượng đặt lớn hơn số lượng trong kho
            if (item.getQuantity() > dbProduct.getQuantity()) {
                session.setAttribute("error", "Lỗi: Sản phẩm [" + dbProduct.getName() + "] chỉ còn " 
                        + dbProduct.getQuantity() + " sản phẩm. Bạn không thể đặt " + item.getQuantity() + "!");
                // SỬA LỖI: Chuyển về Servlet "cart" để hiển thị thông báo lỗi
                response.sendRedirect("cart"); 
                return; // DỪNG LẠI NGAY
            }
        }

        // ==================================================================
        // BƯỚC 2: THANH TOÁN (Chỉ chạy khi kho ĐỦ HÀNG)
        // ==================================================================
        try {
            // Tạo đối tượng đơn hàng
            Order order = new Order(
                    0,
                    user.getName(),
                    null, 
                    cart.getTotalPrice(),
                    "Đang xử lý"
            );

            // Lưu đơn hàng và nhận về ID
            int orderId = Database.getOrderDao().insertOrder(order);

            if (orderId <= 0) {
                throw new Exception("Lỗi Database: Không tạo được ID đơn hàng.");
            }

            // Lưu chi tiết và Trừ kho
            for (CartItem item : cart.getItems()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setProductId(item.getProduct().getId());
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getProduct().getPrice());

                // Lưu vào bảng order_details
                Database.getOrderDao().insertOrderDetail(detail);
                
                // Trừ số lượng thực tế trong bảng products
                Database.getProductDao().updateQuantity(
                        item.getProduct().getId(), 
                        item.getQuantity()
                );
            }

            // Xóa giỏ hàng sau khi thành công
            session.removeAttribute("cart");
            data.utils.CartSync.clearCart(user.getId());
            // Chuyển hướng đến trang thành công
            // (Đảm bảo file success.jsp nằm đúng trong thư mục inc/)
            request.getRequestDispatcher("inc/success.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); 
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            // SỬA LỖI: Chuyển về Servlet "cart" nếu có lỗi
            response.sendRedirect("cart");
        }
    }
}