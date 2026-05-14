<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>Signup</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* BACKGROUND */
body {
    background: linear-gradient(135deg, #f8fafc, #e2e8f0);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    font-family: 'Poppins', sans-serif;
    padding: 10px;
}

/* SIGNUP BOX */
.signup-box {
    margin: auto;
    width: 100%;
    max-width: 380px;
    padding: 30px;
    background: white;
    border-radius: 25px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    text-align: center;
    animation: pop 0.5s ease;
    color: #111827;
}

/* ANIMATION */
@keyframes pop {
    from { transform: scale(0.8); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

/* TITLE */
.signup-box h2 {
    margin-bottom: 15px;
    font-weight: 700;
    font-size: 22px;
}

/* INPUT */
.input-group input {
    width: 100%;
    padding: 12px;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
    margin-bottom: 15px;
    outline: none;
    transition: 0.3s;
}

.input-group input:focus {
    border-color: #4f46e5;
    box-shadow: 0 0 8px rgba(79,70,229,0.3);
}

/* BUTTON */
.btn-signup {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 30px;
    background: linear-gradient(135deg, #4f46e5, #06b6d4);
    color: white;
    font-weight: bold;
    transition: 0.3s;
}

.btn-signup:hover {
    transform: scale(1.03);
    box-shadow: 0 10px 25px rgba(79,70,229,0.3);
}

/* LINK */
a {
    text-decoration: none;
    color: #4f46e5;
    font-weight: 500;
}

/* ICON */
.icon {
    font-size: 45px;
    margin-bottom: 10px;
    color: #4f46e5;
    animation: float 2s infinite ease-in-out;
}

/* FLOAT */
@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-8px); }
    100% { transform: translateY(0px); }
}

/* MOBILE */
@media (max-width: 480px) {

    .signup-box {
        padding: 20px;
        border-radius: 18px;
    }

    .signup-box h2 {
        font-size: 18px;
    }

    .icon {
        font-size: 40px;
    }
}

</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="signup-box">

    <div class="icon">
        <i class="fa-solid fa-user-plus"></i>
    </div>

    <h2>
        <i class="fa-solid fa-user-pen"></i>
        Create Account
    </h2>

    <p style="color:#6b7280; font-size:14px;">
        <i class="fa-solid fa-bag-shopping"></i>
        Join BlushBerry & start shopping
    </p>

    <form action="<%=request.getContextPath()%>/signup" method="post">

        <div class="input-group">
            <input type="text" name="name" placeholder="Enter Name" required>
        </div>

        <div class="input-group">
            <input type="email" name="email" placeholder="Enter Email" required>
        </div>

        <div class="input-group">
            <input type="password" name="password" placeholder="Enter Password" required>
        </div>

        <button type="submit" class="btn-signup">
            <i class="fa-solid fa-user-plus"></i> Create Account
        </button>

    </form>

    <p class="mt-3" style="font-size:14px;">
        Already have an account?
        <a href="<%=request.getContextPath()%>/jsp/login.jsp">
            <i class="fa-solid fa-right-to-bracket"></i> Login
        </a>
    </p>

</div>

</body>
</html>