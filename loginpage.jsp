<%
response.setContentType("text/html");
if (session.getAttribute("name") != null) {
    out.println("<script>");
    out.println("alert('Already logged in!!!');");
    out.println("window.open('homePage.html', '_self');");
    out.println("</script>");
}
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="loginstyle.css">
    <!-- Include Font Awesome for icons (or use your own image paths) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .icon-container {
            position: fixed;
            top: 20px;
            left: 20px;
            display: flex; /* Use flexbox for horizontal layout */
            align-items: center; /* Align items vertically centered */
        }
        .icon-container a {
            display: block;
            margin-right: 10px; /* Space between icons */
            color: #000;
            text-decoration: none;
        }
        .icon-container i {
            font-size: 24px;
            background: #f2f2f2;
            border-radius: 50%;
            padding: 10px;
            transition: background 0.3s;
        }
        .icon-container i:hover {
            background: #ddd;
        }
        .center {
            text-align: center;
            margin-top: 50px;
        }
        .txt_field {
            margin: 10px 0;
        }
        .txt_field input {
            padding: 10px;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="icon-container">
        <a href="home.html" id="home-icon">
            <i class="fas fa-home"></i>
        </a>
        <a href="javascript:history.back()" id="back-icon">
            <i class="fas fa-arrow-left"></i>
        </a>
    </div>
    <div class="center">
        <img id="img1" src="logo.png" alt="Logo">
        <h1>Admin Login</h1>
        <form action="123.html" method="post">
            <div class="txt_field">
                <input type="text" name="uname" required>
                <span></span>
                <label>Username</label>
            </div>
            <div class="txt_field">
                <input type="password" name="pwd" required>
                <span></span>
                <label>Password</label>
            </div>
            <input type="submit" value="Login">
            <div class="signup_link">
                <!-- Optional signup link -->
            </div>
        </form>
    </div>
    <script>
        var status = document.getElementById("status").value;
        if (status == "failed") {
            alert("Sorry, Wrong Username or Password");
        }
        if (status == "success") {
            alert("Congrats, Logged in Successfully");
            window.open('123.html', "_self");
        }
    </script>
</body>
</html>
