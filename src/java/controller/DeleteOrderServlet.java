package controller;

import data.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteOrderServlet", urlPatterns = {"/delete-order"})
public class DeleteOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            // Chỉ cho phép xóa nếu đơn hàng ở trạng thái Đã hủy hoặc Hoàn thành để tránh xóa đơn đang xử lý
            Database.getOrderDao().deleteOrder(id);
            request.getSession().setAttribute("message", "Đã xóa đơn hàng khỏi lịch sử!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("profile#history");
    }
}