<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Semester Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .form-container {
            width: 300px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
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
        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            font-size: 0.9em;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
        }
        .form-group button:hover {
            background-color: #286090;
        }
        .message {
            text-align: center;
            margin-top: 20px;
        }
         .footer {
            position: fixed;
            bottom: 10px;
            left: 10px;
        }
        
    </style>
</head>
<body>

<div class="form-container">
    <h2>Insert Semester Data</h2>
    <form method="post" action="AdminSemesterinsert.jsp">
        <div class="form-group">
            <label for="programName">Program Name:</label>
            <input type="text" id="programName" name="programName" required>
        </div>
        <div class="form-group">
            <label for="programCode">Program Code:</label>
            <input type="text" id="programCode" name="programCode" required>
        </div>
        <div class="form-group">
            <label for="semesterYear">Semester/Year:</label>
            <input type="text" id="semesterYear" name="semesterYear" required>
        </div>
        <div class="form-group">
            <label for="lastSemesterEndYear">Last Semester End Year (dd-MM-yyyy):</label>
            <input type="text" id="lastSemesterEndYear" name="lastSemesterEndYear" placeholder="dd-MM-yyyy" required>
        </div>
        <div class="form-group">
            <label for="resultsOfTheSemester">Results of the Semester (dd-MM-yyyy):</label>
            <input type="text" id="resultsOfTheSemester" name="resultsOfTheSemester" placeholder="dd-MM-yyyy" required>
        </div>
        <div class="form-group">
            <button type="submit">Insert</button>
        </div>
    </form>
    <div class="message">
        <% 
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/project";
            String username = "root";
            String password = "sowjanyapassword";

            // Get parameters from form submission
            String programName = request.getParameter("programName");
            String programCodeStr = request.getParameter("programCode");
            String semesterYear = request.getParameter("semesterYear");
            String lastSemesterEndYearStr = request.getParameter("lastSemesterEndYear");
            String resultsOfTheSemesterStr = request.getParameter("resultsOfTheSemester");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, username, password);

                // SQL query to insert data
                String query = "INSERT INTO semesteryear (programmename, programmecode, `Semester/Year`, lastsemesterendyear, resultsofthesemester) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, programName);
                ps.setInt(2, Integer.parseInt(programCodeStr));
                ps.setString(3, semesterYear);
                ps.setString(4, lastSemesterEndYearStr);
                ps.setString(5, resultsOfTheSemesterStr);

                // Execute the query
                int rowsInserted = ps.executeUpdate();

                // Display success or failure message
                if (rowsInserted > 0) {
                    out.println("<p style='color: green;'>Record inserted successfully!</p>");
                } else {
                    out.println("<p style='color: red;'>Failed to insert record.</p>");
                }

                // Close resources
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        %>
    </div>
</div>
<div class="footer">
        <a href="AdminSemesterResults.jsp">Back</a> | 
        <a href="123.html">Home</a>
    </div>
</body>
</html>
