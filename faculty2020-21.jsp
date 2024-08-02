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
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

    // Create and execute SQL query
    String sql = "SELECT * FROM project.`2020-21faculty`";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet result = st.executeQuery();
    int professorCount = 0;
    int assistantProfessorCount = 0;
    int phdCount=0;
    int mtechCount=0;
    // Display student details in a table
    out.println("<table id=\"dataTable\">"); // Add id attribute
    out.println("<thead><tr><th>S .No</th><th>Name</th><th>Qualification</th><th>Area Of Specialization</th><th>Designation</th></tr></thead>");
    out.println("<tbody>");
    while (result.next()) {
    	int sno=result.getInt("S.No");
        String Name = result.getString("Name");
        String Qualification = result.getString("Qualification");
        String AreaofSpecialization = result.getString("Area of Specialization");
        String Designation = result.getString("Designation");
        if (Designation.equalsIgnoreCase("Professor")) {
            professorCount++;
        } else{
            assistantProfessorCount++;
        }
        if (Qualification.equalsIgnoreCase("Ph.D")) {
            phdCount++;
        } else{
            mtechCount++;
        }


        out.println("<tr>");
        out.println("<td>"+sno+"</td>");
        out.println("<td>" + Name+ "</td>");
        out.println("<td>" + Qualification + "</td>");
        out.println("<td>" + AreaofSpecialization+ "</td>");
        out.println("<td>" + Designation + "</td>");
        out.println("</tr>");
    }
    out.println("</tbody>");
    out.println("</table>");

    
    
    out.println("<p>Total Professors: " + professorCount + "</p>");
    out.println("<p>Total Assistant Professors: " + assistantProfessorCount + "</p>");
    
    out.println("<p>Total Ph.D.: " + phdCount + "</p>");
    out.println("<p>Total M.Tech: " + mtechCount + "</p>");
    
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
