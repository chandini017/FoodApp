package com.foodApp.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.foodApp.dao.Restaurantdao;
import com.foodApp.model.Restaurant;

public class Restaurantdaoimp implements Restaurantdao {

    private Connection connection;

    public Restaurantdaoimp(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addRestaurant(Restaurant restaurant) {

        String sql = "INSERT INTO Restaurant "
                + "(Name, CuisineType, DeliveryTime, Address, AdminUserID, Rating, IsActive) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setInt(3, restaurant.getDeliveryTime());
            ps.setString(4, restaurant.getAddress());
            ps.setInt(5, restaurant.getAdminUserId());
            ps.setDouble(6, restaurant.getRating());
            ps.setBoolean(7, restaurant.isActive());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        String sql =
                "SELECT RestaurantID, Name, CuisineType, DeliveryTime, "
              + "Address, AdminUserID, Rating, IsActive "
              + "FROM Restaurant "
              + "WHERE RestaurantID = ?";

        Restaurant restaurant = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    restaurant = new Restaurant();

                    restaurant.setRestaurantId(
                            rs.getInt("RestaurantID"));

                    restaurant.setName(
                            rs.getString("Name"));

                    restaurant.setCuisineType(
                            rs.getString("CuisineType"));

                    restaurant.setDeliveryTime(
                            rs.getInt("DeliveryTime"));

                    restaurant.setAddress(
                            rs.getString("Address"));

                    restaurant.setAdminUserId(
                            rs.getInt("AdminUserID"));

                    restaurant.setRating(
                            rs.getDouble("Rating"));

                    restaurant.setActive(
                            rs.getBoolean("IsActive"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        String sql =
                "UPDATE Restaurant SET "
              + "Name=?, "
              + "CuisineType=?, "
              + "DeliveryTime=?, "
              + "Address=?, "
              + "AdminUserID=?, "
              + "Rating=?, "
              + "IsActive=? "
              + "WHERE RestaurantID=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setInt(3, restaurant.getDeliveryTime());
            ps.setString(4, restaurant.getAddress());
            ps.setInt(5, restaurant.getAdminUserId());
            ps.setDouble(6, restaurant.getRating());
            ps.setBoolean(7, restaurant.isActive());
            ps.setInt(8, restaurant.getRestaurantId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        String sql =
                "DELETE FROM Restaurant WHERE RestaurantID=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        /*
         * Do NOT use ImagePath here.
         * We are going to give every restaurant
         * a food image in restaurants.jsp based
         * on the restaurant name.
         */
        String sql =
                "SELECT RestaurantID, Name, CuisineType, DeliveryTime, "
              + "Address, AdminUserID, Rating, IsActive "
              + "FROM Restaurant "
              + "WHERE IsActive = 1 "
              + "ORDER BY RestaurantID";

        Map<String, Restaurant> uniqueRestaurants =
                new LinkedHashMap<>();

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(
                        rs.getInt("RestaurantID"));

                restaurant.setName(
                        rs.getString("Name"));

                restaurant.setCuisineType(
                        rs.getString("CuisineType"));

                restaurant.setDeliveryTime(
                        rs.getInt("DeliveryTime"));

                restaurant.setAddress(
                        rs.getString("Address"));

                restaurant.setAdminUserId(
                        rs.getInt("AdminUserID"));

                restaurant.setRating(
                        rs.getDouble("Rating"));

                restaurant.setActive(
                        rs.getBoolean("IsActive"));

                String key = restaurant.getName();

                if (key == null) {
                    key = "";
                }

                key = key.trim().toLowerCase();

                if (!uniqueRestaurants.containsKey(key)) {
                    uniqueRestaurants.put(key, restaurant);
                }
            }

            restaurantList =
                    new ArrayList<>(uniqueRestaurants.values());

            System.out.println(
                    "Restaurants loaded: "
                    + restaurantList.size());

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading restaurants:");

            e.printStackTrace();
        }

        return restaurantList;
    }
}