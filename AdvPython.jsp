<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Branch</title>
    <style>
        body {
            background-color: white;
            margin: 0;
            padding: 0;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 50px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .download-btn {
            position: fixed;
            bottom: 10px;
            left: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    <!-- Use a CDN for html2pdf.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
</head>
<body>

<% 
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.`AdvPython21bq`";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();
   
    // Display student details in a table
    out.println("<table id=\"dataTable\">"); // Add id attribute
    out.println("<thead><tr><th>BatchNo</th><th>Regd.No</th><th>Student Name</th></tr></thead>");
    out.println("<tbody>");
    while (result.next()) {
        try {
            int sno = result.getInt("S. No");
            String regdno = result.getString("Regd. No.");
            String studentname = result.getString("Name Of The Student");
           
            out.println("<tr>");
            out.println("<td>" + sno + "</td>");
            out.println("<td>" + regdno + "</td>");
            out.println("<td>" + studentname + "</td>");
        
            out.println("</tr>");
        } catch (SQLException e) {
            // Log or print the details of the problematic row
            System.out.println("Error processing row: " + e.getMessage());
            System.out.println("Batch No: " + result.getString("Batch No"));
            // Print other column values similarly
        }
    }
    out.println("</tbody>");
    out.println("</table>");

    // Download button
    out.println("<button class=\"download-btn\" onclick=\"downloadData();\">Download Data</button>");

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

<script>
    function downloadData() {
        var element = document.getElementById('dataTable');
        html2pdf(element);
    }
</script>

</body>
</html>
