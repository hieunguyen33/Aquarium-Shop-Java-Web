package data.dao;

import java.util.List;
import model.ImportHistory;

public interface ImportDao {
    // Thực hiện nghiệp vụ nhập hàng (Cập nhật kho + Lưu lịch sử)
    public boolean importProduct(int productId, int adminId, int addQuantity, String note);
    
    // Lấy danh sách lịch sử để hiển thị
    public List<ImportHistory> getAllImportHistory();
}