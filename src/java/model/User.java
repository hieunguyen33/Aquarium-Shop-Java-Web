package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    int id;
    String name, email, phone, password, role;

    public User() {
    }

    public User(ResultSet rs) throws SQLException {
        this.id = rs.getInt("id");
        // Dùng .trim() để xóa khoảng trắng thừa từ CSDL
        this.name = rs.getString("name") != null ? rs.getString("name").trim() : "";
        this.email = rs.getString("email") != null ? rs.getString("email").trim() : "";
        this.phone = rs.getString("phone") != null ? rs.getString("phone").trim() : "";
        this.password = rs.getString("password") != null ? rs.getString("password").trim() : "";
        
        // Xử lý riêng Role: Nếu null thì gán chuỗi rỗng để tránh lỗi .equals() ở Servlet
        String r = rs.getString("role");
        this.role = (r != null) ? r.trim() : "";
    }

    public User(int id, String name, String email, String phone, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String splitName(String fullName) {
        if (fullName == null || fullName.isEmpty()) return "";
        String[] s = fullName.trim().split(" ");
        return s[s.length - 1];
    }
}