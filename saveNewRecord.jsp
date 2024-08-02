<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("Name");

    String designation = request.getParameter("Designation");
    String qualification = request.getParameter("Qualification");
    String experience = request.getParameter("Area of Specailzation");
    String email = request.getParameter("EXP");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load the database driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

        // Prepare an SQL statement to insert new record
        String sql = "INSERT INTO faculty (Name,  Designation, Qualification, Area of Secialization,EXP, ) VALUES (?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.setString(2, Name);
        stmt.setString(3, designation);
        stmt.setString(4, qualification);
        stmt.setString(5, experience);
        stmt.setString(6, email);

        int rowsInserted = stmt.executeUpdate();
        if (rowsInserted > 0) {
            response.getWriter().print("Record inserted successfully.");
        } else {
            response.getWriter().print("Failed to insert record.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().print("Error: " + e.getMessage());
    } finally {
        // Close resources
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
