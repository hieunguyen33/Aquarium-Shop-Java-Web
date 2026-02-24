package controller;

import data.dao.UserDao;
import data.impl.UserImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển tiếp đến trang forgotPassword.jsp (form nhập email, sđt, mật khẩu mới)
        request.getRequestDispatcher("/inc/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        UserDao userDao = new UserImpl();
        User user = userDao.findUser(phone); // tìm user theo phone

        if (user != null && user.getEmail() != null 
                && user.getEmail().equalsIgnoreCase(email)) {
            
            // Cập nhật mật khẩu
            userDao.updatePassword(phone, newPassword);

            // Redirect sang trang login với query param báo thành công
            HttpSession session = request.getSession();
            session.setAttribute("success_msg", "Đổi mật khẩu thành công!");
            response.sendRedirect(request.getContextPath() + "/login?success=1");

        } else {
            // Thông tin không khớp → báo lỗi và ở lại trang forgotPassword.jsp
            request.setAttribute("error", "Số điện thoại hoặc email không khớp với hệ thống!");
            request.getRequestDispatcher("/inc/forgotPassword.jsp").forward(request, response);
        }
    }
}
