package data.dao;

import java.util.List;
import model.Order;
import model.OrderDetail;

public interface OrderDao {

    int insertOrder(Order order); // ❗ đổi void → int

    void insertOrderDetail(OrderDetail detail);

    List<OrderDetail> findDetailsByOrderId(int orderId);

    List<Order> findByUser(String username);

    Order findById(int id);

    void updateStatus(int orderId, String status);

    void deleteOrder(int id);

    boolean cancelOrderAndReturnStock(int orderId);

    List<Order> findAll();
}
