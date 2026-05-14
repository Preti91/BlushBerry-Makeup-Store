
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<%@ page import="dao.CartDAO,dao.WishlistDAO,model.User" %>

<%
User user = (User) session.getAttribute("user");

int cartCount = 0;
int wishlistCount = 0;

if(user != null){
    CartDAO cartDao = new CartDAO();
    cartCount = cartDao.getCartCount(user.getId());

    WishlistDAO wishDao = new WishlistDAO();
    wishlistCount = wishDao.getWishlist(user.getId()).size();
}
%>

<style>

/* 🌈 THEME */
:root {
    --primary: #4f46e5;
    --secondary: #06b6d4;
    --dark: #0f172a;
}

/* NAVBAR */
.navbar-custom {
    background: rgba(15, 23, 42, 0.9);
    backdrop-filter: blur(12px);
    padding: 12px 18px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 999;
    border-bottom: 1px solid rgba(255,255,255,0.1);
}

/* BRAND */
.brand {
    font-size: 20px;
    font-weight: 700;
    color: white;
    display: flex;
    align-items: center;
    gap: 8px;
}

/* NAV LINKS */
.nav-links {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

/* LINKS */
.nav-links a {
    color: white;
    text-decoration: none;
    padding: 8px 12px;
    border-radius: 25px;
    transition: 0.3s;
    display: flex;
    align-items: center;
    gap: 6px;
    font-weight: 500;
    font-size: 14px;
}

.nav-links a:hover {
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    transform: scale(1.05);
}

/* BADGES */
.badge-cart {
    background: #ef4444;
    color: white;
    font-size: 10px;
    padding: 3px 7px;
    border-radius: 50%;
    margin-left: 5px;
}

.badge-wish {
    background: #ec4899;
    color: white;
    font-size: 10px;
    padding: 3px 7px;
    border-radius: 50%;
    margin-left: 5px;
}

/* TOGGLE */
.menu-toggle {
    display: none;
    font-size: 22px;
    color: white;
    cursor: pointer;
}

/* MOBILE */
@media (max-width: 768px) {

    .navbar-custom {
        flex-direction: column;
        align-items: flex-start;
    }

    .menu-toggle {
        display: block;
        position: absolute;
        right: 15px;
        top: 15px;
    }

    .nav-links {
        display: none;
        flex-direction: column;
        width: 100%;
        margin-top: 10px;
        background: rgba(15,23,42,0.98);
        padding: 10px;
        border-radius: 10px;
    }

    .nav-links.active {
        display: flex;
    }

    .nav-links a {
        width: 100%;
        justify-content: flex-start;
        font-size: 15px;
    }

    .brand {
        font-size: 18px;
    }
}

</style>

<nav class="navbar-custom">

    <!-- BRAND -->
    <div class="brand">
        <i class="fa-solid fa-gem"></i> BlushBerry
    </div>

    <!-- MOBILE TOGGLE -->
    <div class="menu-toggle" onclick="toggleMenu()">
        <i class="fa-solid fa-bars"></i>
    </div>

    <!-- LINKS -->
    <div class="nav-links" id="navLinks">

        <a href="<%=request.getContextPath()%>/jsp/home.jsp">
            <i class="fa-solid fa-house"></i> Home
        </a>

        <a href="<%=request.getContextPath()%>/products">
            <i class="fa-solid fa-bag-shopping"></i> Products
        </a>

        <!-- ❤️ WISHLIST -->
        <a href="<%=request.getContextPath()%>/wishlist">
            <i class="fa-solid fa-heart"></i> Wishlist
            <span class="badge-wish"><%= wishlistCount %></span>
        </a>

        <!-- 🛒 CART -->
        <a href="<%=request.getContextPath()%>/cart">
            <i class="fa-solid fa-cart-shopping"></i> Cart
            <span class="badge-cart"><%= cartCount %></span>
        </a>

        <a href="<%=request.getContextPath()%>/order">
            <i class="fa-solid fa-truck-fast"></i> Orders
        </a>

        <a href="<%=request.getContextPath()%>/jsp/login.jsp">
            <i class="fa-solid fa-user"></i> Login
        </a>

        <a href="<%=request.getContextPath()%>/jsp/signup.jsp">
            <i class="fa-solid fa-user-plus"></i> Signup
        </a>

        <a href="<%=request.getContextPath()%>/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>

		<!-- HELP CENTER -->
		<a href="<%=request.getContextPath()%>/jsp/helpcenter.jsp">
    		<i class="fa-solid fa-comments"></i> Help
		</a>
    </div>

</nav>

<script>
function toggleMenu() {
    document.getElementById("navLinks").classList.toggle("active");
}
</script>