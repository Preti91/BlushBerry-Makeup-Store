<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.Product" %>

<html>
<head>
<title>Cart | BlushBerry</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* BACKGROUND */
body {
    background: linear-gradient(135deg, #f9fafb, #eef2ff);
    font-family: 'Poppins', sans-serif;
    overflow-x: hidden;
}

/* TABLE WRAPPER */
.table-responsive {
    border-radius: 15px;
    overflow-x: auto;
}

/* TABLE */
.table {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    min-width: 600px;
}

/* PRODUCT ICON */
.product-icon {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: linear-gradient(135deg, #4f46e5, #06b6d4);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    margin: auto;
}

/* SUMMARY BOX */
.summary-box {
    background: white;
    padding: 20px;
    border-radius: 20px;
    text-align: center;
    margin-top: 25px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    border-top: 4px solid #4f46e5;
}

/* EMPTY CART */
.empty {
    padding: 30px;
    color: gray;
}

/* BUTTON */
.btn {
    border-radius: 10px;
}

/* MOBILE */
@media (max-width: 768px) {
    h2 { font-size: 20px; }
    .summary-box { padding: 15px; }
    .table { font-size: 13px; }
}

</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">

<h2 class="text-center">
    <i class="fa-solid fa-cart-shopping"></i> Your Shopping Cart
</h2>

<%
List<Product> cartList = (List<Product>) request.getAttribute("cartList");
double total = 0;
int totalItems = 0;   // ✅ FIXED
%>

<!-- TABLE -->
<div class="table-responsive mt-3">

<table class="table text-center align-middle">

<thead class="table-dark">
<tr>
    <th>Product</th>
    <th>Name</th>
    <th>Price</th>
    <th>Qty</th>
    <th>Subtotal</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
if(cartList != null && !cartList.isEmpty()){
    for(Product p : cartList){

        double sub = p.getPrice() * p.getQuantity();
        total += sub;

        totalItems += p.getQuantity();   // ✅ FIXED
%>

<tr>

<td>
    <div class="product-icon">
        <i class="fa-solid fa-bag-shopping"></i>
    </div>
</td>

<td><%= p.getName() %></td>

<td>&#8377; <%= p.getPrice() %></td>

<td>
<a href="<%=request.getContextPath()%>/updateCart?action=decrease&pid=<%= p.getId() %>"
   class="btn btn-sm btn-warning">-</a>

<span class="mx-2"><%= p.getQuantity() %></span>

<a href="<%=request.getContextPath()%>/updateCart?action=increase&pid=<%= p.getId() %>"
   class="btn btn-sm btn-success">+</a>
</td>

<td class="fw-bold text-primary">&#8377; <%= sub %></td>

<td>
<a href="<%=request.getContextPath()%>/removeCart?pid=<%= p.getId() %>"
   class="btn btn-danger btn-sm">
   <i class="fa-solid fa-trash"></i>
</a>
</td>

</tr>

<%
    }
} else {
%>

<tr>
<td colspan="6" class="empty">
    <i class="fa-solid fa-cart-xmark fa-2x"></i><br>
    Your cart is empty
</td>
</tr>

<%
}
%>

</tbody>
</table>

</div>

<!-- SUMMARY -->
<%
if(cartList != null && !cartList.isEmpty()){
%>

<div class="summary-box">

<h4>
    <i class="fa-solid fa-receipt"></i> Order Summary
</h4>

<p>
    <i class="fa-solid fa-box"></i>
    Total Items: <%= totalItems %>   <!-- ✅ FIXED -->
</p>

<h5>
    <i class="fa-solid fa-indian-rupee-sign"></i>
    Total Price: &#8377; <%= total %>
</h5>

<form action="<%=request.getContextPath()%>/order" method="post">

    <button type="submit" class="btn btn-success w-100 mt-2">
        <i class="fa-solid fa-bag-shopping"></i> Place Order
    </button>

</form>

</div>

<%
}
%>

</div>

</body>
</html>