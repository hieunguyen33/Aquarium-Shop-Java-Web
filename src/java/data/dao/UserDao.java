package data.dao;

import model.User;

public interface UserDao {
    public User findUser(String emailphone, String password);
    public User findUser(String emailphone);
    public void insertUser(String name, String email, String phone, String password);

    // thêm để đổi mật khẩu
    public void updatePassword(String phone, String newPassword);
    void update(User user);
    // Thêm dòng này vào interface
    boolean changePassword(int userId, String newPassword);
}
