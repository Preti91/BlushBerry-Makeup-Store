wishlist.jsp

<%@ page import="java.util.*,model.Product" %>

<%
if(request.getAttribute("wishlist") == null){
    response.sendRedirect(request.getContextPath() + "/wishlist");
    return;
}

List<Product> list = (List<Product>) request.getAttribute("wishlist");
%>

<html>
<head>
<title>My Wishlist</title>

<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

body {
    background: linear-gradient(135deg, #f1f5f9, #e0f2fe);
    font-family: 'Poppins', sans-serif;
}

/* HEADER */
.header {
    text-align: center;
    padding: 40px 20px;
    background: linear-gradient(135deg, #0f172a, #334155);
    color: white;
    border-radius: 0 0 40px 40px;
}

/* GRID */
.wishlist-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    width: 90%;
    margin: 30px auto;
}

/* CARD */
.card {
    width: 220px;
    background: white;
    border-radius: 18px;
    padding: 15px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
}

/* ✅ CENTER IMAGE */
.card img {
    width: 90px;
    height: 90px;
    object-fit: contain;
    margin: 0 auto 10px auto;
    display: block;
    cursor: pointer;
}

.price {
    font-weight: bold;
}

/* BUTTONS */
.btn-remove {
    background: #ef4444;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 20px;
    margin-top: 8px;
}

.btn-cart {
    background: #06b6d4;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 20px;
    margin-top: 8px;
}

.btn-remove:hover { background:#dc2626; }
.btn-cart:hover { background:#0891b2; }

/* EMPTY */
.empty-box {
    text-align: center;
    margin-top: 60px;
}

/* ✅ IMAGE MODAL */
.image-modal {
    display: none;
    position: fixed;
    z-index: 9999;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.9);
    text-align: center;
}

.image-modal img {
    margin-top: 5%;
    max-width: 80%;
    max-height: 80%;
    border-radius: 10px;
}

/* ❌ CLOSE BUTTON */
.close-btn {
    position: absolute;
    top: 20px;
    right: 30px;
    font-size: 35px;
    color: white;
    cursor: pointer;
}

</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="header">
    <h1><i class="fa-solid fa-heart"></i> My Wishlist</h1>
    <p>Save your favorite items and explore anytime</p>
</div>

<%
if(list != null && !list.isEmpty()){
%>

<div class="wishlist-grid">

<%
for(Product p : list){
%>

<div class="card">

    <!-- ✅ CLICK IMAGE -->
    <img src="<%=request.getContextPath()%>/images/<%=p.getImage()%>" 
         onclick="openImage(this.src)">

    <h5><%=p.getName()%></h5>

    <p class="price">Rs. <%=p.getPrice()%></p>

    <!-- REMOVE -->
    <form action="<%=request.getContextPath()%>/wishlist" method="post">
        <input type="hidden" name="productId" value="<%=p.getId()%>">
        <input type="hidden" name="action" value="remove">
        <input type="hidden" name="source" value="wishlist">

        <button class="btn-remove">
            <i class="fa-solid fa-trash"></i> Remove
        </button>
    </form>

    <!-- ✅ ADD TO CART + REMOVE FROM WISHLIST -->
    <form action="<%=request.getContextPath()%>/cart" method="post">
        <input type="hidden" name="productId" value="<%=p.getId()%>">
        <input type="hidden" name="qty" value="1">
        <input type="hidden" name="fromWishlist" value="true">

        <button class="btn-cart">
            <i class="fa-solid fa-cart-plus"></i> Add to Cart
        </button>
    </form>

</div>

<%
}
%>

</div>

<%
}else{
%>

<div class="empty-box">
    <h2>Your Wishlist is Empty</h2>
    <p>Start adding your favorite products </p>
</div>

<%
}
%>

<!-- ✅ MODAL -->
<div id="imgModal" class="image-modal">
    <span class="close-btn" onclick="closeImage()">&times;</span>
    <img id="modalImg">
</div>

<script>
function openImage(src){
    document.getElementById("imgModal").style.display="block";
    document.getElementById("modalImg").src=src;
}

function closeImage(){
    document.getElementById("imgModal").style.display="none";
}
</script>

</body>
</html>