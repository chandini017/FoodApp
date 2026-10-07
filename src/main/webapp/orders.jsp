<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.foodApp.model.Order" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>My Orders - FoodApp</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<nav class="navbar white-navbar">

    <div class="logo">
        foodapp
    </div>

    <div class="nav-links">

        <a href="${pageContext.request.contextPath}/home">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/restaurants">
            Restaurants
        </a>

    </div>

</nav>


<div class="page-container">

    <h1>My Orders</h1>

    <%
        List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");

        if (orderList != null) {

            for (Order order : orderList) {
    %>

        <div class="order-card">

            <div>

                <h2>
                    Order #<%= order.getOrderId() %>
                </h2>

                <p>
                    Date:
                    <%= order.getOrderDate() %>
                </p>

                <p>
                    Payment:
                    <%= order.getPaymentMethod() %>
                </p>

            </div>


            <div>

                <h3>
                    ₹<%= order.getTotalAmount() %>
                </h3>

                <span class="status">
                    <%= order.getStatus() %>
                </span>

            </div>

        </div>

    <%
            }
        }
    %>

</div>

</body>

</html>