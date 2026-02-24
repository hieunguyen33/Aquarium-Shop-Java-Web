package controller;

import data.dao.Database;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancel-order"})
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = Database.getOrderDao().findById(orderId);

            if (order != null && order.getTrangthai().equals("Đang xử lý")) {
                // Kiểm tra thời gian 3 tiếng
                long currentTime = System.currentTimeMillis();
                long orderTime = order.getNgaydat().getTime();
                long diff = currentTime - orderTime;

                if (diff < (3 * 60 * 60 * 1000)) {
                    // Gọi hàm hủy đơn kèm hoàn kho
                    boolean success = Database.getOrderDao().cancelOrderAndReturnStock(orderId);
                    if (success) {
                        session.setAttribute("message", "Đã hủy đơn hàng và hoàn số lượng vào kho!");
                    } else {
                        session.setAttribute("error", "Lỗi hệ thống khi hủy đơn!");
                    }
                } else {
                    session.setAttribute("error", "Không thể hủy! Đơn hàng đã quá 3 tiếng.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("profile#history");
    }
}