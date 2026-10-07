package com.foodApp.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.dao.Orderitemdao;
import com.foodApp.model.OrderItem;

public class Orderitemdaoimp implements Orderitemdao {

    private Connection connection;

    public Orderitemdaoimp(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addOrderItem(OrderItem orderItem) {

        String sql = "INSERT INTO OrderItem "
                + "(OrderID, MenuID, Quantity, ItemTotal) "
                + "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getMenuId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getItemTotal());

            ps.executeUpdate();

            System.out.println("Order Item added successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {

        String sql = "SELECT * FROM OrderItem WHERE OrderItemID = ?";

        OrderItem orderItem = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderItemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                orderItem = new OrderItem();

                orderItem.setOrderItemId(rs.getInt("OrderItemID"));
                orderItem.setOrderId(rs.getInt("OrderID"));
                orderItem.setMenuId(rs.getInt("MenuID"));
                orderItem.setQuantity(rs.getInt("Quantity"));
                orderItem.setItemTotal(rs.getDouble("ItemTotal"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {

        String sql = "UPDATE OrderItem SET "
                + "OrderID = ?, "
                + "MenuID = ?, "
                + "Quantity = ?, "
                + "ItemTotal = ? "
                + "WHERE OrderItemID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getMenuId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getItemTotal());
            ps.setInt(5, orderItem.getOrderItemId());

            ps.executeUpdate();

            System.out.println("Order Item updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        String sql = "DELETE FROM OrderItem WHERE OrderItemID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderItemId);

            ps.executeUpdate();

            System.out.println("Order Item deleted successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        String sql = "SELECT * FROM OrderItem";

        List<OrderItem> orderItemList = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItem orderItem = new OrderItem();

                orderItem.setOrderItemId(rs.getInt("OrderItemID"));
                orderItem.setOrderId(rs.getInt("OrderID"));
                orderItem.setMenuId(rs.getInt("MenuID"));
                orderItem.setQuantity(rs.getInt("Quantity"));
                orderItem.setItemTotal(rs.getDouble("ItemTotal"));

                orderItemList.add(orderItem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItemList;
    }
}