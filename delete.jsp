<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student Record</title>
</head>
<body>
    <h1>Delete Student Record</h1>
    
    <%@ page import="java.sql.*" %>
    
    <c:if test="${not empty deletionMessage}">
        <p>${deletionMessage}</p>
    </c:if>
    
    <form action="" method="post">
        Enter Roll Number: <input type="text" name="rollno">
        <input type="submit" value="Delete">
    </form>
    
    <%
        String rollnoToDelete = request.getParameter("rollno");

        if (rollnoToDelete != null && !rollnoToDelete.isEmpty()) {
            String jdbcUrl = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
    
                Connection con = DriverManager.getConnection(jdbcUrl, username, password);
    
                String deleteSQL = "DELETE FROM `2021-22student` WHERE RollNo=?";
    
                PreparedStatement ps = con.prepareStatement(deleteSQL);
                ps.setInt(1, Integer.parseInt(rollnoToDelete));
                int rowsDeleted = ps.executeUpdate();
                
                if (rowsDeleted > 0) {
                    request.setAttribute("deletionMessage", "Record with Roll Number " + rollnoToDelete + " deleted successfully.");
                } else {
                    request.setAttribute("deletionMessage", "Record with Roll Number " + rollnoToDelete + " not found or deletion failed.");
                }
                
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("deletionMessage", "Error occurred during deletion.");
            }
        }
    %>
</body>
</html>
