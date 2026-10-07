package com.foodApp.dao;

import java.util.List;
import com.foodApp.model.Restaurant;

public interface Restaurantdao {

    void addRestaurant(Restaurant restaurant);

    Restaurant getRestaurant(int restaurantId);

    void updateRestaurant(Restaurant restaurant);

    void deleteRestaurant(int restaurantId);

    List<Restaurant> getAllRestaurants();
}