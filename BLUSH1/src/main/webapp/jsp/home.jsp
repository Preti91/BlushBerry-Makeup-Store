<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>BlushBerry Store</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

/* ROOT */
:root {
    --primary: #4f46e5;
    --secondary: #06b6d4;
    --dark: #111827;
}

/* BODY */
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f9fafb, #eef2ff);
}

/* HERO */
.hero {
    min-height: 90vh;
    background: linear-gradient(rgba(17,24,39,0.6), rgba(17,24,39,0.6)),
    url('https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9');
    background-size: cover;
    background-position: center;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    padding: 20px;
}

.hero-content {
    max-width: 800px;
    background: rgba(0,0,0,0.35);
    padding: 40px;
    border-radius: 20px;
}

.hero h1 {
    font-size: 60px;
    font-weight: 700;
}

.hero p {
    font-size: 20px;
}

/* BUTTON */
.hero-btn {
    margin-top: 20px;
    padding: 12px 30px;
    border-radius: 30px;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    color: white;
    display: inline-block;
    text-decoration: none;
}

/* STATEMENT */
.statement-box {
    margin-top: -50px;
    background: white;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

/* FEATURES */
.feature-card {
    background: white;
    border-radius: 20px;
    padding: 25px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.feature-card:hover {
    transform: translateY(-8px);
}

/* PROMO */
.promo {
    margin-top: 50px;
    padding: 50px;
    border-radius: 20px;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    color: white;
    text-align: center;
}

/* FOOTER */
.footer {
    margin-top: 50px;
    text-align: center;
    padding: 15px;
    background: var(--dark);
    color: white;
}

/* ✅ RESPONSIVE FIX */
@media (max-width: 768px) {

    .hero h1 {
        font-size: 32px;
    }

    .hero p {
        font-size: 16px;
    }

    .hero-content {
        padding: 20px;
    }

    .statement-box {
        padding: 20px;
    }

    .promo {
        padding: 25px;
    }

}

</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<!-- HERO -->
<div class="hero">
    <div class="hero-content">
        <h1>✨ BlushBerry</h1>
        <p>Luxury Beauty • Affordable Prices</p>

        <a href="<%=request.getContextPath()%>/jsp/products.jsp" class="hero-btn">
            Shop Now 💄
        </a>
    </div>
</div>

<!-- STATEMENT -->
<div class="container">
    <div class="statement-box">
        <h2>💖 Why Choose BlushBerry?</h2>
        <p>No hidden charges • Only premium beauty products</p>
    </div>
</div>

<!-- FEATURES -->
<div class="container mt-5">
<div class="row g-4 text-center">

    <div class="col-md-3 col-6">
        <div class="feature-card">💰 Best Prices</div>
    </div>

    <div class="col-md-3 col-6">
        <div class="feature-card">⭐ Top Rated</div>
    </div>

    <div class="col-md-3 col-6">
        <div class="feature-card">🚚 Fast Delivery</div>
    </div>

    <div class="col-md-3 col-6">
        <div class="feature-card">₹ COD Available</div>
    </div>

</div>
</div>

<!-- PROMO -->
<div class="container">
    <div class="promo">
        <h2>Glow with Confidence 💫</h2>
        <p>Discover skincare, makeup & beauty essentials</p>
    </div>
</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 BlushBerry Store
</div>

</body>
</html>