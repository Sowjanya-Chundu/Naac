<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve selected values
    String academicYear = request.getParameter("academicYear");
    String branch = request.getParameter("branch");
    String semester = request.getParameter("semester");

    // Modify these variables with your actual database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306//project";
    String jdbcUser = "root";
    String jdbcPassword = "sowjanyapassword";

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Create a statement
        Statement statement = connection.createStatement();

        // Your SQL query to retrieve data based on the selected values
        String query = "SELECT * FROM 2021-22student WHERE academic_year = '" + academicYear + "' AND branch = '" + branch + "' AND semester = '" + semester + "'";
        ResultSet resultSet = statement.executeQuery(query);

        // Process the result set and display data
        out.println("<h3>Data retrieved for Academic Year: " + academicYear + ", Branch: " + branch + ", Semester: " + semester + "</h3>");

        out.println("<table border='1'>");
        out.println("<tr><th>Column1</th><th>Column2</th></tr>");

        while (resultSet.next()) {
            out.println("<tr>");
            out.println("<td>" + resultSet.getString("Name") + "</td>");
            out.println("<td>" + resultSet.getString("Admission Type") + "</td>");
            // Add more columns as needed
            out.println("</tr>");
        }

        out.println("</table>");

        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
