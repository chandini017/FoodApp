<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.foodApp.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurants - FoodApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="hero-banner">
        <h1>Find Your Next Favorite Bite</h1>
        <p>Order delicious food from your favorite spots near you</p>
    </div>

    <div class="container">

<%
    Map<String, String> restaurantImages = new HashMap<>();

    restaurantImages.put("vidyarthi bhavan", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_400/tvur6lwwvnd2euflpswm");
    restaurantImages.put("ctr - central tiffin room", "https://static.where-e.com/India/Karnataka_State/Bengaluru_Urban_State_District/Central-Tiffin-Room_4e0b070579c132afd17d4957dc0d8c62.jpg");
    restaurantImages.put("mtr - mavalli tiffin rooms", "https://static.toiimg.com/thumb/msid-34689997%2Cwidth%3D1200%2Cheight%3D900/34689997.jpg");
    restaurantImages.put("meghana foods", "https://media.indulgexpress.com/indulgexpress%2F2024-06%2F21ae6d32-7625-4ed9-8ca1-68f41f9f5820%2FMeghana%20foods.png?auto=format%2Ccompress&w=640");
    restaurantImages.put("truffles", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/8/29/c243b30d-cd8a-41a8-aaf3-d9fa426ade03_b98ddc3a-9c5a-45fd-85d3-e8d1e026b78a.jpg");
    restaurantImages.put("rnr biryani", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2024/11/18/1c6ffe76-b171-4dd1-a122-af3576c67144_a49c036a-e0fd-4e89-bb43-e20dffd3eca3.jpg");
    restaurantImages.put("brahmins coffee bar", "https://b.zmtcdn.com/data/pictures/8/52098/6136b14814b56999d53276a39c2b01dc.png?crop=750%3A500%3B%2A%2C%2A&fit=around%7C750%3A500");
    restaurantImages.put("taaza thindi", "https://img.republicworld.com/all_images/bengaluru-woman-discovers-shockingly-low-dosa-prices-in-viral-post-1721227363262-16_9.webp");
    restaurantImages.put("leon grill", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_292%2Ch_300/TopPicks2024/188675454G.png");
    restaurantImages.put("empire restaurant", "https://d2w46d36moy248.cloudfront.net/media/shops/empire_LaUWDjF.jpg");
    restaurantImages.put("nagarjuna", "https://www.nagarjunarestaurants.com/images/thestory.jpg");
    restaurantImages.put("kabab magic", "https://b.zmtcdn.com/data/dish_photos/653/ede24b2d200efa648cac0b79d10e7653.jpg");
    restaurantImages.put("shanti sagar", "https://b.zmtcdn.com/data/pictures/2/54962/c7098815a23022b3c7caf86d183fc0b7.jpg?crop=750%3A500%3B%2A%2C%2A&fit=around%7C750%3A500");
    restaurantImages.put("udupi park", "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto/prhh5vihale8lzs7gyll");
    restaurantImages.put("nandhana palace", "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2024/11/23/37705609-331c-4e74-8bdc-e4684383bc18_image060d2779d8162431bb3d1752bcaa4c08d.JPG");
    restaurantImages.put("hyderabad biriyani", "https://b.zmtcdn.com/data/pictures/chains/1/21729991/b3ec9fddfcd4367ab1996874f639ce41.jpg");
    restaurantImages.put("paradise biryani", "https://media-assets.swiggy.com/swiggy/image/upload/f_auto%2Cq_auto%2Cfl_lossy/RX_THUMBNAIL/IMAGES/VENDOR/2026/3/26/2b01cd97-e02f-4ed0-a15c-72e2f5f6d77c_701044.JPG");
    restaurantImages.put("chinita real mexican food", "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_600%2Ch_468/v1706526119/a37b83d6d49e1c2f83cc9c93c07cafd3.jpg");
    restaurantImages.put("burger seigneur", "https://b.zmtcdn.com/data/pictures/chains/9/18992489/ab18d8a2b6631ce8b3fdb6f77ce5e07c.jpg");
    restaurantImages.put("the hole in the wall cafe", "https://i0.wp.com/motofoodie.in/wp-content/uploads/2018/02/pancakes-with-strawberries-and-cream-at-the-hole-in-the-wall-cafe-koramangala-bengaluru.jpg?resize=585%2C780&ssl=1");

    List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
%>

<%
    if (restaurantList == null || restaurantList.isEmpty()) {
%>
        <div style="text-align: center; margin-top: 60px; font-size: 20px; color: #777;">
            No restaurants available.
        </div>
<%
    } else {
%>

    <div class="restaurant-container">
<%
        for (Restaurant restaurant : restaurantList) {
            String restaurantName = restaurant.getName();
            String imageUrl = "";

            if (restaurantName != null) {
                String key = restaurantName.trim().toLowerCase();
                imageUrl = restaurantImages.get(key);
            }

            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                imageUrl = restaurant.getImagePath();
            }

            double displayRating = restaurant.getRating();
            if (restaurantName != null && restaurantName.equalsIgnoreCase("CTR - Central Tiffin Room")) displayRating = 4.3;
            if (restaurantName != null && restaurantName.equalsIgnoreCase("Empire Restaurant")) displayRating = 4.3;

            // Delivery Time Calculation / Display
            int deliveryTime = restaurant.getDeliveryTime();
            String deliveryTimeString = (deliveryTime > 0) ? (deliveryTime + " mins") : "25-35 mins";
%>

        <div class="restaurant-card">
            <div class="img-container">
                <img class="restaurant-image" src="<%= imageUrl %>" alt="<%= restaurantName %>" loading="lazy">
                <span class="rating-badge">
                    <%= String.format("%.1f", displayRating) %> <span class="star">&#9733;</span>
                </span>
            </div>

            <div class="restaurant-content">
                <div class="restaurant-name"><%= restaurantName %></div>
                <div class="restaurant-cuisine"><%= restaurant.getCuisineType() %></div>
                <div class="restaurant-address"><%= restaurant.getAddress() %></div>

                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 10px;">
                    <!-- DELIVERY TIME BADGE -->
                    <span style="font-size: 13px; font-weight: bold; color: #555;">⏱ <%= deliveryTimeString %></span>
                    <a class="menu-button" href="menu?restaurantId=<%= restaurant.getRestaurantId() %>" style="width: auto; padding: 8px 14px;">
                        View Menu →
                    </a>
                </div>
            </div>
        </div>

<%
        }
%>
    </div>

<%
    }
%>
    </div>

</body>
</html>