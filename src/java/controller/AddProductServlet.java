package controller;

import data.dao.Database;
import data.dao.ProductDao;
import data.dao.ImportDao;
import data.impl.ProductImpl;
import data.impl.ImportImpl;
import model.Category;
import model.Product;
import model.User; // Giả sử bạn có model User
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/addProduct"})
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> listCategory = Database.getCategoryDao().findAll();
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("./inc/addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean status = request.getParameter("status") != null;
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // 1. Tạo đối tượng và insert sản phẩm
            Product p = new Product(0, name, image, price, quantity, status, categoryId);
            ProductDao productDao = new ProductImpl();
            boolean isInserted = productDao.insert(p);

            if (isInserted) {
                // 2. GHI LỊCH SỬ NHẬP HÀNG (Phần Hiệu đang thiếu)
                // Lấy adminId từ session (người đang đăng nhập)
                HttpSession session = request.getSession();
                User admin = (User) session.getAttribute("user"); // Tên attribute tùy bạn đặt lúc login
                
                int adminId = (admin != null) ? admin.getId() : 1; // Mặc định là 1 nếu chưa login (để test)
                String note = "Nhập hàng tự động khi thêm sản phẩm mới";

                // Gọi ImportDao để lưu vết
                ImportDao importDao = new ImportImpl();
                importDao.importProduct(p.getId(), adminId, quantity, note); 

                request.setAttribute("message", "Đã thêm sản phẩm và ghi nhận lịch sử nhập kho!");
            } else {
                request.setAttribute("error", "Lỗi: Không thể thêm sản phẩm!");
            }
            
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            doGet(request, response);
        }
    }
}