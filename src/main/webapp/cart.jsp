<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodApp.model.Cart, com.foodApp.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart - FoodApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="navbar.jsp" />

<div style="width: 80%; margin: 30px auto;">

    <!-- DISPLAY REPLACEMENT NOTIFICATION -->
    <% 
        String cartNotice = (String) session.getAttribute("cartNotice");
        if (cartNotice != null) {
            session.removeAttribute("cartNotice");
    %>
        <div style="background: #fff3cd; color: #856404; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ffeeba; font-weight: bold; text-align: center;">
            <%= cartNotice %>
        </div>
    <% } %>

    <h2 style="text-align: center; margin-bottom: 25px;">Your Shopping Cart</h2>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
    %>
        <div style="text-align: center; padding: 50px; background: white; border-radius: 12px;">
            <h3>Your cart is empty!</h3>
            <p style="color: #666; margin: 10px 0;">Looks like you haven't added any food items yet.</p>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn-login" style="display: inline-block; margin-top: 10px;">Explore Restaurants</a>
        </div>
    <%
        } else {
    %>
        <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
            <thead>
                <tr style="background: #f8f9fa;">
                    <th style="padding: 14px;">Item Name</th>
                    <th style="padding: 14px;">Price</th>
                    <th style="padding: 14px;">Quantity</th>
                    <th style="padding: 14px;">Subtotal</th>
                    <th style="padding: 14px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (CartItem item : cart.getItems().values()) {
                %>
                <tr style="border-bottom: 1px solid #eee; text-align: center;">
                    <td style="padding: 14px;"><strong><%= item.getName() %></strong></td>
                    <td style="padding: 14px;">₹<%= String.format("%.0f", item.getPrice()) %></td>
                    <td style="padding: 14px;">
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                            <button type="submit" style="padding: 2px 8px; font-weight: bold;">-</button>
                        </form>
                        <span style="margin: 0 8px; font-weight: bold;"><%= item.getQuantity() %></span>
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                            <button type="submit" style="padding: 2px 8px; font-weight: bold;">+</button>
                        </form>
                    </td>
                    <td style="padding: 14px;">₹<%= String.format("%.0f", item.getTotalAmount()) %></td>
                    <td style="padding: 14px;">
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <button type="submit" style="background: #e23744; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer;">Remove</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 25px; background: white; padding: 20px; border-radius: 12px;">
            <div style="font-size: 22px; font-weight: bold;">
                Grand Total: ₹<%= String.format("%.0f", cart.getTotalPrice()) %>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/restaurants" style="padding: 10px 18px; background: #6c757d; color: white; text-decoration: none; border-radius: 6px; font-weight: bold; margin-right: 10px;">← Add More Items</a>
                <a href="${pageContext.request.contextPath}/checkout" style="padding: 10px 18px; background: #28a745; color: white; text-decoration: none; border-radius: 6px; font-weight: bold;">Proceed to Checkout →</a>
            </div>
        </div>
    <%
        }
    %>
</div>

</body>
</html>