<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message-box {
            text-align: center;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        .message-box h1 {
            color: #007bff;
        }
        .message-box p {
            color: #333;
        }
        .message-box a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .message-box a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <%
            // Invalidate the session if it exists
            if (request.getSession(false) != null) {
            request.getSession().invalidate();
        }
        %>
        <h1>Thanks for logging in!</h1>
        <p>You have been successfully logged out.</p>
        <a href="logs.html">Login again</a>
    </div>
</body>
</html>