<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/project";
    String user = "root";
    String password = "sowjanyapassword";

    // JDBC variables for opening, closing, and managing connection
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    // Variable to track if the insertion was successful
    boolean insertionSuccess = false;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        connection = DriverManager.getConnection(url, user, password);

        // Disable autocommit to allow transaction handling
        connection.setAutoCommit(false);

        // Your SQL query
        String sql = "INSERT INTO project.`2019-20faculty` (Name, Designation, 'Date of Joining') VALUES (?, ?, ?)";

        // Create a PreparedStatement with the SQL query
        preparedStatement = connection.prepareStatement(sql);

        // Set the values for the PreparedStatement parameters

        preparedStatement.setString(1, request.getParameter("Name"));
        preparedStatement.setString(2, request.getParameter("Designation"));
        preparedStatement.setString(3, request.getParameter("Date of Joining"));
       

        // Execute the query
        int rowsAffected = preparedStatement.executeUpdate();

        // If at least one row is affected, consider it a success
        insertionSuccess = rowsAffected > 0;

        // Commit the transaction
        connection.commit();

    } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions
        e.printStackTrace();
        // Rollback the transaction in case of an exception
        if (connection != null) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    } finally {
        // Close the resources in a finally block to ensure they are closed even if an exception occurs
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                // Reset autocommit to true before closing the connection
                connection.setAutoCommit(true);
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Insertion Result</title>
</head>
<body>

<%
    // Display a message based on the success of the insertion
    if (insertionSuccess) {
%>
        <h2>Data inserted successfully!</h2>
<%
    } else {
%>
        <h2>Data insertion failed. Please try again.</h2>
<%
    }
%>

</body>
</html>
