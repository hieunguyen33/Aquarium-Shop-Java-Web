package data.utils;

import data.dao.Database;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Cart;
import model.CartItem;
import model.Product;
import model.User;
import jakarta.servlet.http.HttpSession;

public class CartSync {

    // Hàm 1: Lưu giỏ hàng từ Session vào Database (Dùng khi Đăng xuất)
    public static void saveCart(HttpSession session) {
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user != null && cart != null && !cart.getItems().isEmpty()) {
            try (Connection con = MySQLDriver.getConnection()) {
                // 1. Xóa giỏ hàng cũ của user này trong DB
                String sqlDelete = "DELETE FROM cart_items WHERE user_id = ?";
                try (PreparedStatement psDel = con.prepareStatement(sqlDelete)) {
                    psDel.setInt(1, user.getId());
                    psDel.executeUpdate();
                }

                // 2. Thêm giỏ hàng hiện tại vào DB
                String sqlInsert = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement psIns = con.prepareStatement(sqlInsert)) {
                    for (CartItem item : cart.getItems()) {
                        psIns.setInt(1, user.getId());
                        psIns.setInt(2, item.getProduct().getId());
                        psIns.setInt(3, item.getQuantity());
                        psIns.addBatch(); // Gom lệnh lại chạy 1 lần cho nhanh
                    }
                    psIns.executeBatch();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Hàm 2: Lôi giỏ hàng từ Database bỏ vào Session (Dùng khi Đăng nhập)
    public static void loadCart(HttpSession session, User user) {
        if (user == null) return;

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String sql = "SELECT product_id, quantity FROM cart_items WHERE user_id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int pId = rs.getInt("product_id");
                int qty = rs.getInt("quantity");
                
                // Lấy thông tin sản phẩm để hiển thị tên, giá, ảnh...
                Product product = Database.getProductDao().getProductById(pId);
                if (product != null) {
                    CartItem item = new CartItem(product, qty);
                    // Lưu ý: Bạn cần đảm bảo hàm addItem trong Cart.java cộng dồn đúng
                    cart.addItem(item); 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Hàm 3: Xóa sạch giỏ hàng trong DB (Dùng khi Thanh toán thành công)
    public static void clearCart(int userId) {
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM cart_items WHERE user_id = ?")) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}