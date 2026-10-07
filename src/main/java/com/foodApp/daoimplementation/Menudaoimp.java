package com.foodApp.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;

import com.foodApp.dao.Menudao;
import com.foodApp.model.Menu;

public class Menudaoimp implements Menudao {

    private Connection connection;

    public Menudaoimp(Connection connection) {
        this.connection = connection;
    }

    // ==========================================
    // ADD MENU
    // ==========================================

    @Override
    public void addMenu(Menu menu) {

        String sql =
                "INSERT INTO Menu "
                + "(RestaurantID, ItemName, Description, Price, Rating, "
                + "IsAvailable, Category, ImagePath) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, menu.getRestaurantId());

            ps.setString(2, menu.getItemName());

            ps.setString(3, menu.getDescription());

            ps.setDouble(4, menu.getPrice());

            ps.setDouble(5, menu.getRating());

            ps.setBoolean(6, menu.isAvailable());

            ps.setString(7, menu.getCategory());

            ps.setString(8, menu.getImagePath());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }


    // ==========================================
    // GET MENU BY ID
    // ==========================================

    @Override
    public Menu getMenu(int menuId) {

        String sql =
                "SELECT * FROM Menu "
                + "WHERE MenuID = ?";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, menuId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                Menu menu = new Menu();

                menu.setMenuId(
                        rs.getInt("MenuID")
                );

                menu.setRestaurantId(
                        rs.getInt("RestaurantID")
                );

                menu.setItemName(
                        rs.getString("ItemName")
                );

                menu.setDescription(
                        rs.getString("Description")
                );

                menu.setPrice(
                        rs.getDouble("Price")
                );

                menu.setRating(
                        rs.getDouble("Rating")
                );

                menu.setAvailable(
                        rs.getBoolean("IsAvailable")
                );

                menu.setCategory(
                        rs.getString("Category")
                );

                menu.setImagePath(
                        rs.getString("ImagePath")
                );

                return menu;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // ==========================================
    // UPDATE MENU
    // ==========================================

    @Override
    public void updateMenu(Menu menu) {

        String sql =
                "UPDATE Menu SET "
                + "RestaurantID=?, "
                + "ItemName=?, "
                + "Description=?, "
                + "Price=?, "
                + "Rating=?, "
                + "IsAvailable=?, "
                + "Category=?, "
                + "ImagePath=? "
                + "WHERE MenuID=?";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(
                    1,
                    menu.getRestaurantId()
            );

            ps.setString(
                    2,
                    menu.getItemName()
            );

            ps.setString(
                    3,
                    menu.getDescription()
            );

            ps.setDouble(
                    4,
                    menu.getPrice()
            );

            ps.setDouble(
                    5,
                    menu.getRating()
            );

            ps.setBoolean(
                    6,
                    menu.isAvailable()
            );

            ps.setString(
                    7,
                    menu.getCategory()
            );

            ps.setString(
                    8,
                    menu.getImagePath()
            );

            ps.setInt(
                    9,
                    menu.getMenuId()
            );

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }


    // ==========================================
    // DELETE MENU
    // ==========================================

    @Override
    public void deleteMenu(int menuId) {

        String sql =
                "DELETE FROM Menu "
                + "WHERE MenuID=?";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, menuId);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }


    // ==========================================
    // GET ALL MENUS
    // ==========================================

    @Override
    public List<Menu> getAllMenus() {

        List<Menu> menuList =
                new ArrayList<>();

        String sql =
                "SELECT * FROM Menu "
                + "ORDER BY MenuID";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql);

             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                Menu menu = new Menu();

                menu.setMenuId(
                        rs.getInt("MenuID")
                );

                menu.setRestaurantId(
                        rs.getInt("RestaurantID")
                );

                menu.setItemName(
                        rs.getString("ItemName")
                );

                menu.setDescription(
                        rs.getString("Description")
                );

                menu.setPrice(
                        rs.getDouble("Price")
                );

                menu.setRating(
                        rs.getDouble("Rating")
                );

                menu.setAvailable(
                        rs.getBoolean("IsAvailable")
                );

                menu.setCategory(
                        rs.getString("Category")
                );

                menu.setImagePath(
                        rs.getString("ImagePath")
                );

                menuList.add(menu);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return menuList;
    }


    // ==========================================
    // GET MENUS BY RESTAURANT
    // ==========================================

    @Override
    public List<Menu> getMenusByRestaurant(
            int restaurantId) {

        Map<String, Menu> uniqueMenus =
                new LinkedHashMap<>();

        String sql =
                "SELECT * FROM Menu "
                + "WHERE RestaurantID=? "
                + "AND IsAvailable=TRUE "
                + "ORDER BY Category, MenuID";

        try (PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Menu menu = new Menu();

                menu.setMenuId(
                        rs.getInt("MenuID")
                );

                menu.setRestaurantId(
                        rs.getInt("RestaurantID")
                );

                menu.setItemName(
                        rs.getString("ItemName")
                );

                menu.setDescription(
                        rs.getString("Description")
                );

                menu.setPrice(
                        rs.getDouble("Price")
                );

                menu.setRating(
                        rs.getDouble("Rating")
                );

                menu.setAvailable(
                        rs.getBoolean("IsAvailable")
                );

                menu.setCategory(
                        rs.getString("Category")
                );

                menu.setImagePath(
                        rs.getString("ImagePath")
                );

                String key = menu.getItemName() == null
                        ? ""
                        : menu.getItemName()
                              .trim()
                              .toLowerCase();

                if (!uniqueMenus.containsKey(key)) {

                    uniqueMenus.put(
                            key,
                            menu
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new ArrayList<>(
                uniqueMenus.values()
        );
    }
}