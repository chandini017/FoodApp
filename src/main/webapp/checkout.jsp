<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodApp.model.Cart, com.foodApp.model.CartItem, com.foodApp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FoodApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="checkout-container" style="width: 90%; max-width: 750px; margin: 35px auto;">

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }
        
        double subtotal = cart.getTotalPrice();
        double deliveryFee = 40.00;
        double grandTotal = subtotal + deliveryFee;

        String savedName = user != null && user.getUsername() != null ? user.getUsername() : "";
        String savedAddress = user != null && user.getAddress() != null ? user.getAddress() : "";
    %>

    <form action="${pageContext.request.contextPath}/placeOrder" method="post">

        <!-- SECTION 1: DELIVERY ADDRESS -->
        <div class="card" style="background: white; padding: 25px; border-radius: 14px; margin-bottom: 25px;">
            <h2>1. Delivery Location & Address</h2>
            
            <div class="form-group" style="margin-bottom: 15px;">
                <label>Full Name</label>
                <input type="text" name="fullName" value="<%= savedName %>" placeholder="Enter full name" required style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc;">
            </div>

            <div class="form-group" style="margin-bottom: 15px;">
                <label>Phone Number</label>
                <input type="tel" name="phone" placeholder="Enter 10-digit mobile number" pattern="[0-9]{10}" required style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc;">
            </div>

            <div class="form-group">
                <label>Delivery Address</label>
                <textarea name="address" rows="3" placeholder="Type house number, street, pincode" required style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc;"><%= savedAddress %></textarea>
            </div>
        </div>

        <!-- SECTION 2: PAYMENT METHOD -->
        <div class="card" style="background: white; padding: 25px; border-radius: 14px; margin-bottom: 25px;">
            <h2>2. Payment Option</h2>
            
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label><input type="radio" name="paymentMethod" value="COD" checked> 💵 Cash on Delivery</label>
                <label><input type="radio" name="paymentMethod" value="UPI"> 📱 UPI (Google Pay / PhonePe)</label>
                <label><input type="radio" name="paymentMethod" value="CARD"> 💳 Credit / Debit Card</label>
            </div>
        </div>

        <!-- SECTION 3: ORDER SUMMARY -->
        <div class="card" style="background: white; padding: 25px; border-radius: 14px;">
            <h2>3. Order Summary & Bill</h2>
            
            <% for (CartItem item : cart.getItems().values()) { %>
                <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                    <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
                    <span>₹<%= String.format("%.0f", item.getTotalAmount()) %></span>
                </div>
            <% } %>

            <hr style="margin: 15px 0;">

            <div style="display: flex; justify-content: space-between; font-weight: bold; font-size: 18px;">
                <span>Total Amount to Pay</span>
                <span>₹<%= String.format("%.0f", grandTotal) %></span>
            </div>

            <button type="submit" class="btn-submit" style="width: 100%; padding: 14px; background: #e23744; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: bold; margin-top: 20px; cursor: pointer;">
                Place Order (₹<%= String.format("%.0f", grandTotal) %>)
            </button>
        </div>

    </form>

</div>

</body>
</html>