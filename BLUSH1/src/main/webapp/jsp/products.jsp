products.jsp

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.Product,model.User" %>
<%@ page import="java.util.Set" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}

List<Product> list = (List<Product>) request.getAttribute("productList");
Set<Integer> wishIds = (Set<Integer>) request.getAttribute("wishIds");
String keyword = request.getParameter("keyword");
%>

<html>
<head>
<title>Products</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body { background:#f8fafc; font-family:'Poppins'; }

/* HERO */
.hero {
    background: linear-gradient(135deg, #6366f1, #06b6d4);
    padding: 50px 15px;
    border-radius: 0 0 40px 40px;
    text-align: center;
    color: white;
}

.hero h1 { font-size: 30px; font-weight: bold; }

.search-box {
    display:flex;
    justify-content:center;
    margin-top:20px;
}

.search-box input {
    width:600px;
    max-width:90%;
    padding:12px;
    border:none;
    border-radius:40px 0 0 40px;
}

.search-box button {
    padding:12px 18px;
    border:none;
    background:#111827;
    color:white;
    border-radius:0 40px 40px 0;
}

/* GRID */
.product-grid {
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
    gap:15px;
    width:95%;
    margin:auto;
    margin-top:30px;
}

.card {
    background:white;
    border-radius:18px;
    padding:15px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

/* IMAGE */
.card img {
    display:block;
    margin:auto;
    cursor:pointer;
}

.price { font-weight:bold; }

.qty-box{
    display:flex;
    justify-content:center;
    gap:10px;
    margin-top:10px;
}

.qty-box button{
    background:#111827;
    color:white;
    border:none;
    padding:3px 10px;
}

.qty-box input{
    width:40px;
    text-align:center;
}

/* ✅ ADD SPACE HERE */
.cartForm button{
    margin-top:10px;
}

/* TEMPLATE */
.empty-box{
    text-align:center;
    margin-top:50px;
}

/* TOAST */
#toast{
    position:fixed;
    bottom:20px;
    right:20px;
    background:#111827;
    color:white;
    padding:10px;
    border-radius:8px;
    display:none;
}

/* MODAL */
.image-modal{
    display:none;
    position:fixed;
    z-index:9999;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.9);
    text-align:center;
}

.image-modal img{
    margin-top:5%;
    max-width:80%;
    max-height:80%;
    border-radius:10px;
}

.close-btn{
    position:absolute;
    top:20px;
    right:30px;
    font-size:35px;
    color:white;
    cursor:pointer;
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="hero">
    <h1>💄 Discover Beauty Products</h1>

    <form action="<%=request.getContextPath()%>/searchProduct" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="Search makeup, skincare..." required>
        <button><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>
</div>

<%
if(list != null && !list.isEmpty()){
%>

<div class="product-grid">

<%
for(Product p : list){
%>

<div class="card">

<img src="<%=request.getContextPath()%>/images/<%=p.getImage()%>" 
     width="80"
     onclick="openImage(this.src)">

<h5><%=p.getName()%></h5>
<p class="price">₹ <%=p.getPrice()%></p>

<button onclick="toggleWishlist(this,'<%=p.getId()%>')" 
style="background:none;border:none;font-size:20px;cursor:pointer;">

<i class="fa-heart 
<%= (wishIds!=null && wishIds.contains(p.getId())) ? "fa-solid" : "fa-regular" %>"
style="color:<%= (wishIds!=null && wishIds.contains(p.getId())) ? "#ec4899" : "#9ca3af" %>;">
</i>

</button>

<form class="cartForm">

<input type="hidden" name="productId" value="<%=p.getId()%>">

<div class="qty-box">
<button type="button" onclick="dec(this)">-</button>
<input type="text" name="qty" value="0" readonly>
<button type="button" onclick="inc(this)">+</button>
</div>

<!-- SPACE APPLIED HERE -->
<button>Add to Cart</button>

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
<div style="background:linear-gradient(135deg,#fbcfe8,#c7d2fe);
padding:40px;border-radius:25px;width:90%;margin:auto;">

<h1>✨ Welcome to BlushBerry 💖</h1>
<p>Glow like never before ✨ Discover your perfect beauty essentials 💄</p>

</div>
</div>

<%
}
%>

<div id="imgModal" class="image-modal">
    <span class="close-btn" onclick="closeImage()">&times;</span>
    <img id="modalImg">
</div>

<div id="toast"></div>

<script>
function openImage(src){
    document.getElementById("imgModal").style.display="block";
    document.getElementById("modalImg").src=src;
}
function closeImage(){
    document.getElementById("imgModal").style.display="none";
}

function inc(btn){
let i=btn.parentElement.querySelector("input");
i.value=parseInt(i.value)+1;
}
function dec(btn){
let i=btn.parentElement.querySelector("input");
if(i.value>0)i.value=parseInt(i.value)-1;
}

function showToast(msg){
let t=document.getElementById("toast");
t.innerText=msg;
t.style.display="block";
setTimeout(()=>t.style.display="none",2000);
}

document.querySelectorAll(".cartForm").forEach(f=>{
f.addEventListener("submit",e=>{
e.preventDefault();

let qty=f.qty.value;
if(qty==0){showToast("Select qty ❗");return;}

let d=new URLSearchParams();
d.append("productId",f.productId.value);
d.append("qty",qty);

fetch("<%=request.getContextPath()%>/cart",{
method:"POST",
headers:{"Content-Type":"application/x-www-form-urlencoded"},
body:d
}).then(()=>showToast("Added to cart 🛒"));
});
});

function toggleWishlist(btn,id){

let icon=btn.querySelector("i");
let added=icon.classList.contains("fa-solid");

let action=added?"remove":"add";

let d=new URLSearchParams();
d.append("productId",id);
d.append("action",action);

fetch("<%=request.getContextPath()%>/wishlist",{
method:"POST",
headers:{"Content-Type":"application/x-www-form-urlencoded"},
body:d
})
.then(()=>{
if(added){
icon.classList.remove("fa-solid");
icon.classList.add("fa-regular");
icon.style.color="#9ca3af";
showToast("Removed 💔");
}else{
icon.classList.remove("fa-regular");
icon.classList.add("fa-solid");
icon.style.color="#ec4899";
showToast("Added 💖");
}
});
}
</script>

</body>
</html>