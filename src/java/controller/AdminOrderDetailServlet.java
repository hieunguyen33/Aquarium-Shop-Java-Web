package controller.admin;

import data.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.User;

@WebServlet(name = "AdminOrderDetailServlet", urlPatterns = {"/admin/order-detail"})
public class AdminOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. Kiểm tra quyền Admin (Bảo mật)
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("../login");
            return;
        }

        try {
            // 2. Lấy ID đơn hàng từ URL
            int orderId = Integer.parseInt(request.getParameter("id"));
            
            // 3. Lấy thông tin đơn hàng và chi tiết từ Database
            // (Tận dụng lại các hàm DAO đã viết trước đó, không cần viết mới)
            Order order = Database.getOrderDao().findById(orderId);
            List<OrderDetail> details = Database.getOrderDao().findDetailsByOrderId(orderId);

            if (order == null) {
                response.sendRedirect("orders"); // Quay lại danh sách nếu không tìm thấy
                return;
            }

            // 4. Đẩy dữ liệu sang JSP
            request.setAttribute("order", order);
            request.setAttribute("details", details);
            
            // Chuyển hướng đến file JSP chi tiết của Admin
            // Sửa đường dẫn trỏ vào thư mục views
            request.getRequestDispatcher("/views/orderDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orders");
        }
    }
}