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
    <script src="https://rawgit.com/eKoopmans/html2pdf/master/dist/html2pdf.bundle.js"></script>
</head>
<body>

<% 
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vvit", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.`2017studentdata`";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();

    // Display student details in a table
    out.println("<table id=\"dataTable\">"); // Add id attribute
    out.println("<thead><tr><th>Name</th><th>Category</th><th>Admission Type</th><th> FeeCategory </th><th>Gender</th></tr></thead>");
    out.println("<tbody>");
    while (result.next()) {
        String name = result.getString("FullName");
        String branch = result.getString("Category");
        String AdmissionType = result.getString("AdmissionType");
        String CATEGORYOFADMISSION = result.getString("FeeCategory");
        String gender = result.getString("Gender");

        out.println("<tr>");
        out.println("<td>" + name + "</td>");
        out.println("<td>" + branch + "</td>");
        out.println("<td>" + AdmissionType + "</td>");
        out.println("<td>" + CATEGORYOFADMISSION + "</td>");
        out.println("<td>" + gender + "</td>");
        out.println("</tr>");
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
