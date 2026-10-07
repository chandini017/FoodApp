package com.edu.controllers;

import com.foodApp.model.Cart;
import com.foodApp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // 1. Check if Cart is empty
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // 2. CHECK IF USER IS LOGGED IN
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Save Checkout as return URL and redirect to Login
            session.setAttribute("redirectUrl", request.getContextPath() + "/checkout");
            response.sendRedirect("login.jsp?checkoutRequired=true");
            return;
        }

        // Forward to checkout.jsp if logged in
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}