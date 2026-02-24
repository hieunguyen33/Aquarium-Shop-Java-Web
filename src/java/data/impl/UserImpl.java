package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import data.utils.API;
import java.sql.*;
import model.User;

public class UserImpl implements UserDao {

    @Override
    public User findUser(String emailphone, String password) {
        String sql = "SELECT * FROM users WHERE (email = ? OR phone = ?) AND password = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setString(1, emailphone);
            sttm.setString(2, emailphone);
            sttm.setString(3, API.getMd5(password));
            try (ResultSet rs = sttm.executeQuery()) {
                if (rs.next()) return new User(rs);
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    @Override
    public User findUser(String emailphone) {
        String sql = "SELECT * FROM users WHERE email = ? OR phone = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setString(1, emailphone);
            sttm.setString(2, emailphone);
            try (ResultSet rs = sttm.executeQuery()) {
                if (rs.next()) return new User(rs);
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    @Override
    public void insertUser(String name, String email, String phone, String password) {
        String sql = "INSERT INTO users(name, email, phone, password, role) VALUES(?, ?, ?, ?, ?)";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setString(1, name); sttm.setString(2, email);
            sttm.setString(3, phone); sttm.setString(4, API.getMd5(password));
            sttm.setString(5, "user");
            sttm.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    public void updatePassword(String phone, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE phone = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement sttm = con.prepareStatement(sql)) {
            sttm.setString(1, API.getMd5(newPassword));
            sttm.setString(2, phone);
            sttm.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
    @Override
public boolean changePassword(int userId, String newPassword) {
    String sql = "UPDATE users SET password = ? WHERE id = ?";
    try (Connection con = MySQLDriver.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, newPassword);
        ps.setInt(2, userId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    @Override
    public void update(User user) {
        String sql = "UPDATE users SET name = ?, phone = ? WHERE email = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}