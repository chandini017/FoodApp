package com.edu.controllers;

import com.foodApp.dao.Userdao;
import com.foodApp.daoimplementation.Userdaoimp;
import com.foodApp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.contains("login")) {
            request.getSession().setAttribute("redirectUrl", referer);
        }
        
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("username");
        String password = request.getParameter("password");

        // Uses default constructor now without error!
        Userdao userDAO = new Userdaoimp();
        User validUser = null;

        if (userDAO.getAllUsers() != null) {
            for (User u : userDAO.getAllUsers()) {
                if (u.getEmail() != null && u.getEmail().equalsIgnoreCase(email) 
                        && u.getPassword() != null && u.getPassword().equals(password)) {
                    validUser = u;
                    break;
                }
            }
        }

        if (validUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", validUser);

            String redirectUrl = (String) session.getAttribute("redirectUrl");
            session.removeAttribute("redirectUrl");

            if (redirectUrl != null && !redirectUrl.isEmpty() && !redirectUrl.contains("login")) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect("restaurants");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid Username/Email or Password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}