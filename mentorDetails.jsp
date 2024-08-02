<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teachers Details</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Teachers Details</h1>
    <%
        String departmentName = request.getParameter("deptName");
        if (departmentName != null && !departmentName.isEmpty()) {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // SQL query to get teachers details for the selected department
                String sql = "SELECT * FROM project.fulltimeteachers WHERE `Name of the Department` = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, departmentName);

                // Execute query
                rs = pstmt.executeQuery();

                // Process the results
                out.println("<h2>Teachers List for " + departmentName + "</h2>");
                out.println("<table>");
                out.println("<tr><th>Teacher Name</th><th>Designation</th></tr>");
                while (rs.next()) {
                    String teacherId = rs.getString("PAN"); // Make sure the column name is correct
                    String teacherName = rs.getString("fulltimeteachers"); // Make sure the column name is correct
                    String designation = rs.getString("Designation"); // Make sure the column name is correct

                    // Create URL for teacher details page
                    String teacherURL = "teacherDetails.jsp?teacherId=" + teacherId;
                    String teacherLink = "<a href='" + teacherURL + "'>" + teacherName + "</a>";

                    // Print table row with teacher details
                    out.println("<tr>");
                    out.println("<td>" + teacherLink + "</td>");
                    out.println("<td>" + designation + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");

            } catch (SQLException | ClassNotFoundException e) {
                out.println("An error occurred: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources in reverse order of creation
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>No department selected.</p>");
        }
    %>
</body>
</html>
