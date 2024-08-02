<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #4CAF50;
        }
        p {
            font-size: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/project";
    String username = "root";
    String password = "sowjanyapassword";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String code = request.getParameter("code");
    String program = request.getParameter("program");
    String semYear = request.getParameter("semyear");
    String lastEndYear = request.getParameter("lastendyear");
    String resultsOfSemester = request.getParameter("resultsofsemester");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        String updateQuery = "UPDATE semesteryear SET programmename=?, `Semester/Year`=?, lastsemesterendyear=?, resultsofthesemester=? WHERE programmecode=?";
        ps = conn.prepareStatement(updateQuery);
        ps.setString(1, program);
        ps.setString(2, semYear);
        ps.setString(3, lastEndYear);
        ps.setString(4, resultsOfSemester);
        ps.setString(5, code);

        int rowsUpdated = ps.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<p>Record updated successfully.</p>");

            // Retrieve all data
            String selectQuery = "SELECT * FROM semesteryear";
            ps = conn.prepareStatement(selectQuery);
            rs = ps.executeQuery();
%>
            <h2>All Records:</h2>
            <table>
                <tr>
                    <th>Program Code</th>
                    <th>Program Name</th>
                    <th>Semester/Year</th>
                    <th>Last Semester End Year</th>
                    <th>Results of the Semester</th>
                </tr>
<%
            while (rs.next()) {
                String retrievedCode = rs.getString("programmecode");
                String retrievedProgram = rs.getString("programmename");
                String retrievedSemYear = rs.getString("Semester/Year");
                String retrievedLastEndYear = rs.getString("lastsemesterendyear");
                String retrievedResults = rs.getString("resultsofthesemester");
%>
                <tr>
                    <td><%= retrievedCode %></td>
                    <td><%= retrievedProgram %></td>
                    <td><%= retrievedSemYear %></td>
                    <td><%= retrievedLastEndYear %></td>
                    <td><%= retrievedResults %></td>
                </tr>
<%
            }
%>
            </table>
<%
        } else {
            out.println("<p>No record found with the given Program Code.</p>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Redirect back to the main page or display a success message
    response.setHeader("Refresh", "5; URL=AdminfacultyMainPage2023-24.jsp"); // Adjust the redirect URL as necessary
%>
</body>
</html>
