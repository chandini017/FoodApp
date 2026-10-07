package com.edu.controllers;

import com.foodApp.dao.Userdao;
import com.foodApp.daoimplementation.Userdaoimp;
import com.foodApp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setAddress(address);

        // Uses default constructor now without error!
        Userdao userDAO = new Userdaoimp();
        userDAO.addUser(newUser);

        HttpSession session = request.getSession();
        session.setAttribute("user", newUser);

        String redirectUrl = (String) session.getAttribute("redirectUrl");
        session.removeAttribute("redirectUrl");

        if (redirectUrl != null && !redirectUrl.isEmpty() && !redirectUrl.contains("login")) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect("restaurants");
        }
    }
}