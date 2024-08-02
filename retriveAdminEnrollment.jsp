<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retrieve Student Information</title>
    <style>
        /* Add your CSS styles here */
    </style>
</head>
<body>
    <h2>Retrieve Student Information</h2>

    <form action="" method="post">
        <label for="regNo">Registration Number:</label>
        <input type="text" id="regNo" name="regNo" required><br><br>
        
        <label for="programmeName">Programme Name:</label>
        <input type="text" id="programmeName" name="programmeName" required><br><br>
        
        <button type="submit">Search</button>
    </form>

    <%-- Processing Logic --%>
    <%@ page import="java.sql.*" %>
    <% 
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String regNo = request.getParameter("regNo");
        String programmeName = request.getParameter("programmeName");

        if (regNo != null && !regNo.isEmpty() && programmeName != null && !programmeName.isEmpty()) {
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Load JDBC driver and establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // Query to retrieve student information based on regNo and programmeName
                String tableName = programmeName.replaceAll("\\s+", "").toLowerCase() + "_students";
                String query = "SELECT `REGD NO`, `Name`, `Branch`, `CATEGORY OF ADMISSION` FROM `" + tableName + "` WHERE `REGD NO` = ? AND `Branch` = ?";
                stmt = con.prepareStatement(query); 
                stmt.setString(1, regNo);
                stmt.setString(2, programmeName);
                rs = stmt.executeQuery();

                // Display retrieved data
                if (rs.next()) {
    %>
    <h3>Student Information</h3>
    <p><strong>Registration Number:</strong> <%= rs.getString("REGD NO") %></p>
    <p><strong>Student Name:</strong> <%= rs.getString("Name") %></p>
    <p><strong>Programme Name:</strong> <%= rs.getString("Branch") %></p>
    <p><strong>Category of Admission:</strong> <%= rs.getString("CATEGORY OF ADMISSION") %></p>
    <% 
                } else {
                    out.println("<p>No student found with Registration Number: " + regNo + " under Programme Name: " + programmeName + "</p>");
                }

            } catch (SQLException | ClassNotFoundException e) {
                // Exception occurred
                out.println("<p>Exception: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Closing database resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>Please provide both Registration Number and Programme Name.</p>");
        }
    }
    %>

</body>
</html>
