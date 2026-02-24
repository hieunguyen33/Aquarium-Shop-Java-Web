package controller;

import data.dao.Database;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DonHangServlet", urlPatterns = {"/donhang"})
public class DonHangServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy danh sách đơn hàng THẬT từ Database
        // Sắp xếp theo ngày đặt mới nhất (DESC)
        List<Order> orders = Database.getOrderDao().findAll();

        // 2. Gửi dữ liệu thật qua JSP
        request.setAttribute("orders", orders);
        
        // 3. Forward đến trang quản lý đơn hàng
        request.getRequestDispatcher("./inc/donhang.jsp").forward(request, response);
    }
}