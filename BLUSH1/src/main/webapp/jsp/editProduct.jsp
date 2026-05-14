<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM products WHERE id=?"
    );

    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        out.println("<h3 style='color:red;text-align:center;margin-top:50px'>Product Not Found</h3>");
        return;
    }
%>

<html>
<head>
<title>Edit Product</title>

<!-- RESPONSIVE META -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* 🌙 DARK BACKGROUND */
body {
    background: linear-gradient(135deg, #0f172a, #1e293b);
    font-family: 'Poppins', sans-serif;
    padding: 10px;
    color: #e5e7eb;
}

/* BOX */
.box {
    width: 100%;
    max-width: 450px;
    margin: 30px auto;
    padding: 25px;
    background: #1f2937;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.6);
    position: relative; /* IMPORTANT for cross button */
}

/* ❌ CLOSE BUTTON */
.close-btn {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 28px;
    color: #9ca3af;
    text-decoration: none;
    font-weight: bold;
    transition: 0.3s;
}

.close-btn:hover {
    color: #ef4444;
    transform: scale(1.2);
}

/* TITLE */
h3 {
    font-weight: 700;
    margin-bottom: 20px;
    color: #f9fafb;
    font-size: 22px;
}

/* INPUTS */
input {
    margin-bottom: 12px;
    border-radius: 10px !important;
    background: #111827;
    border: 1px solid #374151;
    color: #f9fafb;
}

input::placeholder {
    color: #9ca3af;
}

/* IMAGE */
img {
    border-radius: 12px;
    margin-bottom: 10px;
    border: 2px solid #374151;
    max-width: 100%;
    height: auto;
}

/* BUTTON */
.btn-warning {
    background: linear-gradient(135deg, #f59e0b, #f97316);
    border: none;
    color: white;
    font-weight: 600;
    border-radius: 25px;
    padding: 10px;
    transition: 0.3s;
}

.btn-warning:hover {
    transform: scale(1.03);
    box-shadow: 0 10px 25px rgba(245,158,11,0.5);
}

/* LABEL */
label {
    font-weight: 500;
    margin-top: 5px;
    color: #d1d5db;
}

/* MOBILE FIX */
@media (max-width: 576px) {
    .box {
        margin: 15px;
        padding: 18px;
    }

    h3 {
        font-size: 18px;
    }
}

</style>

</head>

<body>

<div class="box">

    <!-- ❌ CROSS BUTTON -->
    <a href="admin.jsp" class="close-btn">&times;</a>

    <h3 class="text-center">Edit Product</h3>

    <form action="<%=request.getContextPath()%>/admin" method="post" enctype="multipart/form-data">

        <!-- ACTION -->
        <input type="hidden" name="action" value="update">

        <!-- ID -->
        <input type="hidden" name="id" value="<%=rs.getInt("id")%>">

        <!-- NAME -->
        <label>Product Name</label>
        <input type="text" class="form-control"
               name="name"
               value="<%=rs.getString("name")%>"
               required>

        <!-- PRICE -->
        <label>Price</label>
        <input type="number" class="form-control"
               name="price"
               value="<%=rs.getDouble("price")%>"
               required>

        <!-- DATE -->
        <label>Delivery Date</label>
        <input type="date" class="form-control"
               name="delivery_date"
               value="<%=rs.getDate("delivery_date")%>"
               required>

        <!-- CURRENT IMAGE -->
        <label>Current Image</label><br>
        <img src="<%=request.getContextPath()%>/images/<%=rs.getString("image")%>"
             width="120" height="120">

        <!-- NEW IMAGE -->
        <label>Change Image (optional)</label>
        <input type="file" class="form-control" name="image">

        <button type="submit" class="btn btn-warning w-100 mt-3">
            Update Product
        </button>

    </form>

</div>

</body>
</html>