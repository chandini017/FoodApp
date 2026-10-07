<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully - FoodApp</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f8; color: #1c1c1c; }

        .navbar {
            width: 100%; height: 75px; background: white;
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 8%; box-shadow: 0 4px 15px rgba(0,0,0,0.06);
        }
        .logo { font-size: 32px; font-weight: 800; color: #e23744; text-decoration: none; }
        .logo span { background: #e23744; color: white; padding: 2px 8px; border-radius: 8px; font-size: 18px; }

        .success-card {
            width: 90%; max-width: 600px; margin: 50px auto; background: white;
            padding: 40px 30px; border-radius: 16px; text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        }

        .check-icon {
            width: 80px; height: 80px; background: #28a745; color: white;
            border-radius: 50%; font-size: 45px; line-height: 80px;
            margin: 0 auto 20px auto; display: block;
        }

        h1 { color: #222; font-size: 28px; margin-bottom: 8px; }
        .subtitle { color: #666; font-size: 15px; margin-bottom: 25px; }

        .details-box {
            background: #f9f9f9; border: 1px solid #eee; border-radius: 12px;
            padding: 20px; text-align: left; margin-bottom: 25px;
        }

        .detail-row {
            display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 15px;
        }
        .detail-row:last-child { margin-bottom: 0; }
        .detail-label { color: #777; font-weight: 500; }
        .detail-val { font-weight: bold; color: #222; }

        .btn-home {
            display: inline-block; padding: 12px 30px; background: #e23744;
            color: white; text-decoration: none; border-radius: 8px;
            font-weight: bold; font-size: 16px; transition: background 0.2s;
        }
        .btn-home:hover { background: #c82333; }
    </style>
</head>
<body>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/restaurants" class="logo">FoodApp <span>HUB</span></a>
</div>

<div class="success-card">
    <span class="check-icon">✓</span>
    <h1>Order Placed Successfully!</h1>
    <p class="subtitle">Thank you for ordering with FoodApp. Your food is being prepared.</p>

    <div class="details-box">
        <div class="detail-row">
            <span class="detail-label">Order ID:</span>
            <span class="detail-val">#ORD-<%= request.getAttribute("orderId") %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Deliver To:</span>
            <span class="detail-val"><%= request.getAttribute("fullName") %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Phone:</span>
            <span class="detail-val"><%= request.getAttribute("phone") %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Address:</span>
            <span class="detail-val"><%= request.getAttribute("address") %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Payment Mode:</span>
            <span class="detail-val"><%= request.getAttribute("paymentMethod") %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Total Amount:</span>
            <span class="detail-val" style="color: #28a745; font-size: 17px;">₹<%= String.format("%.0f", request.getAttribute("grandTotal")) %></span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Estimated Delivery:</span>
            <span class="detail-val">⏱ 30 - 40 Mins</span>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/restaurants" class="btn-home">Order More Food</a>
</div>

</body>
</html>