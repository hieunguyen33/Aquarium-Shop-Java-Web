package model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private String khachhang;
    private Timestamp ngaydat;
    private double tongtien;
    private String trangthai;

    public Order() {}

    public Order(int id, String khachhang, Timestamp ngaydat, double tongtien, String trangthai) {
        this.id = id;
        this.khachhang = khachhang;
        this.ngaydat = ngaydat;
        this.tongtien = tongtien;
        this.trangthai = trangthai;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getKhachhang() { return khachhang; }
    public void setKhachhang(String khachhang) { this.khachhang = khachhang; }
    public Timestamp getNgaydat() { return ngaydat; }
    public void setNgaydat(Timestamp ngaydat) { this.ngaydat = ngaydat; }
    public double getTongtien() { return tongtien; }
    public void setTongtien(double tongtien) { this.tongtien = tongtien; }
    public String getTrangthai() { return trangthai; }
    public void setTrangthai(String trangthai) { this.trangthai = trangthai; }
}