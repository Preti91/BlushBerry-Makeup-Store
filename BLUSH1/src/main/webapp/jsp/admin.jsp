<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Connection con = null;

int totalUsers = 0;
int totalOrders = 0;
int totalProducts = 0;
double totalRevenue = 0;

try {
    con = DBConnection.getConnection();

    ResultSet rs1 = con.prepareStatement("SELECT COUNT(*) FROM users").executeQuery();
    if(rs1.next()) totalUsers = rs1.getInt(1);

    ResultSet rs2 = con.prepareStatement("SELECT COUNT(*) FROM orders").executeQuery();
    if(rs2.next()) totalOrders = rs2.getInt(1);

    ResultSet rs3 = con.prepareStatement("SELECT COUNT(*) FROM products").executeQuery();
    if(rs3.next()) totalProducts = rs3.getInt(1);

    ResultSet rs4 = con.prepareStatement("SELECT IFNULL(SUM(total),0) FROM orders").executeQuery();
    if(rs4.next()) totalRevenue = rs4.getDouble(1);

} catch(Exception e){
    out.println(e.getMessage());
}
%>

<html>
<head>
<title>Admin Dashboard | BlushBerry</title>

<!-- RESPONSIVE META -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

/* 🌈 THEME */
:root {
    --primary: #4f46e5;
    --secondary: #06b6d4;
    --dark: #0f172a;
    --glass: rgba(255,255,255,0.08);
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #0f172a, #1e293b);
    color: white;
    overflow-x: hidden;
}

/* HEADER */
.header {
    text-align: center;
    padding: 20px;
}

/* LOGOUT */
.logout-btn {
    position: fixed;
    top: 15px;
    right: 15px;
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    border: none;
    padding: 10px 14px;
    border-radius: 50%;
    font-size: 18px;
    z-index: 999;
}

/* STATS */
.stat-card {
    background: var(--glass);
    backdrop-filter: blur(12px);
    border-radius: 18px;
    padding: 20px;
    text-align: center;
    transition: 0.3s;
    border: 1px solid rgba(255,255,255,0.1);
    margin-bottom: 15px;
}

.stat-card:hover {
    transform: translateY(-5px);
}

/* ADMIN BOX */
.admin-box {
    width: 100%;
    max-width: 420px;
    padding: 25px;
    background: var(--glass);
    backdrop-filter: blur(12px);
    border-radius: 20px;
    margin: 30px auto;
    border: 1px solid rgba(255,255,255,0.1);
}

/* TABLE */
.table-box {
    width: 95%;
    margin: auto;
    margin-top: 30px;
    overflow-x: auto;
}

/* RESPONSIVE TABLE FIX */
.table {
    border-radius: 12px;
    overflow: hidden;
    min-width: 600px;
}

/* BUTTON */
.btn {
    border-radius: 10px;
}

/* MOBILE RESPONSIVE */
@media (max-width: 768px) {
    .header h2 {
        font-size: 20px;
    }

    .stat-card h2 {
        font-size: 18px;
    }

    .admin-box {
        width: 90%;
    }
}

</style>

</head>

<body>

<!-- LOGOUT -->
<form action="<%=request.getContextPath()%>/admin" method="post">
    <input type="hidden" name="action" value="logout">
    <button class="logout-btn" title="Logout">
        <i class="fa-solid fa-power-off"></i>
    </button>
</form>

<!-- HEADER -->
<div class="header">
    <h2>🛍 BlushBerry Admin Dashboard</h2>
    <p>Manage your store efficiently</p>
</div>

<!-- STATS -->
<div class="container-fluid px-3">
<div class="row text-center g-3">

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stat-card">
            <i class="fa-solid fa-users fa-2x text-primary"></i>
            <h5>Users</h5>
            <h2><%= totalUsers %></h2>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stat-card">
            <i class="fa-solid fa-box fa-2x text-success"></i>
            <h5>Orders</h5>
            <h2><%= totalOrders %></h2>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stat-card">
            <i class="fa-solid fa-cart-shopping fa-2x text-warning"></i>
            <h5>Products</h5>
            <h2><%= totalProducts %></h2>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-3">
        <div class="stat-card">
            <i class="fa-solid fa-indian-rupee-sign fa-2x text-danger"></i>
            <h5>Revenue</h5>
            <h2>₹<%= totalRevenue %></h2>
        </div>
    </div>

</div>
</div>

<!-- ADD PRODUCT -->
<div class="admin-box text-center">

    <h4>Add Product</h4>

    <form action="<%=request.getContextPath()%>/admin" method="post" enctype="multipart/form-data">

        <input type="hidden" name="action" value="add">

        <input type="text" name="name" placeholder="Product Name" class="form-control mb-2" required>

        <input type="number" name="price" placeholder="Price" class="form-control mb-2" required>

        <input type="date" name="delivery_date" class="form-control mb-2" required>

        <input type="file" name="image" class="form-control mb-2" required>

        <button class="btn btn-primary w-100">Add Product</button>

    </form>

</div>

<!-- PRODUCT TABLE -->
<div class="table-box">

<h4 class="text-center">Product Management</h4>

<table class="table table-dark table-bordered mt-3">

<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Price</th>
    <th>Date</th>
    <th>Image</th>
    <th>Action</th>
</tr>

<%
ResultSet rs = con.prepareStatement("SELECT * FROM products").executeQuery();

while(rs.next()){
%>

<tr>
    <td><%=rs.getInt("id")%></td>
    <td><%=rs.getString("name")%></td>
    <td>₹<%=rs.getDouble("price")%></td>
    <td><%=rs.getDate("delivery_date")%></td>

    <td>
        <img src="<%=request.getContextPath()%>/images/<%=rs.getString("image")%>" width="50" height="50">
    </td>

    <td>
        <a href="editProduct.jsp?id=<%=rs.getInt("id")%>" class="btn btn-warning btn-sm">Edit</a>

        <form action="<%=request.getContextPath()%>/admin" method="post" style="display:inline;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
            <button class="btn btn-danger btn-sm">Delete</button>
        </form>
    </td>
</tr>

<%
}
%>

</table>
</div>

<!-- ORDER TABLE -->
<div class="table-box">

<h4 class="text-center mt-5">Order Management</h4>

<table class="table table-dark table-bordered mt-3">

<tr>
    <th>ID</th>
    <th>User</th>
    <th>Total</th>
    <th>Date</th>
    <th>Status</th>
    <th>Update</th>
</tr>

<%
ResultSet ro = con.prepareStatement("SELECT * FROM orders ORDER BY id DESC").executeQuery();

while(ro.next()){
    String status = ro.getString("status");
%>

<tr>
    <td><%=ro.getInt("id")%></td>
    <td><%=ro.getInt("user_id")%></td>
    <td>₹<%=ro.getDouble("total")%></td>
    <td><%=ro.getTimestamp("order_date")%></td>

    <td><span class="badge bg-info"><%=status%></span></td>

    <td>
        <form action="<%=request.getContextPath()%>/admin" method="post">

            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="orderId" value="<%=ro.getInt("id")%>">

            <select name="status" class="form-select form-select-sm">
                <option>pending</option>
                <option>confirmed</option>
                <option>packed</option>
                <option>delivered</option>
            </select>

            <button class="btn btn-success btn-sm mt-1">Update</button>

        </form>
    </td>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>