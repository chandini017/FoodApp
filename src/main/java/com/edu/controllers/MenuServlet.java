package com.edu.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.foodApp.dao.Menudao;
import com.foodApp.dao.Restaurantdao;
import com.foodApp.daoimplementation.Menudaoimp;
import com.foodApp.daoimplementation.Restaurantdaoimp;
import com.foodApp.model.Menu;
import com.foodApp.model.Restaurant;
import com.foodApp.utility.DBConnection;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Menudao menuDao;
    private Restaurantdao restaurantDao;

    @Override
    public void init() {

        Connection connection =
                DBConnection.getConnection();

        menuDao =
                new Menudaoimp(connection);

        restaurantDao =
                new Restaurantdaoimp(connection);
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String restaurantIdParameter =
                request.getParameter("restaurantId");

        if (restaurantIdParameter == null ||
            restaurantIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Restaurant ID is required"
            );

            return;
        }

        try {

            int restaurantId =
                    Integer.parseInt(
                            restaurantIdParameter
                    );

            /*
             * Get only menu items belonging
             * to the selected restaurant.
             */
            List<Menu> menuList =
                    menuDao.getMenusByRestaurant(
                            restaurantId
                    );

            /*
             * Get selected restaurant details.
             */
            Restaurant restaurant =
                    restaurantDao.getRestaurant(
                            restaurantId
                    );

            /*
             * Send menu list to menu.jsp.
             */
            request.setAttribute(
                    "menuList",
                    menuList
            );

            /*
             * Send restaurant details to menu.jsp.
             */
            request.setAttribute(
                    "restaurant",
                    restaurant
            );

            /*
             * Send restaurant ID also.
             */
            request.setAttribute(
                    "restaurantId",
                    restaurantId
            );

            /*
             * Open menu page.
             */
            request.getRequestDispatcher(
                    "/menu.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Restaurant ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load menu"
            );
        }
    }
}