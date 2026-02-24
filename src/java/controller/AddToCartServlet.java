package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import model.Cart;
import model.CartItem;
import model.Product;
import model.User; // Import model User để kiểm tra session

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Lấy thông tin User từ session

        // Kiểm tra xem người dùng đã đăng nhập chưa (đối tượng User có tồn tại không)
        if (user == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang login
            response.sendRedirect(request.getContextPath() + "/login"); // Đổi tên trang login nếu cần
            return; // Quan trọng: Dừng xử lý ngay lập tức
        }

        // Nếu người dùng đã đăng nhập, thực hiện thêm sản phẩm vào giỏ hàng như bình thường
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = 1;

        ProductDao productDao = new ProductImpl();
        Product product = productDao.find(productId);

        if (product != null) {
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            CartItem newItem = new CartItem(product, quantity);
            cart.addItem(newItem);

            session.setAttribute("cart", cart);
        }

        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}