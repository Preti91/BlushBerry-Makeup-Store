<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>BLUSHBERRY Help Center</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    padding:0;
    font-family:'Segoe UI', Arial, sans-serif;
    background:linear-gradient(135deg,#f8fbff,#eef3ff,#fdf2f8);
    min-height:100vh;
}

/* =========================
   Help Container
========================= */

.help-container{

    width:850px;
    max-width:95%;

    margin:40px auto;

    background:rgba(255,255,255,0.78);

    backdrop-filter:blur(14px);
    -webkit-backdrop-filter:blur(14px);

    border:1px solid rgba(255,255,255,0.5);

    border-radius:28px;

    padding:30px;

    box-shadow:
        0 20px 50px rgba(37,117,252,0.12),
        0 8px 20px rgba(0,0,0,0.08);

    position:relative;
    overflow:hidden;
}

/* Background Glow */

.help-container::before{

    content:"";

    position:absolute;

    top:-90px;
    right:-90px;

    width:220px;
    height:220px;

    background:
        radial-gradient(circle,
        rgba(106,17,203,0.18),
        transparent 70%);

    border-radius:50%;
}

.help-container::after{

    content:"";

    position:absolute;

    bottom:-90px;
    left:-90px;

    width:220px;
    height:220px;

    background:
        radial-gradient(circle,
        rgba(37,117,252,0.18),
        transparent 70%);

    border-radius:50%;
}

/* =========================
   Title
========================= */

.help-title{

    position:relative;
    z-index:1;

    text-align:center;

    margin-bottom:25px;

    font-size:34px;
    font-weight:800;

    background:
        linear-gradient(90deg,#6a11cb,#2575fc);

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;

    letter-spacing:0.5px;
}

/* =========================
   Chat Area
========================= */

.chat-area{

    position:relative;
    z-index:1;

    height:520px;

    overflow-y:auto;

    border:none;

    padding:18px;

    border-radius:22px;

    background:
        linear-gradient(180deg,#ffffff,#f7f9ff);

    box-shadow:
        inset 0 0 0 1px rgba(0,0,0,0.05);

    scroll-behavior:smooth;
}

/* Scrollbar */

.chat-area::-webkit-scrollbar{
    width:7px;
}

.chat-area::-webkit-scrollbar-thumb{
    background:#b8c6ff;
    border-radius:10px;
}

/* =========================
   Bot Message
========================= */

.bot{

    background:
        linear-gradient(135deg,#e9ecff,#f3e8ff);

    color:#2d2d2d;

    padding:14px 18px;

    border-radius:18px 18px 18px 6px;

    margin:14px 0;

    width:70%;

    line-height:1.7;

    font-size:15px;

    box-shadow:
        0 4px 12px rgba(106,17,203,0.08);

    animation:fadeIn 0.3s ease;

    white-space:pre-line;
}

/* =========================
   User Message
========================= */

.user{

    background:
        linear-gradient(135deg,#2575fc,#6a11cb);

    color:white;

    padding:14px 18px;

    border-radius:18px 18px 6px 18px;

    margin:14px 0;

    margin-left:auto;

    width:70%;

    line-height:1.7;

    font-size:15px;

    box-shadow:
        0 4px 12px rgba(37,117,252,0.18);

    animation:fadeIn 0.3s ease;

    white-space:pre-line;
}

/* =========================
   Input Area
========================= */

.input-area{

    position:relative;
    z-index:1;

    margin-top:20px;

    display:flex;

    align-items:center;

    gap:12px;
}

/* Input Box */

.input-area input{

    flex:1;

    padding:15px 18px;

    border:1px solid #d8defa;

    border-radius:14px;

    outline:none;

    font-size:15px;

    background:white;

    transition:all 0.3s ease;

    box-shadow:
        0 2px 8px rgba(0,0,0,0.04);
}

.input-area input:focus{

    border-color:#6a11cb;

    box-shadow:
        0 0 0 4px rgba(106,17,203,0.08);
}

.input-area input::placeholder{
    color:#9aa3b2;
}

/* =========================
   Send Button
========================= */

.input-area button{

    background:
        linear-gradient(90deg,#6a11cb,#2575fc);

    color:white;

    border:none;

    padding:15px 26px;

    border-radius:14px;

    cursor:pointer;

    font-size:15px;
    font-weight:700;

    letter-spacing:0.3px;

    transition:all 0.3s ease;

    box-shadow:
        0 8px 18px rgba(37,117,252,0.25);
}

.input-area button:hover{

    transform:translateY(-2px) scale(1.03);

    box-shadow:
        0 12px 24px rgba(37,117,252,0.32);
}

.input-area button:active{
    transform:scale(0.98);
}

/* =========================
   Animation
========================= */

@keyframes fadeIn{

    from{
        opacity:0;
        transform:translateY(10px);
    }

    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* =========================
   Mobile Responsive
========================= */

@media(max-width:700px){

    .help-container{
        margin:20px auto;
        padding:20px;
    }

    .help-title{
        font-size:26px;
    }

    .chat-area{
        height:420px;
    }

    .bot,
    .user{
        width:90%;
    }

    .input-area{
        flex-direction:column;
    }

    .input-area input,
    .input-area button{
        width:100%;
    }
}

</style>

</head>

<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<!-- Help Center -->

<div class="help-container">

    <h2 class="help-title">
        ✨ Beauty Help Assistant
    </h2>

    <!-- Chat Area -->

    <div class="chat-area" id="chatArea">

        <div class="bot">
Hello 👋 Welcome to BLUSHBERRY Help Center.

How can I help you today?

You can ask about:
• Delivery
• Orders
• Payment
• Return Policy
• Makeup Products
• Wishlist
        </div>

    </div>

    <!-- Input -->

    <div class="input-area">

        <input type="text"
               id="message"
               placeholder="Ask your question...">

        <button onclick="sendMessage()">
            Send
        </button>

    </div>

</div>

<script>

function sendMessage(){

    let msg =
        document.getElementById("message")
        .value.trim();

    if(msg === ""){
        return;
    }

    let chatArea =
        document.getElementById("chatArea");

    /* User Message */

    chatArea.innerHTML +=
        "<div class='user'>" + msg + "</div>";

    chatArea.scrollTop =
        chatArea.scrollHeight;

    /* Send to Servlet */

    fetch("../help", {

        method:"POST",

        headers:{
            "Content-Type":
            "application/x-www-form-urlencoded"
        },

        body:"message=" +
             encodeURIComponent(msg)

    })

    .then(response => response.text())

    .then(data => {

        chatArea.innerHTML +=
            "<div class='bot'>" +
            data +
            "</div>";

        chatArea.scrollTop =
            chatArea.scrollHeight;
    })

    .catch(() => {

        chatArea.innerHTML +=
            "<div class='bot'>⚠️ Sorry, something went wrong. Please try again.</div>";

        chatArea.scrollTop =
            chatArea.scrollHeight;
    });

    /* Clear Input */

    document.getElementById("message")
    .value = "";
}

/* Enter Key Support */

document.getElementById("message")
.addEventListener("keypress", function(event){

    if(event.key === "Enter"){
        sendMessage();
    }
});

</script>

</body>
</html>
