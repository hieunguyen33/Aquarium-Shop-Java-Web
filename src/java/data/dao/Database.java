package data.dao;

import data.impl.CategoryImpl;
import data.impl.OrderImpl;
import data.impl.ProductImpl;
import data.impl.UserImpl;
import data.driver.MySQLDriver;
import data.impl.ImportImpl;
import java.sql.Connection;

public class Database {
    public static CategoryDao getCategoryDao(){
        return new CategoryImpl();
    }
    public static ProductDao getProductDao(){
        return new ProductImpl();
    }
    public static UserDao getUserDao(){
        return new UserImpl();
    }
    public static OrderDao getOrderDao() {
        return new OrderImpl();
    }
    public static ImportDao getImportDao() {
        return new ImportImpl();
    }

    public static Connection getConnection() {
        return MySQLDriver.getConnection();
    }
}