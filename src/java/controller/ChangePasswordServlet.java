package controller;

import data.dao.Database;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // 2. Lấy dữ liệu từ form
        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");

        // 3. Kiểm tra mật khẩu cũ
        // Lưu ý: user.getPassword() phải trả về đúng mật khẩu đang lưu trong DB
        if (user.getPassword() == null || !user.getPassword().equals(oldPass)) {
            session.setAttribute("error", "Mật khẩu cũ không chính xác!");
            response.sendRedirect("profile#tab-password"); // Giữ người dùng ở tab mật khẩu
            return;
        }

        // 4. Kiểm tra xác nhận mật khẩu mới
        if (!newPass.equals(confirmPass)) {
            session.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            response.sendRedirect("profile#tab-password");
            return;
        }
        
        // 5. Kiểm tra độ dài mật khẩu (Tuỳ chọn)
        if (newPass.length() < 6) {
            session.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            response.sendRedirect("profile#tab-password");
            return;
        }

        // 6. Thực hiện đổi mật khẩu trong Database
        boolean isUpdated = Database.getUserDao().changePassword(user.getId(), newPass);

        if (isUpdated) {
            // Cập nhật lại mật khẩu mới vào session để không bị lỗi ở lần đổi tiếp theo
            user.setPassword(newPass);
            session.setAttribute("user", user);
            
            session.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            session.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
        }

        // Quay lại tab password
        response.sendRedirect("profile#tab-password");
    }
}