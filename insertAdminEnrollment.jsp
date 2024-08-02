<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Student Data</title>
    <style>
        /* Add your CSS styles here */
    </style>
    <script>
        function validateForm() {
            let regNo = document.getElementById("regNo").value;
            let studentName = document.getElementById("studentName").value;
            let programmeName = document.getElementById("programmeName").value;
            let category = document.getElementById("category").value;

            if (regNo === "" || studentName === "" || programmeName === "" || category === "") {
                alert("All fields must be filled out");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h2>Insert Student Data</h2>
    <form action="" method="post" onsubmit="return validateForm()">
        <label for="regNo">Registration Number:</label>
        <input type="text" id="regNo" name="regNo" required><br><br>
        
        <label for="studentName">Student Name:</label>
        <input type="text" id="studentName" name="studentName" required><br><br>
        
        <label for="programmeName">Programme Name:</label>
        <input type="text" id="programmeName" name="programmeName" required><br><br>
        
        <label for="category">Category of Admission:</label>
        <input type="text" id="category" name="category" required><br><br>
        
        <button type="submit">Insert</button>
    </form>

    <%-- Processing Logic --%>
    <%@ page import="java.sql.*" %>
    <% 
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String regNo = request.getParameter("regNo");
        String studentName = request.getParameter("studentName");
        String programmeName = request.getParameter("programmeName");
        String category = request.getParameter("category");

        // Debugging output to check parameter values
        out.println("<p>Debug - Received Parameters:</p>");
        out.println("<p>regNo: " + regNo + "</p>");
        out.println("<p>studentName: " + studentName + "</p>");
        out.println("<p>programmeName: " + programmeName + "</p>");
        out.println("<p>category: " + category + "</p>");

        if (regNo != null && !regNo.isEmpty() && 
            studentName != null && !studentName.isEmpty() && 
            programmeName != null && !programmeName.isEmpty() && 
            category != null && !category.isEmpty()) {
            
            Connection con = null;
            PreparedStatement stmtInsert = null;
            PreparedStatement stmtUpdateCount = null;

            try {
                // Load JDBC driver and establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");
                con.setAutoCommit(false); // Start transaction
                
                // Insert student data into the appropriate table (assuming table exists)
                String tableName = programmeName.replaceAll("\\s+", "").toLowerCase() + "_students";
                String insertSql = "INSERT INTO `" + tableName + "` (`REGD NO`, `Name`, `Branch`, `CATEGORY OF ADMISSION`) VALUES (?, ?, ?, ?)";
                stmtInsert = con.prepareStatement(insertSql);
                stmtInsert.setString(1, regNo);
                stmtInsert.setString(2, studentName);
                stmtInsert.setString(3, programmeName);
                stmtInsert.setString(4, category);
                int rowsAffected = stmtInsert.executeUpdate();

                if (rowsAffected > 0) {
                    // Data inserted successfully
                    out.println("<p>Data inserted successfully.</p>");

                    // Update count in studentadmitted table for the corresponding programme name
                    String updateCountSql = "UPDATE studentadmitted SET `Number of Students admitted` = `Number of Students admitted` + 1 WHERE `Programme Name` = ?";
                    stmtUpdateCount = con.prepareStatement(updateCountSql);
                    stmtUpdateCount.setString(1, programmeName);
                    int countUpdate = stmtUpdateCount.executeUpdate();

                    if (countUpdate > 0) {
                        // Commit transaction if both inserts and updates are successful
                        con.commit();
                        out.println("<p>Student count updated successfully.</p>");
                    } else {
                        // Rollback transaction if count update fails
                        con.rollback();
                        out.println("<p>Failed to update student count.</p>");
                    }
                } else {
                    // No rows affected (likely failed to insert)
                    out.println("<p>Failed to insert data.</p>");
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
                    if (stmtInsert != null) stmtInsert.close();
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
            // Missing required parameters
            out.println("<p>Missing required parameters.</p>");
        }
    }
    %>
</body>
</html>
