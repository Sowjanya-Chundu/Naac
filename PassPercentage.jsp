<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Data from Database</title>
    <style>
        table {
            width: 80%;
            margin: auto;
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
        .footer {
            position: fixed;
            bottom: 10px;
            left: 10px;
        }
    </style>
</head>
<body>
    <h2>Data from Database</h2>

    <table>
        <tr>
            <th>Academic Year</th>
            <th>Program Code</th>
            <th>Program Name</th>
            <th>No. of Students appeared in final examination</th>
            <th>No. of Students passed in final examination</th>
        </tr>
        <%
            // Define database connection parameters
            String url = "jdbc:mysql://localhost:3306/project";
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
                String query = "SELECT * FROM passpercentageofstudents";
                ps = conn.prepareStatement(query);
                
                // Execute query
                rs = ps.executeQuery();
                
                // Process each row of ResultSet
                while (rs.next()) {
                    String academic = rs.getString("Academic");
                    String programCode = rs.getString("Programme Code");
                    String programName = rs.getString("Programme Name");
                    String appeared = rs.getString("Number of students who appeared in the final year examinations");
                    String passed = rs.getString("Number of students who passed in the final year examinations");
                    
                    // Display each row of data in table format
                    out.println("<tr>");
                    out.println("<td>" + academic + "</td>");
                    out.println("<td>" + programCode + "</td>");
                    out.println("<td>" + programName + "</td>");
                    out.println("<td>" + appeared + "</td>");
                    out.println("<td>" + passed + "</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
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

    <div class="footer">
        <a href="sublist6.html">Back</a> | 
        <a href="home.html">Home</a>
    </div>
</body>
</html>
