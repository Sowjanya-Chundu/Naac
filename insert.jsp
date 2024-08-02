<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Student Data</title>
</head>
<body>
    <h1>Insert Student Data</h1>

    <%@ page import="java.sql.*" %>
    
    <form method="post" action="">
        RollNo: <input type="text" name="newRollNo"><br>
        Name: <input type="text" name="newName"><br>
        <!-- Add input fields for other student information here --> <br>
        <input type="submit" value="Insert">
    </form>

    <%
 
        if (request.getMethod().equals("POST")) {
            String newRollNo = request.getParameter("newRollNo");
            String newName = request.getParameter("newName");

            Connection connection = null;
            PreparedStatement ps = null;

            // Define your database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create a connection to the database
                connection = DriverManager.getConnection(jdbcUrl, username, password);

                // Define your SQL insert query
                String insertQuery = "INSERT INTO `2021-22student` (RollNo, Name) VALUES (?, ?)";

                // Create a prepared statement
                ps = connection.prepareStatement(insertQuery);

                // Set values for the parameters
                ps.setString(1, newRollNo);
                ps.setString(2, newName);

                // Execute the insert statement
                int rowsInserted = ps.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("Student data inserted successfully.");
                } else {
                    out.println("Failed to insert student data.");
                }

            } catch (SQLException e) {
                out.println("Database error: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("JDBC driver not found: " + e.getMessage());
            } finally {
                // Close the database resources in the reverse order of opening
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        out.println(e.getMessage());
                    }
                }
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        out.println(e.getMessage());
                    }
                }
            }
        }
    %>
</body>
</html>
