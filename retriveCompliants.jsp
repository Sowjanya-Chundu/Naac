<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retrieve Student Complaint/Grievance</title>
    <!-- Include Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .top-left-icons {
            position: fixed;
            top: 10px;
            left: 10px;
        }
        .top-left-icons a {
            margin-right: 10px;
            color: #000;
            text-decoration: none;
        }
        .top-left-icons a:hover {
            color: #007BFF;
        }
        .form-container {
            width: 50%;
            margin: auto;
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group button {
            padding: 10px 15px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #286090;
        }
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
        .message {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="top-left-icons">
    <a href="AdminDisplayCompliants" title="Back"><i class="fas fa-arrow-left"></i></a>
    <a href="123.html" title="Home"><i class="fas fa-home"></i></a>
</div>

<div class="form-container">
    <h2>Retrieve Student Complaint/Grievance</h2>
    <form method="post">
        <div class="form-group">
            <label for="year">Year:</label>
            <input type="text" id="year" name="year" required>
        </div>
        <div class="form-group">
            <button type="submit">Retrieve</button>
        </div>
    </form>
</div>

<div class="message">
    <%
        // Check if form is submitted
        if (request.getMethod().equalsIgnoreCase("post")) {
            // Get form data
            String year = request.getParameter("year");
            
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
                
                // SQL query to retrieve data
                String query = "SELECT * FROM complaints WHERE year = ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, year);
                
                // Execute query
                rs = ps.executeQuery();
                
                // Check if any data is retrieved
                if (rs.next()) {
                    // Display retrieved data in table format
                    out.println("<table>");
                    out.println("<tr><th>Year</th><th>Number of Complaints/Grievances</th><th>Total Students Appeared</th><th>Percentage of Complaints</th></tr>");
                    do {
                        int complaints = rs.getInt("complaints");
                        int studentsAppeared = rs.getInt("students_appeared");
                        double percentage = (complaints * 100.0) / studentsAppeared;
                        
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("year") + "</td>");
                        out.println("<td>" + complaints + "</td>");
                        out.println("<td>" + studentsAppeared + "</td>");
                        out.println("<td>" + String.format("%.2f", percentage) + "%</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("No complaints/grievances found for the year " + year + ".");
                }
                
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
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
        }
    %>
</div>

</body>
</html>
