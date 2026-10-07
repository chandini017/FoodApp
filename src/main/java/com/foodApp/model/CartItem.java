package com.foodApp.model;

public class CartItem {
    private int itemId;        // Maps to menuId
    private int restaurantId;  // Maps to restaurantId
    private String name;       // Maps to itemName
    private int quantity;
    private double price;
    private double totalAmount;

    public CartItem() {}

    public CartItem(int itemId, int restaurantId, String name, int quantity, double price) {
        this.itemId = itemId;
        this.restaurantId = restaurantId;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.totalAmount = price * quantity;
    }

    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        this.quantity = quantity;
        this.totalAmount = this.price * quantity; 
    }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getTotalAmount() { return totalAmount; }
}