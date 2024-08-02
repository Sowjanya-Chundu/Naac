<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Information</title>
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
            padding-top: 50px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .hamburger-menu {
            position: fixed;
            top: 20px;
            left: 20px;
            cursor: pointer;
            z-index: 1000;
        }
        .hamburger-menu div {
            width: 35px;
            height: 5px;
            background-color: #333;
            margin: 6px 0;
        }
        .options {
            display: none;
            position: fixed;
            top: 60px;
            left: 20px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 10px;
            border-radius: 5px;
        }
        .options a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            transition: background-color 0.3s ease;
        }
        .options a:hover {
            background-color: #f2f2f2;
        }
    </style>
    <script>
        function toggleOptions() {
            var optionsDiv = document.getElementById("optionsDiv");
            if (optionsDiv.style.display === "block") {
                optionsDiv.style.display = "none";
            } else {
                optionsDiv.style.display = "block";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Student Information</h1>
        
        <% 
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish a connection to the database
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");
                
                // SQL query to retrieve student information
                String sql = "SELECT * FROM studentsdata";
                
                // Prepare the SQL statement
                stmt = con.prepareStatement(sql);
                
                // Execute the query
                rs = stmt.executeQuery();
                
                // Display student information in a table
                out.println("<table>");
                out.println("<tr><th>Serial Number</th><th>Name</th><th>Enrollment Year</th><th>Roll No</th></tr>");
                
                int serialNumber = 1;
                while (rs.next()) {
                    String name = rs.getString("Name");
                    int enrollmentYear = rs.getInt("enrollmentyear");
                    String rollNo = rs.getString("rollno");
                    
                    out.println("<tr>");
                    out.println("<td>" + serialNumber + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + enrollmentYear + "</td>");
                    out.println("<td>" + rollNo + "</td>");
                    out.println("</tr>");
                    
                    serialNumber++;
                }
                out.println("</table>");
                
            } catch (SQLException e) {
                out.println("SQL Exception: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                out.println("Exception: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close the resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        
        <!-- Hamburger Menu -->
        <div class="hamburger-menu" onclick="toggleOptions()">
            <div></div>
            <div></div>
            <div></div>
        </div>
        
        <!-- Options for Insert, Delete, Retrieve -->
        <div class="options" id="optionsDiv">
            <a href="AdminStudentInsert.jsp">Insert</a>
            <a href="AdminStudentDelete.jsp">Delete</a>
            <a href="AdminStudentRetrieve.jsp">Retrieve</a>
        </div>
        
    </div>
</body>
</html>
