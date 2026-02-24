package controller;

import data.dao.Database;
import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Category;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/addProduct"})
public class AddProductServlet extends HttpServlet {

    // Phương thức hiển thị Form thêm sản phẩm
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy danh sách danh mục (Betta, Guppy...) từ Database để hiển thị trong select
        List<Category> listCategory = Database.getCategoryDao().findAll();
        request.setAttribute("listCategory", listCategory);
        
        // Chuyển hướng đến trang addProduct.jsp
        request.getRequestDispatcher("./inc/addProduct.jsp").forward(request, response);
    }

    // Phương thức xử lý khi nhấn nút "Xác nhận thêm"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ Form gửi lên
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean status = request.getParameter("status") != null; // Kiểm tra checkbox
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // Tạo đối tượng Product và thực hiện chèn vào CSDL
            Product p = new Product(0, name, image, price, quantity, status, categoryId);
            ProductDao dao = new ProductImpl();
            boolean result = dao.insert(p);

            if (result) {
                // Nếu thành công, gửi thông báo "Đã thêm thành công" sang JSP
                request.setAttribute("message", "Đã thêm sản phẩm thành công!");
            } else {
                request.setAttribute("error", "Lỗi: Không thể thêm sản phẩm!");
            }
            
            // Sau khi xử lý xong, gọi lại doGet để nạp lại danh mục và hiển thị lại trang
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            doGet(request, response);
        }
    }
}