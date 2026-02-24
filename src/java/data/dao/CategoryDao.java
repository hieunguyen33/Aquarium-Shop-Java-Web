package data.dao;

import java.util.List;
import model.Category;

public interface CategoryDao {
    
    public List<Category> findAll();
    public boolean insert(String name);
    public boolean update(int id, String name);
    public boolean delete(int id);
    public Category find(int id);
    
    // Phương thức bổ sung để quản lý danh mục đầy đủ hơn
    public boolean addCategory(Category category);
    public boolean updateCategory(Category category);
    public boolean deleteCategory(int id);
    public Category getCategoryById(int id);
    public List<Category> getAllCategories();
}