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
    <title>Retrieve Semester Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            width: 80%;
            margin: auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 0.9em;
        }
        .form-group input[type="text"],
        .form-group select {
            width: 100%;
            padding: 8px;
            font-size: 0.9em;
            box-sizing: border-box;
        }
        .form-group button {
            padding: 8px 12px;
            font-size: 0.9em;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #286090;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .error-message {
            color: #d9534f;
            font-size: 0.9em;
            margin-top: 5px;
        }
         .footer {
            position: fixed;
            bottom: 10px;
            left: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Retrieve Semester Records</h2>
    <form method="post">
        <div class="form-group">
            <label for="programName">Program Name:</label>
            <input type="text" id="programName" name="programName">
        </div>
        <div class="form-group">
            <label for="semesterYear">Semester/Year:</label>
            <input type="text" id="semesterYear" name="semesterYear">
        </div>
        <div class="form-group">
            <button type="submit">Retrieve Records</button>
        </div>
    </form>

    <%-- Retrieve Logic --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String url = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                String programName = request.getParameter("programName");
                String semesterYear = request.getParameter("semesterYear");

                String query = "SELECT programmename, programmecode, `Semester/Year`, lastsemesterendyear, resultsofthesemester FROM semesteryear WHERE 1=1";

                if (programName != null && !programName.isEmpty()) {
                    query += " AND programmename LIKE ?";
                }
                if (semesterYear != null && !semesterYear.isEmpty()) {
                    query += " AND `Semester/Year` LIKE ?";
                }

                ps = conn.prepareStatement(query);

                int paramIndex = 1;
                if (programName != null && !programName.isEmpty()) {
                    ps.setString(paramIndex++, "%" + programName + "%");
                }
                if (semesterYear != null && !semesterYear.isEmpty()) {
                    ps.setString(paramIndex++, "%" + semesterYear + "%");
                }

                rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p class='error-message'>No records found.</p>");
                } else {
    %>
                    <table>
                        <tr>
                            <th>Program Name</th>
                            <th>Program Code</th>
                            <th>Semester/Year</th>
                            <th>Last Semester End Year</th>
                            <th>Results of the Semester</th>
                        </tr>
    <%
                    while (rs.next()) {
                        String program = rs.getString("programmename");
                        int code = rs.getInt("programmecode");
                        String semYear = rs.getString("Semester/Year");
                        String lastEndYear = rs.getString("lastsemesterendyear");
                        String resultsOfSemester = rs.getString("resultsofthesemester");

                        out.println("<tr>");
                        out.println("<td>" + program + "</td>");
                        out.println("<td>" + code + "</td>");
                        out.println("<td>" + semYear + "</td>");
                        out.println("<td>" + lastEndYear + "</td>");
                        out.println("<td>" + resultsOfSemester + "</td>");
                        out.println("</tr>");
                    }
    %>
                    </table>
    <%
                }
            } catch (Exception e) {
                out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</div>
<div class="footer">
        <a href="AdminSemesterResults.jsp">Back</a> | 
        <a href="123.html">Home</a>
    </div>
</body>
</html>
