package model;

public class Product {
    private int id;
    private String name;
    private String image;
    private double price;
    private int quantity;
    private boolean status;
    private int id_category;

    public Product() {
    }

    public Product(int id, String name, String image, double price, int quantity, boolean status, int id_category) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.id_category = id_category;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }

    public int getId_category() { return id_category; }
    public void setId_category(int id_category) { this.id_category = id_category; }
}