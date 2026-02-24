package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ListProductServlet", urlPatterns = {"/listProduct"})
public class ListProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDao dao = new ProductImpl();
            List<Product> list = dao.findAll();

            request.setAttribute("list", list);
            request.getRequestDispatcher("./inc/listProduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Có lỗi khi tải danh sách sản phẩm: " + e.getMessage());
        }
    }
}
