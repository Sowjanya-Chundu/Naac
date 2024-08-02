<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.fulltimeteachers;";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();
   
    // Display student details in a table
    out.println("<table id=\"dataTable\">"); // Add id attribute
    out.println("<thead><tr><th>S.No</th><th>2 nd Btech</th><th>Name of the Couneller</th></tr><th>Mobile No</th></thead>");
    out.println("<tbody>");
    while (result.next()) {
        try {
            int sno = result.getInt("S.No");
            String regdno = result.getString("fulltimeteachers");
            String studentname = result.getString("Designation");
            String mobileno = result.getString("aganistsanctioned");
            out.println("<tr>");
            out.println("<td>" + sno + "</td>");
            out.println("<td>" + regdno + "</td>");
            out.println("<td>" + studentname + "</td>");
            out.println("<td>" + mobileno + "</td>");
            
        
            out.println("</tr>");
        } catch (SQLException e) {
            // Log or print the details of the problematic row
            System.out.println("Error processing row: " + e.getMessage());
           // System.out.println("Batch No: " + result.getString("Batch No"));
            // Print other column values similarly
        }
    }
    out.println("</tbody>");
    out.println("</table>");

    // Download button
    //out.println("<button class=\"download-btn\" onclick=\"downloadData();\">Download Data</button>");

    // Close resources
    result.close();
    st.close();
    con.close();
} catch (SQLException e) {
    out.println("SQL Exception: " + e.getMessage());
    e.printStackTrace();
} catch (Exception e) {
    out.println("Exception: " + e);
}
%>

</body>
</html>