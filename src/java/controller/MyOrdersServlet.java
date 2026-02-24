package controller;

import data.dao.Database;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyOrdersServlet", urlPatterns = {"/my-orders"})
public class MyOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // Chỉ lấy đơn hàng có tên 'khachhang' trùng với người đang đăng nhập
            List<Order> orders = Database.getOrderDao().findByUser(user.getName());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("./views/myOrders.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }
}