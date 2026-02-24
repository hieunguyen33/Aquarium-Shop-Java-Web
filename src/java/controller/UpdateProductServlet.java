package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/updateProduct"})
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDao dao = new ProductImpl();
        Product p = dao.find(id);

        request.setAttribute("product", p);
        request.getRequestDispatcher("./inc/updateProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean status = request.getParameter("status") != null;
            int id_category = Integer.parseInt(request.getParameter("categoryId"));

            Product p = new Product(id, name, image, price, quantity, status, id_category);
            ProductDao dao = new ProductImpl();
            dao.update(p);

            response.sendRedirect("listProduct");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
        }
    }
}
