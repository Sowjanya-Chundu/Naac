<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student Record</title>
    <style>
        /* Add your CSS styles here */
    </style>
</head>
<body>
    <h2>Delete Student Record</h2>
    <form action="" method="post">
        <label for="regNo">Registration Number:</label>
        <input type="text" id="regNo" name="regNo" required><br><br>
        
        <label for="programmeName">Programme Name:</label>
        <input type="text" id="programmeName" name="programmeName" required><br><br>
        
        <button type="submit">Delete</button>
    </form>

    <%-- Processing Logic --%>
    <%@ page import="java.sql.*" %>
    <% 
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String regNo = request.getParameter("regNo");
        String programmeName = request.getParameter("programmeName");

        if (regNo != null && !regNo.isEmpty() && programmeName != null && !programmeName.isEmpty()) {
            Connection con = null;
            PreparedStatement stmtDelete = null;
            PreparedStatement stmtUpdateCount = null;

            try {
                // Load JDBC driver and establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");
                con.setAutoCommit(false); // Start transaction

                // Delete record from programme's table
                String tableName = programmeName.replaceAll("\\s+", "").toLowerCase() + "_students";
                String deleteSql = "DELETE FROM `" + tableName + "` WHERE `REGD NO` = ?";
                stmtDelete = con.prepareStatement(deleteSql);
                stmtDelete.setString(1, regNo);
                int rowsAffected = stmtDelete.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Student record deleted successfully.</p>");

                    // Update count in studentadmitted table for the corresponding programme name
                    String updateCountSql = "UPDATE studentadmitted SET `Number of Students admitted` = `Number of Students admitted` - 1 WHERE `Programme Name` = ?";
                    stmtUpdateCount = con.prepareStatement(updateCountSql);
                    stmtUpdateCount.setString(1, programmeName);
                    int countUpdate = stmtUpdateCount.executeUpdate();

                    if (countUpdate > 0) {
                        // Commit transaction if both delete and update are successful
                        con.commit();
                        out.println("<p>Student count updated successfully.</p>");
                    } else {
                        // Rollback transaction if count update fails
                        con.rollback();
                        out.println("<p>Failed to update student count.</p>");
                    }
                } else {
                    out.println("<p>No record found for Registration Number: " + regNo + " under Programme Name: " + programmeName + "</p>");
                }

            } catch (SQLException | ClassNotFoundException e) {
                // Exception occurred
                out.println("<p>Exception: " + e.getMessage() + "</p>");
                e.printStackTrace();
                try {
                    if (con != null) {
                        con.rollback(); // Rollback transaction on exception
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            } finally {
                // Closing database resources and committing transaction
                try {
                    if (stmtDelete != null) stmtDelete.close();
                    if (stmtUpdateCount != null) stmtUpdateCount.close();
                    if (con != null) {
                        con.setAutoCommit(true); // Reset auto-commit mode
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>Please provide both Registration Number and Programme Name.</p>");
        }
    }
    %>
</body>
</html>
