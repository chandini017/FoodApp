package com.foodApp.dao;

import java.util.List;

import com.foodApp.model.Menu;

public interface Menudao {

    void addMenu(Menu menu);

    Menu getMenu(int menuId);

    void updateMenu(Menu menu);

    void deleteMenu(int menuId);

    List<Menu> getAllMenus();

    List<Menu> getMenusByRestaurant(int restaurantId);
}