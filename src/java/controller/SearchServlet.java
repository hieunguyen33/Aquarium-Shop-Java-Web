package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu từ khóa rỗng, chuyển hướng về trang chủ
            response.sendRedirect("home");
            return;
        }

        ProductDao productDao = new ProductImpl();
        // Lấy danh sách sản phẩm từ database dựa trên từ khóa tìm kiếm
        List<Product> searchResults = productDao.searchProducts(keyword);
        
        // --- THÊM HAI DÒNG NÀY ĐỂ KIỂM TRA LỖI ---
        System.out.println(keyword);
        System.out.println(searchResults.size());
        
        // Đặt danh sách kết quả vào request để JSP có thể hiển thị
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("keyword", keyword);
        
        // Chuyển hướng đến trang home.jsp để hiển thị kết quả
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}