<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
   
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
            margin-bottom: 50px;
        }
        th, td {
            border: 1px solid #000;
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
        .nav-btn {
            position: fixed;
            bottom: 10px;
            right: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
</head>
<body>

<% 
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.councel3rdbtech;";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();
   
    // Display student details in a table
    out.println("<table id=\"dataTable\">"); // Add id attribute
    out.println("<thead><tr><th>S.No</th><th>2 nd Btech</th><th>Name of the Couneller</th><th>Mobile No</th></thead>");
    out.println("<tbody>");
    while (result.next()) {
        try {
            int sno = result.getInt("S.No");
            String regdno = result.getString("IIIB.TECH");
            String studentname = result.getString("Name of the Counselor");
            String mobileno = result.getString("Counselor Mobile Number");
            out.println("<tr>");
            out.println("<td>" + sno + "</td>");
            out.println("<td>" + regdno + "</td>");
            out.println("<td>" + studentname + "</td>");
            out.println("<td>" + mobileno + "</td>");
            out.println("</tr>");
        } catch (SQLException e) {
            // Log or print the details of the problematic row
            System.out.println("Error processing row: " + e.getMessage());
          
        }
    }
    out.println("</tbody>");
    out.println("</table>");

    // Download button
    out.println("<button class=\"download-btn\" onclick=\"downloadData();\">Download Data</button>");

    // Navigation buttons
  
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
        var opt = {
            margin:       1,
            filename:     '3 nd btech councelling list.pdf',
            image:        { type: 'jpeg', quality: 0.98 },
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
        };
        html2pdf().set(opt).from(element).save();
    }
</script>

</body>
</html>
