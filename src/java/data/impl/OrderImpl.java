package data.impl;

import data.dao.OrderDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;

public class OrderImpl implements OrderDao {

    @Override
    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders (khachhang, tongtien, trangthai) VALUES (?, ?, ?)";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, order.getKhachhang());
            ps.setDouble(2, order.getTongtien());
            ps.setString(3, order.getTrangthai());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public void insertOrderDetail(OrderDetail detail) {
        String sql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getPrice());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public List<OrderDetail> findDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.name AS product_name, p.image AS product_image FROM order_details od "
                   + "JOIN products p ON od.product_id = p.id WHERE od.order_id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail d = new OrderDetail();
                    d.setId(rs.getInt("id"));
                    d.setOrderId(rs.getInt("order_id"));
                    d.setProductId(rs.getInt("product_id"));
                    d.setQuantity(rs.getInt("quantity"));
                    d.setPrice(rs.getDouble("price"));
                    d.setProductName(rs.getString("product_name"));
                    d.setProductImage(rs.getString("product_image"));
                    list.add(d);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Order> findByUser(String username) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE khachhang = ? ORDER BY ngaydat DESC";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Order(rs.getInt("id"), rs.getString("khachhang"), 
                                     rs.getTimestamp("ngaydat"), rs.getDouble("tongtien"), rs.getString("trangthai")));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public Order findById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new Order(rs.getInt("id"), rs.getString("khachhang"), 
                                              rs.getTimestamp("ngaydat"), rs.getDouble("tongtien"), rs.getString("trangthai"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public void updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET trangthai = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public void deleteOrder(int id) {
        // Xóa chi tiết trước rồi mới xóa đơn hàng để tránh lỗi khóa ngoại
        String sqlDetail = "DELETE FROM order_details WHERE order_id = ?";
        String sqlOrder = "DELETE FROM orders WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement psD = con.prepareStatement(sqlDetail);
                 PreparedStatement psO = con.prepareStatement(sqlOrder)) {
                psD.setInt(1, id);
                psD.executeUpdate();
                psO.setInt(1, id);
                psO.executeUpdate();
                con.commit();
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public boolean cancelOrderAndReturnStock(int orderId) {
        String sqlGetDetails = "SELECT product_id, quantity FROM order_details WHERE order_id = ?";
        String sqlUpdateStock = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
        String sqlUpdateOrder = "UPDATE orders SET trangthai = ? WHERE id = ?";
        
        try (Connection con = MySQLDriver.getConnection()) {
            con.setAutoCommit(false);
            try {
                // 1. Lấy danh sách sản phẩm trong đơn để cộng lại kho
                List<OrderDetail> details = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement(sqlGetDetails)) {
                    ps.setInt(1, orderId);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        OrderDetail d = new OrderDetail();
                        d.setProductId(rs.getInt("product_id"));
                        d.setQuantity(rs.getInt("quantity"));
                        details.add(d);
                    }
                }
                // 2. Cộng lại số lượng vào kho
                try (PreparedStatement psS = con.prepareStatement(sqlUpdateStock)) {
                    for (OrderDetail d : details) {
                        psS.setInt(1, d.getQuantity());
                        psS.setInt(2, d.getProductId());
                        psS.executeUpdate();
                    }
                }
                // 3. Đổi trạng thái đơn hàng thành 'Đã hủy'
                try (PreparedStatement psO = con.prepareStatement(sqlUpdateOrder)) {
                    psO.setString(1, "Đã hủy");
                    psO.setInt(2, orderId);
                    psO.executeUpdate();
                }
                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    @Override
    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY ngaydat DESC";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Order(rs.getInt("id"), rs.getString("khachhang"), 
                                 rs.getTimestamp("ngaydat"), rs.getDouble("tongtien"), rs.getString("trangthai")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}