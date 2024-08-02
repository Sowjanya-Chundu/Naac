<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<head>
<meta charset="UTF-8">
<title>Student Admission Details</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js library -->
<style>
    #dataContainer {
        max-width: 800px;
        margin: 20px auto;
        text-align: center;
    }
    #dataTable {
        width: 100%;
        margin-bottom: 20px;
        border-collapse: collapse;
    }
    #dataTable th, #dataTable td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    #myChart {
        max-width: 600px;
        margin: 0 auto;
    }
</style>
</head>
<body>
<div id="dataContainer">
    <h2>Student Admission Details</h2>
    <table id="dataTable">
        <thead>
            <tr>
                <th>Serial Number</th>
                <th>Programme Name</th>
                <th>Programme Code</th>
                <th>Number of Seats Sanctioned</th>
                <th>Number of Students Admitted</th>
                <th>Academic Year</th>
            </tr>
        </thead>
        <tbody>
        <% 
           

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // Create and execute SQL query
                String sql = "SELECT * FROM project.fulltime";
                PreparedStatement st = con.prepareStatement(sql);
                ResultSet result = st.executeQuery();

                int serialNumber = 1;

                while (result.next()) {
                    String name = result.getString("fulltimeteachers");
                    String branch = result.getString("qualification");
                    String admissionType = result.getString("researchguideforphd");
                    int admission = result.getInt("yearofresearch");
                    String categoryOfAdmission = result.getString("stillworkingornot");

                   
                    // Display data in table rows
                    out.println("<tr>");
                    out.println("<td>" + serialNumber + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + branch + "</td>");
                    out.println("<td>" + admissionType + "</td>");
                    out.println("<td>" + admission + "</td>");
                    out.println("<td>" + categoryOfAdmission + "</td>");
                    out.println("</tr>");

                    serialNumber++;
                }

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
        </tbody>
    </table>

   

</div>



</body>
</html>
