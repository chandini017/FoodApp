<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodApp.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/restaurants" class="logo">
        FoodApp <span>HUB</span>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/restaurants">Restaurants</a>
        <a href="${pageContext.request.contextPath}/cart">Cart 🛒</a>

        <% if (user == null) { %>
            <!-- Show Log in button if NOT logged in -->
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-login">Log in</a>
        <% } else { %>
            <!-- Show User Profile + Logout dropdown when LOGGED in -->
            <div style="position: relative; display: inline-block;">
                <a href="#" class="user-profile" onclick="toggleUserDropdown(event)">
                    👤 <%= user.getUsername() %> ▼
                </a>
                <div id="userDropdown" style="display: none; position: absolute; right: 0; top: 40px; background: white; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 150px; z-index: 100;">
                    <a href="${pageContext.request.contextPath}/logout" style="display: block; padding: 10px 15px; color: #e23744; text-decoration: none; font-weight: bold;">
                        🚪 Log out
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</div>

<script>
function toggleUserDropdown(event) {
    event.preventDefault();
    const dropdown = document.getElementById("userDropdown");
    if (dropdown.style.display === "none" || dropdown.style.display === "") {
        dropdown.style.display = "block";
    } else {
        dropdown.style.display = "none";
    }
}
</script>