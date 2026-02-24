package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String userMsg = request.getParameter("message");
        String reply;

        if ("1".equals(userMsg)) {
            reply = "Bạn có thể xem thông tin sản phẩm ở trang Sản phẩm.";
        } else if ("2".equals(userMsg)) {
            reply = "Để mua hàng, bạn hãy thêm sản phẩm vào giỏ và thanh toán.";
        } else if ("3".equals(userMsg)) {
            reply = "Bạn có thể gọi hotline: 0123-456-789 để gặp nhân viên.";
        } else {
            reply = "Xin lỗi, mình chưa hiểu. Vui lòng chọn 1, 2 hoặc 3.";
        }

        response.getWriter().write(reply);
    }
}
