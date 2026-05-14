<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.Order" %>

<html>
<head>
<title>Order Status | BlushBerry</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

/* 🌈 THEME */
:root {
    --primary: #4f46e5;
    --secondary: #06b6d4;
    --dark: #111827;
    --text: #374151;
}

/* BODY */
body {
    background: linear-gradient(135deg, #f9fafb, #eef2ff);
    font-family: 'Poppins', sans-serif;
    color: var(--text);
    overflow-x: hidden;
}

/* CONTENT */
.content {
    display: flex;
    justify-content: center;
    padding: 15px;
}

/* BOX */
.box {
    background: rgba(255,255,255,0.95);
    backdrop-filter: blur(10px);
    padding: 20px;
    border-radius: 20px;
    width: 100%;
    max-width: 900px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    border-top: 4px solid var(--primary);
}

/* COD BOX */
.cod-box {
    margin-bottom: 20px;
    padding: 12px;
    border-radius: 12px;
    background: #f1f5f9;
    text-align: center;
    font-weight: 500;
    font-size: 14px;
}

/* ICON */
.icon-circle {
    width: 75px;
    height: 75px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: auto;
    font-size: 30px;
    color: white;
}

.success-bg {
    background: linear-gradient(135deg, #22c55e, #16a34a);
}

.fail-bg {
    background: linear-gradient(135deg, #ef4444, #dc2626);
}

/* TITLE */
h2 {
    text-align: center;
    margin-top: 15px;
    font-weight: 700;
    font-size: 22px;
}

/* TABLE RESPONSIVE FIX */
.table-responsive {
    margin-top: 20px;
}

/* TABLE */
.table {
    border-radius: 12px;
    overflow: hidden;
    min-width: 600px;
}

.table th {
    background: var(--primary);
    color: white;
}

/* PROGRESS */
.progress {
    height: 8px;
    border-radius: 10px;
    margin-bottom: 5px;
}

/* MOBILE */
@media (max-width: 768px) {

    h2 {
        font-size: 18px;
    }

    .box {
        padding: 15px;
    }

    .cod-box {
        font-size: 12px;
    }

    .table {
        font-size: 13px;
    }
}

</style>

</head>

<body>

<!-- NAVBAR -->
<jsp:include page="navbar.jsp" />

<%
Boolean orderPlaced = (Boolean) request.getAttribute("orderPlaced");
List<Order> orderList = (List<Order>) request.getAttribute("orderList");
%>

<div class="content">
<div class="box">

<!-- COD INFO -->
<div class="cod-box">
    <i class="fa-solid fa-indian-rupee-sign"></i> Cash on Delivery Available |
    <i class="fa-solid fa-truck"></i> Safe & Fast Delivery
</div>

<!-- STATUS -->
<% if(orderPlaced != null && orderPlaced) { %>

    <div class="icon-circle success-bg">
        <i class="fa-solid fa-check"></i>
    </div>
    <h2>Order Placed Successfully</h2>

<% } else if(orderPlaced != null && !orderPlaced) { %>

    <div class="icon-circle fail-bg">
        <i class="fa-solid fa-xmark"></i>
    </div>
    <h2>No Items in Cart</h2>

<% } %>

<h4 class="mt-4 text-center">Your Orders</h4>

<%
if(orderList != null && !orderList.isEmpty()){
%>

<!-- RESPONSIVE TABLE -->
<div class="table-responsive">

<table class="table table-bordered table-striped text-center align-middle">

<tr>
    <th>Order ID</th>
    <th>Amount</th>
    <th>Date</th>
    <th>Status</th>
</tr>

<%
for(Order o : orderList){

    String status = o.getStatus();
    int progress = 25;

    if("confirmed".equalsIgnoreCase(status)) progress = 50;
    else if("packed".equalsIgnoreCase(status)) progress = 75;
    else if("delivered".equalsIgnoreCase(status)) progress = 100;
%>

<tr>
    <td><%= o.getId() %></td>
    <td>₹ <%= o.getTotalAmount() %></td>
    <td><%= o.getOrderDate() %></td>

    <td>

        <div class="progress">
            <div class="progress-bar bg-success" style="width:<%=progress%>%"></div>
        </div>

        <%
        if("pending".equalsIgnoreCase(status)){
        %>
            <span class="badge bg-warning text-dark">Pending</span>

        <%
        } else if("confirmed".equalsIgnoreCase(status)){
        %>
            <span class="badge bg-primary">Confirmed</span>

        <%
        } else if("packed".equalsIgnoreCase(status)){
        %>
            <span class="badge bg-info text-dark">Packed</span>

        <%
        } else if("delivered".equalsIgnoreCase(status)){
        %>
            <span class="badge bg-success">Delivered</span>

        <%
        } else {
        %>
            <span class="badge bg-secondary"><%= status %></span>
        <%
        }
        %>

    </td>
</tr>

<%
}
%>

</table>

</div>

<%
} else {
%>

<p class="text-center text-muted mt-3">No orders found</p>

<%
}
%>

</div>
</div>

</body>
</html>