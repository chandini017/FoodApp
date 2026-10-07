package com.foodApp.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.dao.Orderdao;
import com.foodApp.model.Order;

public class Orderdaoimpl implements Orderdao {

    private Connection connection;

    public Orderdaoimpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addOrder(Order order) {

        String sql = "INSERT INTO OrderTable "
                + "(UserID, RestaurantID, OrderDate, TotalAmount, Status, PaymentMethod) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());

            if (order.getOrderDate() != null)
                ps.setTimestamp(3,
                        new java.sql.Timestamp(order.getOrderDate().getTime()));
            else
                ps.setTimestamp(3,
                        new java.sql.Timestamp(System.currentTimeMillis()));

            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMethod());

            ps.executeUpdate();

            System.out.println("Order added successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order getOrder(int orderId) {

        String sql = "SELECT * FROM OrderTable WHERE OrderID = ?";

        Order order = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                order = new Order();

                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setRestaurantId(rs.getInt("RestaurantID"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public void updateOrder(Order order) {

        String sql = "UPDATE OrderTable SET "
                + "UserID = ?, "
                + "RestaurantID = ?, "
                + "OrderDate = ?, "
                + "TotalAmount = ?, "
                + "Status = ?, "
                + "PaymentMethod = ? "
                + "WHERE OrderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());

            if (order.getOrderDate() != null)
                ps.setTimestamp(3,
                        new java.sql.Timestamp(order.getOrderDate().getTime()));
            else
                ps.setTimestamp(3, null);

            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMethod());
            ps.setInt(7, order.getOrderId());

            ps.executeUpdate();

            System.out.println("Order updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        String sql = "DELETE FROM OrderTable WHERE OrderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, orderId);

            ps.executeUpdate();

            System.out.println("Order deleted successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {

        String sql = "SELECT * FROM OrderTable";

        List<Order> orderList = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setRestaurantId(rs.getInt("RestaurantID"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }
}