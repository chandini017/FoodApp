package com.foodApp.dao;

import java.util.List;
import com.foodApp.model.Order;

public interface Orderdao {

    void addOrder(Order order);

    Order getOrder(int orderId);

    void updateOrder(Order order);

    void deleteOrder(int orderId);

    List<Order> getAllOrders();
}