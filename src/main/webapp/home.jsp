<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Home - FoodApp</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<nav class="navbar white-navbar">

    <div class="logo">
        foodapp
    </div>

    <div class="nav-links">

        <a href="${pageContext.request.contextPath}/restaurants">
            Restaurants
        </a>

        <a href="${pageContext.request.contextPath}/orders">
            Orders
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</nav>


<section class="home-banner">

    <div>

        <h1>
            Hungry?
        </h1>

        <p>
            Order delicious food from restaurants around you.
        </p>

        <a class="main-button"
           href="${pageContext.request.contextPath}/restaurants">

            Explore Food

        </a>

    </div>

</section>

</body>

</html>