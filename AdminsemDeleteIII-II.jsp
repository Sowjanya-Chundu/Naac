<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        p {
            font-size: 16px;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/project";
    String username = "root";
    String password = "sowjanyapassword";
    Connection conn = null;
    PreparedStatement ps = null;

    String code = request.getParameter("code");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        String deleteQuery = "DELETE FROM semesteryear WHERE programmecode=?";
        ps = conn.prepareStatement(deleteQuery);
        ps.setString(1, code);

        int rowsDeleted = ps.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("<p>Record with Program Code " + code + " deleted successfully.</p>");
        } else {
            out.println("<p>No record found with the given Program Code: " + code + "</p>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Redirect back to the main page or display a success message
    response.setHeader("Refresh", "3; URL=AdminfacultyMainPage2023-24.jsp"); // Adjust the redirect URL as necessary
%>
</body>
</html>
