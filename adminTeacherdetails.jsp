<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f8f8f8;
        }
        .options-container {
            position: absolute;
            top: 20px;
            left: 20px;
            display: flex;
            flex-direction: column;
        }
        .options-container a {
            display: block;
            margin-bottom: 10px;
            text-decoration: none;
            background-color: #337ab7;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .options-container a:hover {
            background-color: #286090;
        }
    </style>
</head>
<body>

    <div class="options-container">
        <a href="AdminTeacherInsert.jsp">Insert Teacher</a>
        <a href="AdminTeacherDelete.jsp">Delete Teacher</a>
        <a href="AdminTeacherRetrieve.jsp">Retrieve Teachers</a>
    </div>

    <h2>Full-Time Teachers Details</h2>
    <table>
        <thead>
            <tr>
                <th>Serial Number</th>
                <th>Name</th>
               
            </tr>
        </thead>
        <tbody>
            <%@ page import="java.sql.*" %>
            <% 
                // Define database connection details
                String jdbcUrl = "jdbc:mysql://localhost:3306/project";
                String username = "root";
                String password = "sowjanyapassword";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish the connection
                    conn = DriverManager.getConnection(jdbcUrl, username, password);
                    
                    // Construct SQL query to fetch all full-time teachers
                    String sql = "SELECT * FROM fulltimeteachers";
                    
                    // Execute the query
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    
                    // Counter for serial number
                    int serialNumber = 1;
                    
                    // Display the results in a table
                    while (rs.next()) {
                        String name = rs.getString("fulltimeteachers");
                     
                        out.println("<tr>");
                        out.println("<td>" + serialNumber + "</td>");
                        out.println("<td>" + name + "</td>");
                        
                        out.println("</tr>");
                        
                        // Increment serial number
                        serialNumber++;
                    }

                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    // Close resources in the finally block
                    try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                }
            %>
        </tbody>
    </table>

</body>
</html>
