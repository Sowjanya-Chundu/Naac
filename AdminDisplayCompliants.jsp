<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #f2f2f2;
            border-bottom: 1px solid #ddd;
        }
        .header .nav-icons {
            display: flex;
            gap: 10px;
        }
        .header .nav-icons a {
            text-decoration: none;
            color: #000;
            padding: 5px 10px;
            border: 1px solid black;
            border-radius: 5px;
            background-color: #f2f2f2;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .header .nav-icons a:hover {
            background-color: #ddd;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
            flex-grow: 1;
        }
        table {
            width: 50%;
            margin: 20px auto;
            border-collapse: collapse;
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
        
    </style>
</head>
<body>
<div class="header">
    <div class="nav-icons">
        <a href="AdminDisplayComplianta.jsp"><i class="fas fa-arrow-left"></i> Back</a>
        <a href="123.html"><i class="fas fa-home"></i> Home</a>
    </div>
    <h2>Student Complaints/Grievances about Evaluation</h2>
</div>

<div class="options">
    <a href="insertCompliants.jsp">Insert</a>
    <a href="deleteCompliants.jsp">Delete</a>
    <a href="retriveCompliants.jsp">Retrieve</a>
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

</body>
</html>
