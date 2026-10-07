package com.foodApp.dao;

import java.util.List;
import com.foodApp.model.OrderItem;

public interface Orderitemdao {

    void addOrderItem(OrderItem orderItem);

    OrderItem getOrderItem(int orderItemId);

    void updateOrderItem(OrderItem orderItem);

    void deleteOrderItem(int orderItemId);

    List<OrderItem> getAllOrderItems();
}