package com.edu.controllers;

import com.foodApp.model.Cart;
import com.foodApp.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String restaurantName = request.getParameter("restaurantName");

            CartItem cartItem = new CartItem(itemId, restaurantId, name, quantity, price);
            
            // Check if items from a previous restaurant were replaced
            String oldRestaurantName = cart.addItem(cartItem, restaurantName != null ? restaurantName : "another restaurant");
            
            if (oldRestaurantName != null) {
                session.setAttribute("menuNotice", "⚠️ Your cart already had items from " + oldRestaurantName + ". Your cart was reset with items from " + (restaurantName != null ? restaurantName : "this restaurant") + "!");
            }

            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("menu?restaurantId=" + restaurantId);
            }

        } else if ("update".equalsIgnoreCase(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            cart.updateItem(itemId, quantity);
            response.sendRedirect("cart.jsp");

        } else if ("remove".equalsIgnoreCase(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));

            cart.removeItem(itemId);
            response.sendRedirect("cart.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}