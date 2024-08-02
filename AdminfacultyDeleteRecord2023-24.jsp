<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
// Retrieve sno parameter from request
String sno = request.getParameter("sno");

// Database connection parameters (replace with your database details)
String url = "jdbc:mysql://localhost:3306/project";
String username = "root";
String password = "sowjanyapassword";

// Initialize connection, statement, and result set
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    // Connect to the database
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);

    // Prepare SQL statement to delete record by sno
    String sql = "DELETE FROM `2023-24faculty` WHERE `S.No` = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, sno);

    // Execute the deletion query
    int rowsAffected = stmt.executeUpdate();

    // Check if deletion was successful
    if (rowsAffected > 0) {
        out.println("Record deleted successfully."); // Output success message
    } else {
        out.println("Failed to delete record."); // Output failure message
    }
} catch (SQLException e) {
    out.println("SQL Error: " + e.getMessage()); // Output SQL error message
} catch (Exception e) {
    out.println("Error: " + e.getMessage()); // Output generic error message
} finally {
    // Close resources
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
%>
