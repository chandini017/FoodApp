package com.foodApp.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;
    private int currentRestaurantId = -1;
    private String currentRestaurantName = "";

    public Cart() {
        this.items = new HashMap<>();
    }

    // Returns the name of the OLD restaurant if items were replaced, otherwise returns null
    public String addItem(CartItem item, String restaurantName) {
        String replacedRestaurantName = null;

        // If cart contains items from a DIFFERENT restaurant, replace them!
        if (!items.isEmpty() && currentRestaurantId != -1 && currentRestaurantId != item.getRestaurantId()) {
            replacedRestaurantName = currentRestaurantName;
            items.clear();
        }

        currentRestaurantId = item.getRestaurantId();
        currentRestaurantName = restaurantName;

        int itemId = item.getItemId();
        if (items.containsKey(itemId)) {
            CartItem existingItem = items.get(itemId);
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            items.put(itemId, item);
        }

        return replacedRestaurantName;
    }

    public void updateItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if (quantity <= 0) {
                items.remove(itemId);
                if (items.isEmpty()) {
                    currentRestaurantId = -1;
                    currentRestaurantName = "";
                }
            } else {
                items.get(itemId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
        if (items.isEmpty()) {
            currentRestaurantId = -1;
            currentRestaurantName = "";
        }
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public int getCurrentRestaurantId() {
        return currentRestaurantId;
    }

    public String getCurrentRestaurantName() {
        return currentRestaurantName;
    }

    public double getTotalPrice() {
        double total = 0.0;
        for (CartItem item : items.values()) {
            total += item.getTotalAmount();
        }
        return total;
    }

    public void clear() {
        items.clear();
        currentRestaurantId = -1;
        currentRestaurantName = "";
    }
}