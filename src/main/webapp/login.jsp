<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login & Register - FoodApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .auth-container {
            width: 100%; max-width: 440px; margin: 50px auto; background: white;
            padding: 35px; border-radius: 16px; box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            border: 1px solid #eaeaea;
        }

        .auth-tabs {
            display: flex; border-bottom: 2px solid #eee; margin-bottom: 25px;
        }
        .tab-btn {
            flex: 1; padding: 12px; border: none; background: none; font-size: 16px;
            font-weight: bold; color: #777; cursor: pointer; transition: color 0.2s;
        }
        .tab-btn.active {
            color: #e23744; border-bottom: 3px solid #e23744;
        }

        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 6px; font-size: 14px; color: #444; }
        .form-group input {
            width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 8px; font-size: 14px;
        }
        .form-group input:focus { border-color: #e23744; outline: none; }

        .btn-submit {
            width: 100%; padding: 14px; background: #e23744; color: white; border: none;
            border-radius: 8px; font-size: 16px; font-weight: bold; cursor: pointer;
            margin-top: 10px; transition: background 0.2s;
        }
        .btn-submit:hover { background: #c82333; }

        .notice-msg { background: #fff3cd; color: #856404; padding: 12px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; text-align: center; border: 1px solid #ffeeba; font-weight: 500; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 6px; font-size: 14px; margin-bottom: 15px; text-align: center; }
        .success-msg { background: #d4edda; color: #155724; padding: 10px; border-radius: 6px; font-size: 14px; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="navbar.jsp" />

<div class="auth-container">

    <!-- CHECKOUT REQUIRED NOTICE -->
    <% if (request.getParameter("checkoutRequired") != null) { %>
        <div class="notice-msg">
            🔒 <strong>Please Log In or Create an Account</strong> to place your order!
        </div>
    <% } %>

    <!-- TABS SWITCH -->
    <div class="auth-tabs">
        <button class="tab-btn active" id="loginTab" onclick="switchTab('login')">Log In (Existing User)</button>
        <button class="tab-btn" id="registerTab" onclick="switchTab('register')">Create Account (New User)</button>
    </div>

    <!-- MESSAGES -->
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-msg"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <!-- LOGIN FORM -->
    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="loginUsername">Email Address / Username</label>
            <input type="text" id="loginUsername" name="username" placeholder="Enter email or username" required>
        </div>

        <div class="form-group">
            <label for="loginPassword">Password</label>
            <input type="password" id="loginPassword" name="password" placeholder="Enter password" required>
        </div>

        <button type="submit" class="btn-submit">Log In & Continue to Checkout</button>
    </form>

    <!-- REGISTER FORM -->
    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" style="display: none;">
        <div class="form-group">
            <label for="regUsername">Username</label>
            <input type="text" id="regUsername" name="username" placeholder="Choose a username" required>
        </div>

        <div class="form-group">
            <label for="regEmail">Email Address</label>
            <input type="email" id="regEmail" name="email" placeholder="Enter email address" required>
        </div>

        <div class="form-group">
            <label for="regPassword">Password</label>
            <input type="password" id="regPassword" name="password" placeholder="Create password" required>
        </div>

        <div class="form-group">
            <label for="regAddress">Delivery Address</label>
            <input type="text" id="regAddress" name="address" placeholder="Enter delivery address" required>
        </div>

        <button type="submit" class="btn-submit">Create Account & Continue to Checkout</button>
    </form>

</div>

<script>
function switchTab(tab) {
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");
    const loginTab = document.getElementById("loginTab");
    const registerTab = document.getElementById("registerTab");

    if (tab === 'login') {
        loginForm.style.display = "block";
        registerForm.style.display = "none";
        loginTab.classList.add("active");
        registerTab.classList.remove("active");
    } else {
        loginForm.style.display = "none";
        registerForm.style.display = "block";
        registerTab.classList.add("active");
        loginTab.classList.remove("active");
    }
}
</script>

</body>
</html>