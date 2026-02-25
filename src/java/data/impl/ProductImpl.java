package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductImpl implements ProductDao {

    @Override
    public List<Product> findAll() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql);
             ResultSet rs = sttm.executeQuery()) {
            while (rs.next()) {
                listProduct.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getString("image"),
                    rs.getDouble("price"), rs.getInt("quantity"), rs.getBoolean("status"), rs.getInt("id_category")));
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return listProduct;
    }

    @Override
    public Product find(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setInt(1, id);
            try (ResultSet rs = sttm.executeQuery()) {
                if (rs.next()) return new Product(rs.getInt("id"), rs.getString("name"), rs.getString("image"),
                    rs.getDouble("price"), rs.getInt("quantity"), rs.getBoolean("status"), rs.getInt("id_category"));
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    @Override
    public void updateQuantity(int id, int quantitySold) {
        String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setInt(1, quantitySold);
            sttm.setInt(2, id);
            sttm.setInt(3, quantitySold);
            sttm.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    @Override 
    public boolean insert(Product p) { 
        String sql = "INSERT INTO products(name, image, price, quantity, status, id_category) VALUES (?, ?, ?, ?, ?, ?)";
        // Thêm Statement.RETURN_GENERATED_KEYS để lấy ID vừa tạo
        try (Connection con = MySQLDriver.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, p.getName()); 
            ps.setString(2, p.getImage()); 
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity()); 
            ps.setBoolean(5, p.isStatus()); 
            ps.setInt(6, p.getId_category());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                // Lấy ID tự động sinh ra từ database
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        p.setId(rs.getInt(1)); // Gán ngược ID vào đối tượng p
                    }
                }
                return true;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
        return false;
    }
    
    @Override public boolean update(Product p) { 
        String sql = "UPDATE products SET name=?, image=?, price=?, quantity=?, status=?, id_category=? WHERE id=?";
        try (Connection con = MySQLDriver.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName()); ps.setString(2, p.getImage()); ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity()); ps.setBoolean(5, p.isStatus()); ps.setInt(6, p.getId_category());
            ps.setInt(7, p.getId()); return ps.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    @Override public boolean delete(int id) { 
        try (Connection con = MySQLDriver.getConnection(); PreparedStatement ps = con.prepareStatement("DELETE FROM products WHERE id=?")) {
            ps.setInt(1, id); return ps.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    @Override public List<Product> searchProducts(String kw) { 
        List<Product> list = new ArrayList<>();
        try (Connection con = MySQLDriver.getConnection(); PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE name LIKE ?")) {
            ps.setString(1, "%" + kw + "%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"), rs.getInt("quantity"), rs.getBoolean("status"), rs.getInt("id_category")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    

    @Override public boolean addProduct(Product product) { return insert(product); }
    @Override public boolean updateProduct(Product product) { return update(product); }
    @Override public boolean deleteProduct(int id) { return delete(id); }
    @Override public Product getProductById(int id) { return find(id); }
    @Override public List<Product> getAllProducts() { return findAll(); }
}