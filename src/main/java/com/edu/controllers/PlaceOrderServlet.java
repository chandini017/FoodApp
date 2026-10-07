package com.edu.controllers;

import com.foodApp.model.Cart;
import com.foodApp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect("restaurants");
            return;
        }

        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("redirectUrl", request.getContextPath() + "/checkout");
            response.sendRedirect("login.jsp?checkoutRequired=true");
            return;
        }

        // Retrieve form fields
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        double subtotal = cart.getTotalPrice();
        double deliveryFee = 40.0;
        double grandTotal = subtotal + deliveryFee;

        // Generate Order ID
        int orderId = 100000 + new Random().nextInt(900000);

        request.setAttribute("orderId", orderId);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("grandTotal", grandTotal);

        // Clear cart after placing order
        cart.clear();

        request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
    }
}