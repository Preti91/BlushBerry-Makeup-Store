<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>Logging Out</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<meta http-equiv="refresh" content="3;url=<%=request.getContextPath()%>/jsp/home.jsp">

<style>

/* BACKGROUND */
body {
    background: #0f172a;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    font-family: 'Poppins', sans-serif;
}

/* CARD */
.box {
    text-align: center;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    padding: 45px;
    border-radius: 25px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.4);
    animation: pop 0.5s ease;
    color: white;
    width: 400px;
}

/* POP */
@keyframes pop {
    from { transform: scale(0.8); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

/* ICON */
.icon {
    font-size: 60px;
    color: #4f7cff;
    margin-bottom: 15px;
    animation: float 2s infinite ease-in-out;
}

/* FLOAT */
@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
    100% { transform: translateY(0px); }
}

/* BUTTON */
.btn-custom {
    margin-top: 15px;
    background: linear-gradient(45deg, #4f7cff, #00c6ff);
    border: none;
    padding: 10px 20px;
    border-radius: 30px;
    color: white;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
}

.btn-custom:hover {
    transform: scale(1.05);
}

p {
    color: #cbd5e1;
}

h2 {
    margin-top: 10px;
}

</style>

</head>

<body>

<div class="box">

    <!-- ICON FIXED -->
    <div class="icon">
        <i class="fa-solid fa-right-from-bracket"></i>
    </div>

    <h2>
        <i class="fa-solid fa-circle-check"></i>
        Logged Out Successfully
    </h2>

    <p>
        <i class="fa-solid fa-heart"></i>
        We hope to see you again at Blush Store
    </p>

    <p>
        <i class="fa-solid fa-clock"></i>
        Redirecting in 3 seconds...
    </p>

    <a href="<%=request.getContextPath()%>/jsp/home.jsp" class="btn-custom">
        <i class="fa-solid fa-house"></i> Go Home Now
    </a>

</div>

</body>
</html>