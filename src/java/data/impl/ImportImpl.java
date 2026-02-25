package data.impl;

import data.dao.ImportDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ImportHistory;

public class ImportImpl implements ImportDao {

    @Override
    public boolean importProduct(int productId, int adminId, int addQuantity, String note) {
        Connection conn = null;
        try {
            conn = MySQLDriver.getConnection();
            conn.setAutoCommit(false); // ✅ Bắt đầu Transaction

            // 1. Cập nhật số lượng trong bảng products
            String sqlUpdate = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
            try (PreparedStatement ps1 = conn.prepareStatement(sqlUpdate)) {
                ps1.setInt(1, addQuantity);
                ps1.setInt(2, productId);
                ps1.executeUpdate();
            }

            // 2. Ghi lịch sử vào bảng import_history
            String sqlHistory = "INSERT INTO import_history(product_id, admin_id, quantity, note) VALUES(?,?,?,?)";
            try (PreparedStatement ps2 = conn.prepareStatement(sqlHistory)) {
                ps2.setInt(1, productId);
                ps2.setInt(2, adminId);
                ps2.setInt(3, addQuantity);
                ps2.setString(4, note);
                ps2.executeUpdate();
            }

            conn.commit(); // ✅ Thành công toàn bộ mới commit
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
    }

    @Override
    public List<ImportHistory> getAllImportHistory() {
        List<ImportHistory> list = new ArrayList<>();
        String sql = "SELECT h.*, p.name as p_name, u.name as u_name " +
                     "FROM import_history h " +
                     "JOIN products p ON h.product_id = p.id " +
                     "JOIN users u ON h.admin_id = u.id " +
                     "ORDER BY h.import_date DESC";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql);
             ResultSet rs = sttm.executeQuery()) {
            
            while (rs.next()) {
                ImportHistory h = new ImportHistory();
                h.setId(rs.getInt("id"));
                h.setProductName(rs.getString("p_name"));
                h.setAdminName(rs.getString("u_name"));
                h.setQuantity(rs.getInt("quantity"));
                
                // ✅ Sửa lỗi tại đây: Ép kiểu chính xác về java.sql.Timestamp
                h.setImportDate(rs.getTimestamp("import_date")); 
                
                h.setNote(rs.getString("note"));
                list.add(h);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
}