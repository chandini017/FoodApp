package com.foodApp.dao;

import java.util.List;
import com.foodApp.model.User;

public interface Userdao {

    void addUser(User user);

    User getUser(int userId);

    void updateUser(User user);

    void deleteUser(int userId);

    List<User> getAllUsers();
}