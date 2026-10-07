package com.edu.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.foodApp.dao.Orderitemdao;
import com.foodApp.daoimplementation.Orderitemdaoimp;
import com.foodApp.model.OrderItem;
import com.foodApp.utility.DBConnection;

@WebServlet("/order-items")
public class OrderItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Orderitemdao orderItemDao;

    @Override
    public void init() {

        Connection connection = DBConnection.getConnection();

        orderItemDao = new Orderitemdaoimp(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<OrderItem> orderItemList =
                    orderItemDao.getAllOrderItems();

            request.setAttribute("orderItemList",
                                 orderItemList);

            request.getRequestDispatcher("/order-details.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load order items"
            );
        }
    }
}