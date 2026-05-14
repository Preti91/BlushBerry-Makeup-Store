

<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/jsp/products.jsp");
        return;
    }
%>

<html>
<head>
<title>Login</title>

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

/* LOGIN BOX */
.login-box {
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

@keyframes pop {
    from { transform: scale(0.8); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
}

.login-box h2 {
    margin-bottom: 20px;
    font-weight: 700;
    font-size: 22px;
}

/* INPUT */
.input-group {
    position: relative;
}

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

/* 👁️ EYE ICON */
.eye-icon {
    position: absolute;
    right: 15px;
    top: 12px;
    cursor: pointer;
    color: #6b7280;
}

/* BUTTON */
.btn-login {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 30px;
    background: linear-gradient(135deg, #4f46e5, #06b6d4);
    color: white;
    font-weight: bold;
    transition: 0.3s;
}

.btn-login:hover {
    transform: scale(1.03);
    box-shadow: 0 10px 25px rgba(79,70,229,0.3);
}

a {
    text-decoration: none;
    color: #4f46e5;
    font-weight: 500;
}

.icon {
    font-size: 45px;
    margin-bottom: 10px;
    color: #4f46e5;
    animation: float 2s infinite ease-in-out;
}

@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-8px); }
    100% { transform: translateY(0px); }
}

@media (max-width: 480px) {
    .login-box {
        padding: 20px;
        border-radius: 18px;
    }

    .login-box h2 {
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

<div class="login-box">

    <div class="icon">
        <i class="fa-solid fa-circle-user"></i>
    </div>

    <h2>
        <i class="fa-solid fa-right-to-bracket"></i>
        Welcome Back
    </h2>

    <p style="color:#6b7280;">
        <i class="fa-solid fa-bag-shopping"></i>
        Login to continue shopping
    </p>

    <%
        String error = request.getParameter("error");
        if(error != null){
    %>
        <p style="color:red;">Invalid email or password</p>
    <%
        }
    %>

    <form action="<%=request.getContextPath()%>/login"
          method="post"
          autocomplete="off">

        <input type="text" name="fake_user" style="display:none">
        <input type="password" name="fake_pass" style="display:none">

        <!-- EMAIL -->
        <div class="input-group">
            <input type="email"
                   name="email"
                   placeholder="Enter Email"
                   autocomplete="off"
                   required>
        </div>

        <!-- PASSWORD WITH EYE -->
        <div class="input-group">
            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Enter Password"
                   autocomplete="new-password"
                   required>

            <i class="fa-solid fa-eye eye-icon" onclick="togglePassword()"></i>
        </div>

        <button type="submit" class="btn-login">
            <i class="fa-solid fa-right-to-bracket"></i> Login
        </button>

    </form>

    <p class="mt-3">
        New user?
        <a href="<%=request.getContextPath()%>/jsp/signup.jsp">
            <i class="fa-solid fa-user-plus"></i> Create Account
        </a>
    </p>

</div>

<script>
function togglePassword() {
    const pass = document.getElementById("password");
    const icon = document.querySelector(".eye-icon");

    if (pass.type === "password") {
        pass.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        pass.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}
</script>

</body>
</html>