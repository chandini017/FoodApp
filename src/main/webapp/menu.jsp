<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.foodApp.model.Menu" %>
<%@ page import="com.foodApp.model.Restaurant" %>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Food Menu - FoodApp</title>

<!-- EXTERNAL CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, Helvetica, sans-serif;
    background: #f8f8f8;
    color: #1c1c1c;
}

/* =========================
   CONTAINER
   ========================= */

.container {
    width: 86%;
    margin: 35px auto;
}

/* =========================
   RESTAURANT INFO
   ========================= */

.restaurant-info {
    text-align: center;
    margin-bottom: 25px;
}

.restaurant-info h1 {
    font-size: 32px;
    margin-bottom: 10px;
    text-align: center;
}

.restaurant-info p {
    color: #777;
    margin: 5px 0;
    text-align: center;
}

/* =========================
   BACK BUTTON
   ========================= */

.back-button {
    display: inline-block;

    margin-bottom: 25px;

    padding: 10px 18px;

    background: #e23744;
    color: white;

    text-decoration: none;

    border-radius: 6px;
}

/* =========================
   MENU GRID
   ========================= */

.menu-grid {
    display: grid;

    grid-template-columns: repeat(4, 1fr);

    gap: 24px;

    align-items: stretch;
}

/* =========================
   MENU CARD
   ========================= */

.menu-card {
    background: white;

    border-radius: 14px;

    overflow: hidden;

    border: 1px solid #eee;

    height: 100%;

    display: flex;
    flex-direction: column;

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}

.menu-card:hover {
    transform: translateY(-5px);

    box-shadow:
        0 8px 25px rgba(0,0,0,0.12);
}

/* =========================================================
   MENU IMAGE
   ========================================================= */

.menu-image-box {

    width: 100%;

    height: 220px;
    min-height: 220px;
    max-height: 220px;

    overflow: hidden;

    background: #eee;

    position: relative;

    display: flex;

    align-items: center;

    justify-content: center;
}

.menu-image {

    width: 100%;

    height: 220px;
    min-height: 220px;
    max-height: 220px;

    object-fit: cover;

    object-position: center center;

    display: block;

    margin: 0;
    padding: 0;
}

/* =========================
   AVAILABLE BADGE
   ========================= */

.available {

    position: absolute;

    top: 10px;
    right: 10px;

    background: rgba(255, 255, 255, 0.92);

    color: #267e3e;

    padding: 5px 8px;

    border: 1px solid #267e3e;

    border-radius: 5px;

    font-size: 11px;

    font-weight: bold;

    z-index: 2;
}

/* =========================
   MENU CONTENT
   ========================= */

.menu-content {

    padding: 16px;

    display: flex;

    flex-direction: column;

    flex: 1;
}

.menu-name {

    font-size: 18px;

    font-weight: bold;

    margin-bottom: 8px;
}

.menu-description {

    color: #777;

    font-size: 13px;

    line-height: 1.5;

    min-height: 40px;

    margin-bottom: 12px;
}

/* =========================
   MENU FOOTER & CART FORM
   ========================= */

.menu-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
    padding-top: 10px;
}

.price {
    font-size: 18px;
    font-weight: bold;
}

.rating {
    font-size: 14px;
    font-weight: bold;
    color: green;
}

.add-to-cart-form {
    display: flex;
    align-items: center;
    gap: 6px;
}

