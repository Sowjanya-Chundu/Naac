<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admitted Student Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
    
<div id="content">
    <h2>Admitted Student Details</h2>
    <table id="studentTable">
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Programme Name</th>
                <th>Admission Date</th>
            </tr>
        </thead>
        <tbody>
        <% 
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // Get parameters from the request
                String programmeName = request.getParameter("programmeName");

                // Construct SQL query based on programmeName
                String sql = "SELECT * FROM " + programmeName + "_students";
                stmt = con.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String studentId = rs.getString("REGD NO");
                    String name = rs.getString("Name");
                    String admissionDate = rs.getString("CATEGORY OF ADMISSION");

                    // Display data in table rows
                    out.println("<tr>");
                    out.println("<td>" + studentId + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + programmeName + "</td>");
                    out.println("<td>" + admissionDate + "</td>");
                    out.println("</tr>");
                }

            } catch (SQLException | ClassNotFoundException e) {
                out.println("Exception: " + e.getMessage());
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
        %>
        </tbody>
    </table>
</div>

</body>
</html>
