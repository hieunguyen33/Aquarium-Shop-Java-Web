package controller;

import data.dao.Database;
import model.Order;
import model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            
            // Lấy thông tin đơn hàng tổng quát
            Order order = Database.getOrderDao().findById(orderId);
            
            // Lấy danh sách các sản phẩm (cá, tôm...) trong đơn đó
            List<OrderDetail> details = Database.getOrderDao().findDetailsByOrderId(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("details", details);
            
            // Chuyển hướng đến trang chi tiết (Bạn có thể để trong /views/ hoặc /inc/)
            request.getRequestDispatcher("inc/orderDetail.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendRedirect("profile");
        }
    }
}