.qty-input {
    width: 45px;
    padding: 5px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

.add-btn {
    background: #e23744;
    color: white;
    border: none;
    padding: 7px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    font-size: 13px;
    transition: background 0.2s ease;
}

.add-btn:hover {
    background: #c82333;
}

/* =========================
   NO MENU
   ========================= */

.no-menu {

    text-align: center;

    padding: 60px;

    color: #777;

    font-size: 18px;
}

/* =========================
   RESPONSIVE
   ========================= */

@media(max-width:1100px) {

    .menu-grid {

        grid-template-columns: repeat(3, 1fr);

    }

}

@media(max-width:800px) {

    .menu-grid {

        grid-template-columns: repeat(2, 1fr);

    }

    .container {

        width: 92%;

    }

}

@media(max-width:520px) {

    .menu-grid {

        grid-template-columns: 1fr;

    }

}

</style>

</head>

<body>


<!-- =========================
     MODULAR NAVBAR
     ========================= -->
<jsp:include page="navbar.jsp" />


<!-- =========================
     MAIN CONTAINER
     ========================= -->

<div class="container">

<%

Restaurant restaurant =
        (Restaurant) request.getAttribute("restaurant");

List<Menu> menuList =
        (List<Menu>) request.getAttribute("menuList");

String currentRestaurantName = restaurant != null ? restaurant.getName() : "";

%>

<!-- =========================================================
     RESTAURANT SWITCH NOTIFICATION BANNER
     ========================================================= -->
<%
    String menuNotice = (String) session.getAttribute("menuNotice");
    if (menuNotice != null) {
        session.removeAttribute("menuNotice");
%>
    <div style="background: #fff3cd; color: #856404; padding: 14px; border-radius: 10px; margin-bottom: 20px; border: 1px solid #ffeeba; font-weight: bold; text-align: center; font-size: 15px;">
        <%= menuNotice %>
    </div>
<% } %>


<!-- =========================
     RESTAURANT INFORMATION
     ========================= -->

<%

if (restaurant != null) {

%>

<div class="restaurant-info">

    <h1>
        <%= restaurant.getName() %>
    </h1>

    <p>
        <%= restaurant.getCuisineType() %>
    </p>

    <p>
        <%= restaurant.getAddress() %>
    </p>

</div>

<%

}

%>


<a class="back-button"
   href="${pageContext.request.contextPath}/restaurants">

    ← Back to Restaurants

</a>


<!-- =========================
     MENU GRID
     ========================= -->

<div class="menu-grid">

<%

if (menuList != null && !menuList.isEmpty()) {

    for (Menu menu : menuList) {

        String itemName = menu.getItemName();

        if (itemName == null) {

            itemName = "";

        }

        itemName = itemName.trim().toLowerCase();

        String imageUrl = "";

        int restaurantId = 0;

        if (restaurant != null) {

            restaurantId =
                    restaurant.getRestaurantId();

        }


/* =========================================================
   RESTAURANT 1 - VIDYARTHI BHAVAN
   ========================================================= */

if (restaurantId == 1) {

    if (itemName.equals("masala dosa")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/MASALA_DOSA.jpg";

    }

    else if (itemName.equals("idli vada")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/c/c7/Idli_vada_%28Tirupati%2C_Andrapradesh%29.jpg";

    }

    else if (itemName.equals("kesari bath")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/d/df/Kesari_Bath_1.jpg";

    }

    else if (itemName.equals("khara bath")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Khara_bath_Maiyas_-_Karnataka_-_KedeNaga004.jpg";

    }

    else if (itemName.equals("vada")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/19/Medu_Vada.jpg";

    }

    else if (itemName.equals("poori sagu")) {

        imageUrl =
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/7/21/b47a5bab-5395-4948-a0ce-c0b8e524f738_bf7e65c8-b3b7-4d91-b1de-9af39468eead.jpg";

    }

    else if (itemName.equals("bisi bele bath") ||
             itemName.equals("bisibele bath")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/6/6a/Bisi_Bele_Bath.jpg";

    }

}


/* =========================================================
   RESTAURANT 2 - CTR
   ========================================================= */

else if (restaurantId == 2) {

    if (itemName.equals("masala dosa")) {

        imageUrl =
            "https://www.kaufmann.wtf/countries/images/recipes/india-masala-dosa.jpg";

    }

    else if (itemName.equals("vada")) {

        imageUrl =
            "https://sukhis.com/app/uploads/2022/04/image2-3-1536x1026.jpg";

    }

    else if (itemName.equals("benne masala dosa")) {

        imageUrl =
            "https://assets.zyrosite.com/cdn-cgi/image/format%3Dauto%2Cw%3D768%2Cfit%3Dcrop/AwvjkX6y4LHgvkj2/bengaluru_ctr_sandesh_poojari_mint_lounge_1_1606991399672_1606991414584_1606991609676-dJoZEv3PEoIrWDM7.jpg";

    }

    else if (itemName.equals("set dosa") ||
             itemName.equals("set dose")) {

        imageUrl =
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/1/18/289a8279-ab2e-4244-8715-78211f54418d_eaaae8ae-5192-48df-b83c-1bd5cbf7fc73.jpg";

    }

    else if (itemName.equals("rava dosa") ||
             itemName.equals("rava vada")) {

        imageUrl =
            "https://d3pc1xvrcw35tl.cloudfront.net/images/1200x900/trgrty_2024081287357.jpg";

    }

    else if (itemName.equals("kesari bath")) {

        imageUrl =
            "https://pkalawat.github.io/stealth-images/Kesari%20Bhath.webp";

    }

    else if (itemName.equals("poori sagu")) {

        imageUrl =
            "https://cdn.dotpe.in/longtail/store-items/3168452/zv4ciztH.jpeg";

    }

    else if (itemName.equals("khara bath")) {

        imageUrl =
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/7/21/35f2365f-495a-4e0f-9440-18533ecc33c8_4712a57d-4c25-4b9a-9bec-9bb98b3b71f3.png_compressed";

    }

}


/* =========================================================
   RESTAURANT 3 - MTR
   ========================================================= */

else if (restaurantId == 3) {

    if (itemName.equals("filter coffee")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/MTR_Coffee.jpg";

    }

    else if (itemName.equals("mtr special thali") ||
             itemName.equals("mtr special meal")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/MTR_restaurant_lunch.jpg";

    }

    else if (itemName.equals("masala dosa")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/MTR_Masala_Dosa.jpg";

    }

    else if (itemName.equals("rava dosa") ||
             itemName.equals("rave dosa") ||
             itemName.equals("rava idli")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/MTR_Rava_Idli.jpg";

    }

    else if (itemName.equals("bisibele bath") ||
             itemName.equals("bisi bele bath")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Bisibele_bath.jpg";

    }

    else if (itemName.equals("pongal")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Venpongal.jpg";

    }

    else if (itemName.equals("mangalore buns") ||
             itemName.equals("mangaluru buns")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mangalore_Buns.jpg";

    }

}


/* =========================================================
   RESTAURANT 4 - MEGHANA FOODS
   ========================================================= */

else if (restaurantId == 4) {

    if (itemName.equals("chicken biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Food-Chicken-Biryani.jpg";

    }

    else if (itemName.equals("mutton biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_biryani.jpg";

    }

    else if (itemName.equals("egg biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Egg_biryani.JPG";

    }

    else if (itemName.equals("chicken 65")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_65.jpg";

    }

    else if (itemName.equals("pepper chicken")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Pepper_Chicken_%28869566714%29.jpg";

    }

    else if (itemName.equals("chicken kebab") ||
             itemName.equals("chicken kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_kebab_in_Kerala.jpg";

    }

    else if (itemName.equals("chicken fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Fry.jpg";

    }

    else if (itemName.equals("mutton fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/2_Mutton_Fry.jpg";

    }

}


/* =========================================================
   RESTAURANT 5 - TRUFFLES
   ========================================================= */

else if (restaurantId == 5) {

    if (itemName.equals("classic burger")) {

        imageUrl =
            "https://lingo-data.b-cdn.net/Lingo/files/images/00353.jpg";

    }

    else if (itemName.equals("chicken burger")) {

        imageUrl =
            "https://images.deliveryhero.io/image/fd-pk/LH/ckwa-listing.jpg";

    }

    else if (itemName.equals("cheese burger") ||
             itemName.equals("cheeseburger")) {

        imageUrl =
            "https://dt4l9bx31tioh.cloudfront.net/eazymedia/group/1569/0.jpg?height=450&mode=fit&width=818";

    }

    else if (itemName.equals("peri peri burger") ||
             itemName.equals("chicken peri peri burger")) {

        imageUrl =
            "https://images.squarespace-cdn.com/content/v1/68ddc262a15bb803e01c857d/d42f4fd3-1353-43b3-8f37-968264207111/Burger_PeriPeri_Chicken.png?format=1000w";

    }

    else if (itemName.equals("bbq chicken burger") ||
             itemName.equals("barbecue chicken burger")) {

        imageUrl =
            "https://images.deliveryhero.io/image/fd-bd/products/2726553.jpg?width=%25s";

    }

    else if (itemName.equals("veggie burger") ||
             itemName.equals("vegetable burger")) {

        imageUrl =
            "https://foodhub.scene7.com/is/image/woolworthsltdprod/2010-vegie-burgers%3ASquare-1300x1300";

    }

    else if (itemName.equals("chicken steak burger") ||
             itemName.equals("bbq chicken steak burger") ||
             itemName.equals("chicken steak burger bbq")) {

        imageUrl =
            "https://media-cdn.tripadvisor.com/media/photo-s/0d/56/55/84/bbq-chicken-steak-burger.jpg";

    }

    else if (itemName.equals("french fries") ||
             itemName.equals("fries")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/French_Fries.jpg";

    }

}


/* =========================================================
   RESTAURANT 6 - RNR BIRYANI
   ========================================================= */

else if (restaurantId == 6) {

    if (itemName.equals("chicken biryani") ||
        itemName.equals("donne chicken biryani")) {

        imageUrl =
            "https://static.wixstatic.com/media/6cd5cd_af6b03993cba458094f9605dce296fe1~mv2.jpg/v1/fill/w_1000,h_1000,al_c,q_85,usm_0.66_1.00_0.01/6cd5cd_af6b03993cba458094f9605dce296fe1~mv2.jpg";

    }

    else if (itemName.equals("mutton biryani") ||
             itemName.equals("donne mutton biryani")) {

        imageUrl =
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/xjmhnmahh8ad1aaqzliu";

    }

    else if (itemName.equals("egg biryani") ||
             itemName.equals("donne egg biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Egg_biryani.JPG";

    }

    else if (itemName.equals("chicken 65") ||
             itemName.equals("chicken 65 boneless")) {

        imageUrl =
            "https://onestophalal.com/cdn/shop/articles/chicken_65_recipe_800x.jpg?v=1728185058";

    }

    else if (itemName.equals("chicken kebab") ||
             itemName.equals("chicken kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_kebab_in_Kerala.jpg";

    }

    else if (itemName.equals("mutton fry")) {

        imageUrl =
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_300,h_300,c_fit/FOOD_CATALOG/IMAGES/CMS/2024/10/23/28882106-a024-4675-b907-0b3a22fd97c1_26bd2554-9c1a-4bad-aa0a-5b12b1692ad8.jpg";

    }

    else if (itemName.equals("chicken fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Fry.jpg";

    }

    else if (itemName.equals("pepper chicken")) {

        imageUrl =
            "https://www.mannarkkad.com/images/business/products/pepper-chicken-1731059162-450295176.jpeg";

    }

}


/* =========================================================
   RESTAURANT 7 - BRAHMINS COFFEE BAR
   ========================================================= */

else if (restaurantId == 7) {

    if (itemName.equals("indu filter coffee") ||
        itemName.equals("filter coffee") ||
        itemName.equals("coffee")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Foaming_filter_coffee.jpg";

    }

    else if (itemName.equals("kesari bath")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/d/df/Kesari_Bath_1.jpg";

    }

    else if (itemName.equals("idli") ||
             itemName.equals("idli [1 piece]") ||
             itemName.equals("idli [2 pieces]")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Idli_at_MTR.jpg";

    }

    else if (itemName.equals("vada") ||
             itemName.equals("medu vada")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/19/Medu_Vada.jpg";

    }

    else if (itemName.equals("masala dosa")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/MASALA_DOSA.jpg";

    }

    else if (itemName.equals("khara bath") ||
             itemName.equals("khara bhath") ||
             itemName.equals("kharabath")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Khara_bath_Maiyas_-_Karnataka_-_KedeNaga004.jpg";

    }

    else if (itemName.equals("poori sagu")) {

        imageUrl =
            "https://cdn.dotpe.in/longtail/store-items/3168452/zv4ciztH.jpeg";

    }

}


/* =========================================================
   RESTAURANT 8 - TAAZA THINDI
   ========================================================= */

else if (restaurantId == 8) {

    if (itemName.equals("filter coffee") ||
        itemName.equals("filtered coffee") ||
        itemName.equals("coffee")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Filter-Coffee.jpg";

    }

    else if (itemName.equals("kesari bath") ||
             itemName.equals("kesari bhath") ||
             itemName.equals("kesaribath")) {

        imageUrl =
            "https://snapcalorie-webflow-website.s3.us-east-2.amazonaws.com/media/food_pics_v2/medium/kesari_bath.jpg";

    }

    else if (itemName.equals("tatta idli") ||
             itemName.equals("thatte idli") ||
             itemName.equals("thatte idli 2 [pieces]") ||
             itemName.equals("thatte idli [2 pieces]") ||
             itemName.equals("thatte idli (2 pc)")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Thatte_Idli.jpg";

    }

    else if (itemName.equals("masala dosa") ||
             itemName.equals("masala dose")) {

        imageUrl =
            "https://snapcalorie-webflow-website.s3.us-east-2.amazonaws.com/media/food_pics_v2/medium/masala_dosa_with_sambar.jpg";

    }

    else if (itemName.equals("idli") ||
             itemName.equals("idli (2 pc)") ||
             itemName.equals("idli (3 pc)") ||
             itemName.equals("idli (3 pcs)") ||
             itemName.equals("1 plate idli") ||
             itemName.equals("1 plate idli (2 pc)")) {

        imageUrl =
            "https://images.pexels.com/photos/35514447/pexels-photo-35514447.jpeg";

    }

    else if (itemName.equals("vada") ||
             itemName.equals("medu vada") ||
             itemName.equals("vada (1 pc)")) {

        imageUrl =
            "https://images.pexels.com/photos/37420984/pexels-photo-37420984.jpeg";

    }

    else if (itemName.equals("set dosa") ||
             itemName.equals("set dose")) {

        imageUrl =
            "https://ayyappadakshinam.com/images/food-menu/set-dosa.png";

    }

    else if (itemName.equals("rava idli") ||
             itemName.equals("rava idly") ||
             itemName.equals("rava idli (1 pc)")) {

        imageUrl =
            "https://im.whatshot.in/img/2018/Apr/wheat-rava-idli-1523968958.jpg";

    }

}


/* =========================================================
   RESTAURANT 9 - LEON GRILL
   ========================================================= */

else if (restaurantId == 9) {

    if (itemName.equals("chicken burger") ||
        itemName.equals("crispy chicken burger") ||
        itemName.equals("louisiana chicken burger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chargrilled_Chicken_Burger_-_Leon.jpg";

    }

    else if (itemName.equals("chicken wings") ||
             itemName.equals("hot and spicy wings") ||
             itemName.equals("hot & spicy wings")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Wings.jpg";

    }

    else if (itemName.equals("grilled chicken")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Grilled_chicken_meat.jpg";

    }

    else if (itemName.equals("chicken wrap") ||
             itemName.equals("chicken doner wrap") ||
             itemName.equals("peri peri chicken wrap")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_wrap_2.jpg";

    }

    else if (itemName.equals("peri-peri chicken") ||
             itemName.equals("peri peri chicken") ||
             itemName.equals("half peri peri chicken") ||
             itemName.equals("quarter peri peri chicken")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Peri-Peri_Chicken_dish.jpg";

    }

    else if (itemName.equals("chicken strips") ||
             itemName.equals("chicken strips.")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_strips.jpeg";

    }

    else if (itemName.equals("french fries") ||
             itemName.equals("fries") ||
             itemName.equals("regular fries")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/French_Fries.jpg";

    }

}


/* =========================================================
   RESTAURANT 10 - EMPIRE RESTAURANT
   ========================================================= */

else if (restaurantId == 10) {

    if (itemName.equals("chicken biryani") ||
        itemName.equals("chicken dum biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Food-Chicken-Biryani.jpg";

    }

    else if (itemName.equals("mutton biryani") ||
             itemName.equals("mutton dum biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_biryani.jpg";

    }

    else if (itemName.equals("chicken kebab") ||
             itemName.equals("chicken kabab") ||
             itemName.equals("boneless chicken kebab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_kebab_in_Kerala.jpg";

    }

    else if (itemName.equals("chicken 65")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_65%2C_Kerala_02.jpg";

    }

    else if (itemName.equals("butter chicken") ||
             itemName.equals("butter chicken boneless")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/ButterChicken.jpg";

    }

    else if (itemName.equals("chicken tikka") ||
             itemName.equals("chicken tikka masala")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/ChickenTikka.jpg";

    }

    else if (itemName.equals("paneer butter masala")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Paneer_Butter_Masala.jpg";

    }

    else if (itemName.equals("garlic naan") ||
             itemName.equals("garlic nan")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Garlic_naan.jpg";

    }

}


/* =========================================================
   RESTAURANT 11 - NAGARJUNA
   ========================================================= */

else if (restaurantId == 11) {

    if (itemName.equals("gongura chicken") ||
        itemName.equals("chicken gongura")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Steamed_Rice_with_Gongura_chicken.jpg";

    }

    else if (itemName.equals("gongura mutton") ||
             itemName.equals("mutton gongura")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_Curry.jpg";

    }

    else if (itemName.equals("andhra chicken biryani") ||
             itemName.equals("chicken biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/ChickenBiryani.jpg";

    }

    else if (itemName.equals("andhra meals") ||
             itemName.equals("andhra meal") ||
             itemName.equals("andhra meals - bhojanam")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Andhra_meals_in_restaurant.jpg";

    }

    else if (itemName.equals("chicken fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Fry.jpg";

    }

    else if (itemName.equals("mutton fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/2_Mutton_Fry.jpg";

    }

    else if (itemName.equals("andhra chicken curry") ||
             itemName.equals("chicken curry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Andhra_Chicken_Curry_-_WCI-Day0-Dinner.jpg";

    }

    else if (itemName.equals("prawns fry") ||
             itemName.equals("prawn fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Pepper_Prawn_Fry-Nellore-Andhra_Pradesh-DED_005.jpg";

    }

}


/* =========================================================
   RESTAURANT 12 - KABAB MAGIC
   ========================================================= */

else if (restaurantId == 12) {

    if (itemName.equals("chicken kebab") ||
        itemName.equals("chicken kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Kebab_%283623280465%29.jpg";

    }

    else if (itemName.equals("chicken tikka")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Tikka_%281%29.jpg";

    }

    else if (itemName.equals("sheek kebab") ||
             itemName.equals("seek kebab") ||
             itemName.equals("chicken seek kebab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Indian_Chicken_Seekh_Kebab.jpg";

    }

    else if (itemName.equals("chicken malai tikka") ||
             itemName.equals("malai tikka")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Malai_Tikka.JPG";

    }

    else if (itemName.equals("tandoori chicken")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Tandoori_Chicken.jpg";

    }

    else if (itemName.equals("mutton seek kebab") ||
             itemName.equals("mutton sheek kebab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_Seekh_Kebab_getting_grilled.jpg";

    }

    else if (itemName.equals("chicken reshmi kebab") ||
             itemName.equals("reshmi kebab") ||
             itemName.equals("reshmi kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Food-Chicken-Reshmi-Kebab-1.jpg";

    }

    else if (itemName.equals("paneer tikka")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Paneer_tikka.jpg";

    }

}


/* =========================================================
   RESTAURANT 13 - SHANTI SAGAR
   ========================================================= */

else if (restaurantId == 13) {

    if (itemName.equals("filter coffee") ||
        itemName.equals("coffee")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Foaming_filter_coffee.jpg";

    }

    else if (itemName.equals("idli vada") ||
             itemName.equals("idly vada")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Idli_vada_%28Tirupati%2C_Andrapradesh%29.jpg";

    }

    else if (itemName.equals("masala dosa") ||
             itemName.equals("masala dose")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/MASALA_DOSA.jpg";

    }

    else if (itemName.equals("rava dosa") ||
             itemName.equals("rava dose")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Rava_Dosa.jpg";

    }

    else if (itemName.equals("puri sagu") ||
             itemName.equals("poori sagu")) {

        imageUrl =
            "https://cdn.dotpe.in/longtail/store-items/3168452/zv4ciztH.jpeg";

    }

    else if (itemName.equals("pongal") ||
             itemName.equals("ven pongal")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Venpongal.jpg";

    }

}


/* =========================================================
   RESTAURANT 14 - UDUPI PARK
   ========================================================= */

else if (restaurantId == 14) {

    if (itemName.equals("masala dosa")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/1b/MASALA_DOSA.jpg";

    }

    else if (itemName.equals("rava dosa")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Rava_Dosa.jpg";

    }

    else if (itemName.equals("set dosa") ||
             itemName.equals("set dose")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Set_Dosa.jpg";

    }

    else if (itemName.equals("idli") ||
             itemName.equals("idli (2 pcs)") ||
             itemName.equals("2 idly")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Idli_at_MTR.jpg";

    }

    else if (itemName.equals("vada") ||
             itemName.equals("medu vada")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/1/19/Medu_Vada.jpg";

    }

    else if (itemName.equals("poori masala") ||
             itemName.equals("poori")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Fluffy_Poori.JPG";

    }

    else if (itemName.equals("bisi bele bath") ||
             itemName.equals("bisibele bath")) {

        imageUrl =
            "https://upload.wikimedia.org/wikipedia/commons/6/6a/Bisi_Bele_Bath.jpg";

    }

    else if (itemName.equals("curries") ||
             itemName.equals("curry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Indian_Curry.jpg";

    }

}


/* =========================================================
   RESTAURANT 15 - NANDHANA PALACE
   ========================================================= */

else if (restaurantId == 15) {

    if (itemName.equals("mutton curry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_Curry.jpg";

    }

    else if (itemName.equals("gongura chicken") ||
             itemName.equals("chicken gongura")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Steamed_Rice_with_Gongura_chicken.jpg";

    }

    else if (itemName.equals("andhra chicken biryani") ||
             itemName.equals("chicken biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/ChickenBiryani.jpg";

    }

    else if (itemName.equals("andhra meals") ||
             itemName.equals("andhra meal")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Andhra_meals_in_restaurant.jpg";

    }

    else if (itemName.equals("chicken fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Fry.jpg";

    }

    else if (itemName.equals("chicken 65")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_65.jpg";

    }

    else if (itemName.equals("prawns fry") ||
             itemName.equals("prawn fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Prawn_fry.jpg";

    }

}


/* =========================================================
   RESTAURANT 16 - HYDERABAD BIRYANI
   ========================================================= */

else if (restaurantId == 16) {

    if (itemName.equals("chicken biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Food-Chicken-Biryani.jpg";

    }

    else if (itemName.equals("mutton biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_biryani.jpg";

    }

    else if (itemName.equals("double ka meetha") ||
             itemName.equals("double ka meetha dessert")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Double_Ka_Meetha.JPG";

    }

    else if (itemName.equals("chicken haleem") ||
             itemName.equals("haleem")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Hyderabadi_haleem.jpg";

    }

    else if (itemName.equals("mirchi ka salan") ||
             itemName.equals("mirchi salan")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mirchi_ka_salan_and_Dahi_chutney.jpg";

    }

    else if (itemName.equals("chicken kebab") ||
             itemName.equals("chicken kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_kebab_in_Kerala.jpg";

    }

    else if (itemName.equals("mutton kebab") ||
             itemName.equals("mutton kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_kebab.JPG";

    }

    else if (itemName.equals("chicken 65")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_65%2C_Kerala_02.jpg";

    }

}


/* =========================================================
   RESTAURANT 17 - PARADISE BIRYANI
   ========================================================= */

else if (restaurantId == 17) {

    if (itemName.equals("chicken biryani") ||
        itemName.equals("chicken dum biryani") ||
        itemName.equals("royal chicken biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Food-Chicken-BiryANI.jpg";

    }

    else if (itemName.equals("mutton biryani") ||
             itemName.equals("mutton dum biryani") ||
             itemName.equals("royal mutton biryani")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_biryani.jpg";

    }

    else if (itemName.equals("double ka meetha")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Double_Ka_Meetha.JPG";

    }

    else if (itemName.equals("chicken haleem") ||
             itemName.equals("haleem")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Hyderabadi_haleem.jpg";

    }

    else if (itemName.equals("mirchi ka salan") ||
             itemName.equals("mirchi salan")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mirchi_ka_salan_and_Dahi_chutney.jpg";

    }

    else if (itemName.equals("chicken tikka") ||
             itemName.equals("chicken tikka kebab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Tikka.jpg";

    }

    else if (itemName.equals("mutton kebab") ||
             itemName.equals("mutton kabab")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mutton_kebab.JPG";

    }

    else if (itemName.equals("chicken stir fry") ||
             itemName.equals("chicken stir-fry")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_stir_fry.jpg";

    }

}


/* =========================================================
   RESTAURANT 18 - CHINITA REAL MEXICAN FOOD
   ========================================================= */

else if (restaurantId == 18) {

    if (itemName.equals("chicken tacos") ||
        itemName.equals("chicken taco") ||
        itemName.equals("grilled chicken tacos")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_tacos.jpg";

    }

    else if (itemName.equals("beef tacos") ||
             itemName.equals("beef taco") ||
             itemName.equals("grilled beef tacos")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Beef_with_Tacos.jpg";

    }

    else if (itemName.equals("veggie tacos") ||
             itemName.equals("vegetable tacos") ||
             itemName.equals("veg tacos")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Veggie_Tacos.jpg";

    }

    else if (itemName.equals("chicken quesadilla")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_quesadilla.jpg";

    }

    else if (itemName.equals("cheese quesadilla") ||
             itemName.equals("plain cheese quesadilla")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Cheese_quesadilla.jpg";

    }

    else if (itemName.equals("chicken burrito") ||
             itemName.equals("grilled chicken burrito")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Grilled_Chicken_Burrito.jpg";

    }

    else if (itemName.equals("veg burrito") ||
             itemName.equals("vegetable burrito") ||
             itemName.equals("veggie burrito")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/NoBeef_mince_in_chipotle_burrito_-_A_Tribe_Called_Veg_2024-04-06.jpg";

    }

    else if (itemName.equals("nachos") ||
             itemName.equals("veg nachos") ||
             itemName.equals("vegetable nachos")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Nachos-cheese.jpg";

    }

}


/* =========================================================
   RESTAURANT 19 - BURGER SEIGNEUR
   ========================================================= */

else if (restaurantId == 19) {

    if (itemName.equals("classic burger") ||
        itemName.equals("classic hamburger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Hamburger_sandwich.jpg";

    }

    else if (itemName.equals("cheese burger") ||
             itemName.equals("cheeseburger") ||
             itemName.equals("classic cheeseburger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Cheeseburger.jpg";

    }

    else if (itemName.equals("chicken burger") ||
             itemName.equals("classic chicken burger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/020211029_130224_chicken_burger.jpg";

    }

    else if (itemName.equals("double patty burger") ||
             itemName.equals("double burger") ||
             itemName.equals("double patty")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Double_cheeseburger.jpg";

    }

    else if (itemName.equals("bacon burger") ||
             itemName.equals("bacon cheeseburger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Bacon_cheeseburger.jpg";

    }

    else if (itemName.equals("mushroom burger") ||
             itemName.equals("mushroom cheeseburger")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Portobello_mushroom_burger.jpg";

    }

    else if (itemName.equals("peri-peri burger") ||
             itemName.equals("peri peri burger") ||
             itemName.equals("peri-peri chicken burger") ||
             itemName.equals("peri peri chicken burger")) {

        imageUrl =
            "https://www.forkintastyfood.com/wp-content/uploads/2025/02/Peri-Peri-Burger-001.jpg";

    }

    else if (itemName.equals("loaded fries") ||
             itemName.equals("loaded french fries") ||
             itemName.equals("loaded fries with cheese")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Saturday_night_takeaway_-_Loaded_Fries_%2853275065173%29.jpg";

    }

}


/* =========================================================
   RESTAURANT 20 - THE HOLE IN THE WALL CAFE
   ========================================================= */

else if (restaurantId == 20) {

    if (itemName.equals("cold coffee") ||
        itemName.equals("iced coffee")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Cold_coffees.jpg";

    }

    else if (itemName.equals("chicken sandwich") ||
             itemName.equals("grilled chicken sandwich")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken_Sandwich.jpg";

    }

    else if (itemName.equals("pancakes") ||
             itemName.equals("pancake")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Pancakes_%281%29.jpg";

    }

    else if (itemName.equals("french toast") ||
             itemName.equals("frenchtoast")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/French-toast.jpg";

    }

    else if (itemName.equals("egg benedict") ||
             itemName.equals("eggs benedict")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Eggs_Benedict_at_Delmonico%27s.jpg";

    }

    else if (itemName.equals("chicken steak sandwich") ||
             itemName.equals("chicken steak sandwich with mushrooms")) {

        imageUrl =
            "https://aklat.net/foods/248/9566-steak-chicken-sandwiches.jpg";

    }

    else if (itemName.equals("chocolate waffle") ||
             itemName.equals("chocolate waffles")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chocolate_Waffle_with_Ice_Cream.jpg";

    }

    else if (itemName.equals("pasta alfredo") ||
             itemName.equals("alfredo pasta") ||
             itemName.equals("chicken alfredo pasta")) {

        imageUrl =
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chicken-alfredo.jpg";

    }

}


/* =========================================================
   FALLBACK IMAGE
   ========================================================= */

if (imageUrl == null || imageUrl.isEmpty()) {

    imageUrl =
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg";

}

%>


<!-- =========================
     MENU CARD
     ========================= -->

<div class="menu-card">

    <div class="menu-image-box">

        <img
            src="<%= imageUrl %>"
            alt="<%= menu.getItemName() %>"
            class="menu-image"
            loading="lazy"
        >

        <% if (menu.isAvailable()) { %>

            <span class="available">
                AVAILABLE
            </span>

        <% } %>

    </div>


    <div class="menu-content">

        <div class="menu-name">
            <%= menu.getItemName() %>
        </div>


        <div class="menu-description">

            <%= menu.getDescription() == null
                ? ""
                : menu.getDescription() %>

        </div>


        <div class="menu-footer">

            <div>

                <span class="rating">
                    ★ <%= menu.getRating() %>
                </span>

                <br>

                <span class="price">
                    ₹<%= String.format("%.0f", menu.getPrice()) %>
                </span>

            </div>

            <!-- =========================
     ADD TO CART FORM (Simple Button)
     ========================= -->
<% if (menu.isAvailable()) { %>
<form action="${pageContext.request.contextPath}/cart" method="post" style="margin-left: auto;">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="itemId" value="<%= menu.getMenuId() %>">
    <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
    <input type="hidden" name="restaurantName" value="<%= currentRestaurantName %>">
    <input type="hidden" name="name" value="<%= menu.getItemName() %>">
    <input type="hidden" name="price" value="<%= menu.getPrice() %>">
    <!-- Default quantity is 1 -->
    <input type="hidden" name="quantity" value="1">

    <button type="submit" class="add-btn">Add to Cart</button>
</form>
<% } %>

        </div>

    </div>

</div>


<%

    }

}

else {

%>

<div class="no-menu">
    No menu items available.
</div>

<%

}

%>

</div>

</div>

</body>

</html>