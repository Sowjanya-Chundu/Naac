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
    <title>Add Record</title>
    <style>
        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
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

    String program = request.getParameter("program");
    String code = request.getParameter("code");
    String semYear = request.getParameter("semyear");
    String lastEndYear = request.getParameter("lastendyear");
    String resultsOfSemester = request.getParameter("resultsofsemester");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        String insertQuery = "INSERT INTO semesteryear (programmename, programmecode, `Semester/Year`, lastsemesterendyear, resultsofthesemester) VALUES (?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(insertQuery);
        ps.setString(1, program);
        ps.setString(2, code);
        ps.setString(3, semYear);
        ps.setString(4, lastEndYear);
        ps.setString(5, resultsOfSemester);

        int rowsInserted = ps.executeUpdate();
        if (rowsInserted > 0) {
            out.println("Record added successfully.");
        } else {
            out.println("Failed to add record.");
        }

        // Retrieve all records from the database
        String selectQuery = "SELECT * FROM semesteryear";
        ps = conn.prepareStatement(selectQuery);
        ResultSet rs = ps.executeQuery();

        out.println("<h2>All Records:</h2>");
        out.println("<table>");
        out.println("<tr>");
        out.println("<th>Program Name</th>");
        out.println("<th>Program Code</th>");
        out.println("<th>Semester/Year</th>");
        out.println("<th>Last Semester End Year</th>");
        out.println("<th>Results of the Semester</th>");
        out.println("</tr>");

        while (rs.next()) {
            String retrievedProgram = rs.getString("programmename");
            String retrievedCode = rs.getString("programmecode");
            String retrievedSemYear = rs.getString("Semester/Year");
            String retrievedLastEndYear = rs.getString("lastsemesterendyear");
            String retrievedResults = rs.getString("resultsofthesemester");

            out.println("<tr>");
            out.println("<td>" + retrievedProgram + "</td>");
            out.println("<td>" + retrievedCode + "</td>");
            out.println("<td>" + retrievedSemYear + "</td>");
            out.println("<td>" + retrievedLastEndYear + "</td>");
            out.println("<td>" + retrievedResults + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");

        rs.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
