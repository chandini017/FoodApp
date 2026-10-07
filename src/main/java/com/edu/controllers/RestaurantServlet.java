package com.edu.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.foodApp.dao.Restaurantdao;
import com.foodApp.daoimplementation.Restaurantdaoimp;
import com.foodApp.model.Restaurant;
import com.foodApp.utility.DBConnection;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Restaurantdao restaurantDao;

    @Override
    public void init() {

        Connection connection = DBConnection.getConnection();

        restaurantDao = new Restaurantdaoimp(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Restaurant> restaurantList =
                    restaurantDao.getAllRestaurants();

            request.setAttribute("restaurantList", restaurantList);

            request.getRequestDispatcher("/restaurants.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load restaurants"
            );
        }
    }
}