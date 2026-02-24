/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.utils.CartSync; // Import class đồng bộ giỏ hàng
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import model.User;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"}) 
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Login Page");
        request.getRequestDispatcher("./views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String emailphone = request.getParameter("emailphone");
        String password = request.getParameter("password");

        User user = Database.getUserDao().findUser(emailphone, password);

        if (user == null) {
            request.getSession().setAttribute("error_login", "Your information is incorrect!");
            response.sendRedirect("login");
        } else if ("admin".equals(user.getRole())) { // So sánh chuỗi an toàn hơn
            // Xóa thông báo đổi mật khẩu nếu có
            request.getSession().removeAttribute("success_msg");
            
            // Lưu user vào session
            request.getSession().setAttribute("user", user);
            
            response.sendRedirect("admin");
        } else {
            request.getSession().removeAttribute("error_login");
            request.getSession().setAttribute("user", user);

            // ✅ BƯỚC 2: TẢI GIỎ HÀNG CŨ TỪ DB LÊN SESSION
            CartSync.loadCart(request.getSession(), user);

            // Xóa thông báo đổi mật khẩu sau khi đăng nhập thành công
            request.getSession().removeAttribute("success_msg");

            response.sendRedirect("home");
        }
    }

}