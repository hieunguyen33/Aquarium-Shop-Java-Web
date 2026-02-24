package controller;

import data.dao.Database;
import data.utils.API; // Đảm bảo đã import API để dùng MD5
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

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // 1. Lấy dữ liệu từ form (mật khẩu thuần người dùng nhập)
        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");

        // 2. MÃ HÓA mật khẩu cũ người dùng vừa nhập để đi so sánh
        // Vì trong database/session của bạn đang lưu chuỗi MD5 (202cb962...)
        String oldPassMd5 = API.getMd5(oldPass); 

        // 3. KIỂM TRA: So sánh 2 chuỗi MD5 với nhau
        if (user.getPassword() == null || !user.getPassword().equals(oldPassMd5)) {
            session.setAttribute("error", "Mật khẩu cũ không chính xác!");
            response.sendRedirect("profile#tab-password");
            return;
        }

        // 4. Kiểm tra xác nhận mật khẩu mới
        if (!newPass.equals(confirmPass)) {
            session.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            response.sendRedirect("profile#tab-password");
            return;
        }
        
        if (newPass.length() < 3) { // Bạn đang dùng mk '123' nên tôi để độ dài tối thiểu là 3
            session.setAttribute("error", "Mật khẩu mới quá ngắn!");
            response.sendRedirect("profile#tab-password");
            return;
        }

        // 5. Cập nhật vào Database (Hàm này trong UserImpl cũng phải có API.getMd5)
        boolean isUpdated = Database.getUserDao().changePassword(user.getId(), newPass);

        if (isUpdated) {
            // ✅ CẬP NHẬT SESSION: Lưu lại mã MD5 của mật khẩu mới
            user.setPassword(API.getMd5(newPass)); 
            session.setAttribute("user", user);
            
            session.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            session.setAttribute("error", "Lỗi hệ thống!");
        }

        response.sendRedirect("profile#tab-password");
    }
}