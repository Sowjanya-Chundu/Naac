<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Semester Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            width: 60%;
            margin: auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
            background-color: #d9534f;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #c9302c;
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
    <h2>Delete Semester Records</h2>
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
            <button type="submit">Delete Records</button>
        </div>
    </form>

    <%-- Delete Logic --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String url = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                String programName = request.getParameter("programName");
                String semesterYear = request.getParameter("semesterYear");

                if (programName != null && !programName.isEmpty() && semesterYear != null && !semesterYear.isEmpty()) {
                    String deleteQuery = "DELETE FROM semesteryear WHERE programmename = ? AND `Semester/Year` = ?";
                    ps = conn.prepareStatement(deleteQuery);
                    ps.setString(1, programName);
                    ps.setString(2, semesterYear);

                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p style='color: green;'>Records deleted successfully.</p>");
                    } else {
                        out.println("<p class='error-message'>No records found for deletion.</p>");
                    }
                } else {
                    out.println("<p class='error-message'>Please provide both Program Name and Semester/Year.</p>");
                }

            } catch (Exception e) {
                out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
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
