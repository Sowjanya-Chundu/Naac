<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Average Number of Days for Declaration of Results</title>
    <!-- Include Font Awesome CSS -->

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
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
        /* Style for the icons */
        .icon-button {
            border: none;
            background: none;
            cursor: pointer;
            font-size: 24px;
            margin: 5px;
        }
        /* Positioning for top left corner */
        .top-left {
            position: absolute;
            top: 10px;
            left: 10px;
        }
       
       
    </style>
</head>
<body>
    

    

    <table>
        <tr>
            <th>Program Name</th>
            <th>Program Code</th>
            <th>Semester/Year</th>
            <th>Last Semester End Year</th>
            <th>Results of the Semester</th>
            <th>Number of Days</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            List<Integer> daysList = new ArrayList<>();
            int totalDays = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                String query = "SELECT programmename, programmecode, `Semester/Year`, lastsemesterendyear, resultsofthesemester FROM semesteryear WHERE programmename='Information Technology' AND `Semester/Year` ='I-II'";

                String academicYear = request.getParameter("academicYear");
                String department = request.getParameter("department");

                
                ps = conn.prepareStatement(query);
                

                rs = ps.executeQuery();

                while (rs.next()) {
                    String program = rs.getString("programmename");
                    int code = rs.getInt("programmecode");
                    String semYear = rs.getString("Semester/Year");

                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    LocalDate lastEndYear = LocalDate.parse(rs.getString("lastsemesterendyear"), formatter);
                    LocalDate resultsOfSemester = LocalDate.parse(rs.getString("resultsofthesemester"), formatter);

                    long daysDifference = ChronoUnit.DAYS.between(lastEndYear, resultsOfSemester);
                    daysList.add((int) daysDifference);

                    out.println("<tr>");
                    out.println("<td>" + program + "</td>");
                    out.println("<td>" + code + "</td>");
                    out.println("<td>" + semYear + "</td>");
                    out.println("<td>" + lastEndYear.format(formatter) + "</td>");
                    out.println("<td>" + resultsOfSemester.format(formatter) + "</td>");
                    out.println("<td>" + daysDifference + "</td>");
                    out.println("</tr>");
                }

                int averageDays = daysList.size() > 0 ? (int) daysList.stream().mapToInt(Integer::intValue).average().getAsDouble() : 0;

                out.println("<tr>");
                out.println("<td colspan='5'><strong>Average Number of Days:</strong></td>");
                out.println("<td>" + averageDays + "</td>");
                out.println("</tr>");

            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>

  
</body>
</html>
