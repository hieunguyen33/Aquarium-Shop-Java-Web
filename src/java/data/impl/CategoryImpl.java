package data.impl;

import data.dao.CategoryDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryImpl implements CategoryDao {

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement("SELECT * FROM categories");
             ResultSet rs = sttm.executeQuery()) {
            while (rs.next()) list.add(new Category(rs.getInt("id"), rs.getString("name")));
        } catch (SQLException ex) { ex.printStackTrace(); }
        return list;
    }

    @Override
    public boolean insert(String name) {
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement("INSERT INTO categories (name) VALUES (?)")) {
            sttm.setString(1, name);
            return sttm.executeUpdate() > 0;
        } catch (SQLException ex) { return false; }
    }

    @Override
    public boolean update(int id, String name) {
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement("UPDATE categories SET name = ? WHERE id = ?")) {
            sttm.setString(1, name); sttm.setInt(2, id);
            return sttm.executeUpdate() > 0;
        } catch (SQLException ex) { return false; }
    }

    @Override
    public boolean delete(int id) {
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement("DELETE FROM categories WHERE id = ?")) {
            sttm.setInt(1, id);
            return sttm.executeUpdate() > 0;
        } catch (SQLException ex) { return false; }
    }

    @Override
    public Category find(int id) {
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement("SELECT * FROM categories WHERE id = ?")) {
            sttm.setInt(1, id);
            try (ResultSet rs = sttm.executeQuery()) {
                if (rs.next()) return new Category(rs.getInt("id"), rs.getString("name"));
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    @Override public boolean addCategory(Category c) { return insert(c.getName()); }
    @Override public boolean updateCategory(Category c) { return update(c.getId(), c.getName()); }
    @Override public boolean deleteCategory(int id) { return delete(id); }
    @Override public Category getCategoryById(int id) { return find(id); }
    @Override public List<Category> getAllCategories() { return findAll(); }
}