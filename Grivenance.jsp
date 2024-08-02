<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Complaints/Grievances about Evaluation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        table {
            width: 50%;
            margin: auto;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .options {
            text-align: center;
            margin-top: 20px;
        }
        .options a {
            margin: 0 10px;
            text-decoration: none;
            color: #000;
            padding: 5px 10px;
            border: 1px solid black;
            border-radius: 5px;
            background-color: #f2f2f2;
        }
        .options a:hover {
            background-color: #ddd;
        }
        .footer {
            position: fixed;
            bottom: 10px;
            left: 10px;
        }
    </style>
</head>
<body>
<h2>Student Complaints/Grievances about Evaluation</h2>

<div class="top-left">
        <button class="icon-button" onclick="goBack()">
            <i class="fas fa-arrow-left"></i>
        </button>
        <button class="icon-button" onclick="goHome()">
            <i class="fas fa-home"></i>
        </button>
    </div>

<table>
    <tr>
        <th>Year</th>
        <th>Number of Complaints/Grievances</th>
        <th>Total Students Appeared</th>
        <th>Percentage of Complaints</th>
    </tr>
    <% 
        // Define database connection parameters
        String url = "jdbc:mysql://localhost:3306/database";
        String username = "root";
        String password = "sowjanyapassword";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection
            conn = DriverManager.getConnection(url, username, password);
            
            // SQL query to fetch data
            String query = "SELECT * FROM complaints";
            ps = conn.prepareStatement(query);
            
            // Execute query
            rs = ps.executeQuery();
            
            // Initialize variables for average calculation
            int totalComplaints = 0;
            int totalAppeared = 0;
            int yearsCounted = 0;
            
            // Process each row of ResultSet
            while (rs.next()) {
                String year = rs.getString("year");
                int complaints = rs.getInt("complaints");
                int appeared = rs.getInt("students_appeared");
                
                // Calculate percentage of complaints
                double percentage = (complaints * 100.0) / appeared;
                
                // Display each row of data in table format
                out.println("<tr>");
                out.println("<td>" + year + "</td>");
                out.println("<td>" + complaints + "</td>");
                out.println("<td>" + appeared + "</td>");
                out.println("<td>" + String.format("%.2f", percentage) + "%</td>");
                out.println("</tr>");
                
                // Accumulate totals for average calculation
                totalComplaints += complaints;
                totalAppeared += appeared;
                yearsCounted++;
            }
            
            // Calculate average percentage of complaints
            if (yearsCounted > 0) {
                double averagePercentage = (totalComplaints * 100.0) / totalAppeared;
                out.println("<tr>");
                out.println("<td colspan='3'><b>Average Percentage of Complaints/Grievances</b></td>");
                out.println("<td><b>" + String.format("%.2f", averagePercentage) + "%</b></td>");
                out.println("</tr>");
            }
            
        } catch (Exception e) {
            out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
            e.printStackTrace();
        } finally {
            // Close resources in finally block
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</table>
<script>
  function goBack() {
        window.history.back();
    }

    function goHome() {
        window.location.href = 'home.html'; // Change 'home.jsp' to your home page URL
    }
    </script>

</body>
</html>
