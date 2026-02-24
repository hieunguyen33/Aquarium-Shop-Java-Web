package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FindProductServlet", urlPatterns = {"/findProduct"})
public class FindProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idRaw    = request.getParameter("id");       // tìm theo ID (nếu có)
        String keyword  = request.getParameter("keyword");  // tìm theo tên (form của bạn)
        String nameAlt  = request.getParameter("name");     // dự phòng nếu form dùng 'name'

        ProductDao dao = new ProductImpl();
        List<Product> result = new ArrayList<>();

        try {
            // Ưu tiên tìm theo ID nếu có nhập
            if (isNotBlank(idRaw)) {
                int id = Integer.parseInt(idRaw.trim());
                Product p = dao.find(id);
                if (p != null) {
                    result.add(p);
                }
            } else {
                // Nếu không có ID -> lọc theo tên trên danh sách hiện có
                String key = isNotBlank(keyword) ? keyword.trim()
                           : (isNotBlank(nameAlt) ? nameAlt.trim() : null);

                List<Product> all = dao.findAll();
                if (isNotBlank(key)) {
                    String keyLower = key.toLowerCase();
                    for (Product p : all) {
                        if (p.getName() != null && p.getName().toLowerCase().contains(keyLower)) {
                            result.add(p);
                        }
                    }
                } else {
                    // Không nhập gì -> trả toàn bộ
                    result = all;
                }
            }

            // Gửi lại dữ liệu cho trang danh sách
            request.setAttribute("list", result);
            request.setAttribute("keyword", keyword); // giữ lại keyword nếu cần hiển thị lại
            request.getRequestDispatcher("./inc/listProduct.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Nhập ID không phải số -> trả về toàn bộ + thông báo lỗi
            request.setAttribute("error", "ID phải là số nguyên hợp lệ.");
            request.setAttribute("list", dao.findAll());
            request.getRequestDispatcher("./inc/listProduct.jsp").forward(request, response);
        }
    }

    private boolean isNotBlank(String s) {
        return s != null && !s.trim().isEmpty();
    }
}
