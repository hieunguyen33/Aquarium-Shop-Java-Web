package data.dao;
import java.util.List;
import model.Product;
public interface ProductDao {
    public List<Product> findAll();
    public boolean insert(Product product);
    public boolean update(Product product);
    public boolean delete(int id);
    public Product find(int id);
    public List<Product> searchProducts(String keyword);
    public boolean addProduct(Product product);
    public boolean updateProduct(Product product);
    public boolean deleteProduct(int id);
    public Product getProductById(int id);
    public List<Product> getAllProducts();
    public void updateQuantity(int id, int quantitySold);
}