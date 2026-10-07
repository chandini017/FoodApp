package com.edu.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.foodApp.dao.Orderdao;
import com.foodApp.daoimplementation.Orderdaoimpl;
import com.foodApp.model.Order;
import com.foodApp.utility.DBConnection;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Orderdao orderDao;

    @Override
    public void init() {

        Connection connection = DBConnection.getConnection();

        orderDao = new Orderdaoimpl(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Order> orderList =
                    orderDao.getAllOrders();

            request.setAttribute("orderList",
                                 orderList);

            request.getRequestDispatcher("/orders.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load orders"
            );
        }
    }
}