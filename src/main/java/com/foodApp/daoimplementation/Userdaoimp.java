package com.foodApp.daoimplementation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.dao.Userdao;
import com.foodApp.model.User;

public class Userdaoimp implements Userdao {

    private Connection connection;

    // DEFAULT NO-ARG CONSTRUCTOR (Fixes the compilation error!)
    public Userdaoimp() {
        try {
            // Load MySQL Driver and connect to DB
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/foodapp", "root", "root"); // Replace with your DB URL & Password
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // PARAMETERIZED CONSTRUCTOR
    public Userdaoimp(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addUser(User user) {

        String sql = "INSERT INTO User "
                + "(Username, Password, Email, Address, Role, CreateDate, LastLoginDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole() != null ? user.getRole() : "Customer");

            if (user.getCreateDate() != null)
                ps.setTimestamp(6,
                        new java.sql.Timestamp(user.getCreateDate().getTime()));
            else
                ps.setTimestamp(6, new java.sql.Timestamp(System.currentTimeMillis()));

            if (user.getLastLoginDate() != null)
                ps.setTimestamp(7,
                        new java.sql.Timestamp(user.getLastLoginDate().getTime()));
            else
                ps.setTimestamp(7, null);

            ps.executeUpdate();

            System.out.println("User added successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUser(int userId) {

        String sql = "SELECT * FROM User WHERE UserID = ?";

        User user = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setCreateDate(rs.getTimestamp("CreateDate"));
                user.setLastLoginDate(rs.getTimestamp("LastLoginDate"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public void updateUser(User user) {

        String sql = "UPDATE User SET "
                + "Username = ?, "
                + "Password = ?, "
                + "Email = ?, "
                + "Address = ?, "
                + "Role = ?, "
                + "LastLoginDate = ? "
                + "WHERE UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole());

            if (user.getLastLoginDate() != null)
                ps.setTimestamp(6,
                        new java.sql.Timestamp(user.getLastLoginDate().getTime()));
            else
                ps.setTimestamp(6, null);

            ps.setInt(7, user.getUserId());

            ps.executeUpdate();

            System.out.println("User updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {

        String sql = "DELETE FROM User WHERE UserID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, userId);

            ps.executeUpdate();

            System.out.println("User deleted successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> getAllUsers() {

        String sql = "SELECT * FROM User";

        List<User> userList = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setCreateDate(rs.getTimestamp("CreateDate"));
                user.setLastLoginDate(rs.getTimestamp("LastLoginDate"));

                userList.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
}