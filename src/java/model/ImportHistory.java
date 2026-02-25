/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp; 

/**
 *
 * @author HIEU PC
 */
public class ImportHistory {
    private int id;
    private int productId;
    private String productName; // Để hiển thị tên trên giao diện
    private int adminId;
    private String adminName;   // Để hiển thị tên Admin thực hiện
    private int quantity;
    private Timestamp importDate;
    private String note;

    public ImportHistory() {}

    // Getter và Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public Timestamp getImportDate() { return importDate; }
    public void setImportDate(Timestamp importDate) { this.importDate = importDate; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
