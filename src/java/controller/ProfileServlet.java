package controller;

import data.dao.Database;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // 1. Lấy danh sách đơn hàng của khách hàng này để theo dõi
            List<Order> orders = Database.getOrderDao().findByUser(user.getName());
            request.setAttribute("orders", orders);
            
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Xử lý cập nhật thông tin khi khách nhấn "Lưu thay đổi"
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email"); // Email dùng để định danh (WHERE)

        User user = new User();
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);

        // Gọi DAO để cập nhật vào Database
        Database.getUserDao().update(user);
        
        // Cập nhật lại thông tin mới vào Session để Navbar hiển thị đúng tên mới
        request.getSession().setAttribute("user", user);
        
        // Quay lại trang profile để thấy kết quả
        response.sendRedirect("profile");
    }
}