<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .icon-container {
            margin-bottom: 20px;
            text-align: center;
        }
        .icon-container img {
            width: 150px; /* Increased size */
            height: 150px; /* Ensure height matches width for circular shape */
            margin: 0 20px; /* Adjust spacing between icons */
            cursor: pointer; /* Change cursor to pointer on hover */
            border-radius: 50%; /* Make images circular */
            object-fit: cover; /* Ensure image covers the circle without distortion */
        }
        .icon-container p {
            font-size: 18px; /* Adjust font size as needed */
        }
        .navigation {
            position: fixed;
            top: 10px;
            left: 10px;
            display: flex; /* Align icons horizontally */
            gap: 10px; /* Space between icons */
        }
        .navigation img {
            width: 50px; /* Adjust size as needed */
            height: 50px; /* Ensure height matches width for circular shape */
            border-radius: 50%; /* Make images circular */
            object-fit: cover; /* Ensure image covers the circle without distortion */
        }
    </style>
</head>
<body>
    <div class="navigation">
        <a href="sublist2.html">
            <img src="back-icon.jpeg" alt="Back">
        </a>
        <a href="home.html">
            <img src="home-icon.jpeg" alt="Home">
        </a>
    </div>
    <div class="container">
        <div id="dataContainer">
            <h1>Student to Full-Time Teacher Ratio</h1>
            <%
                Connection con = null;
                PreparedStatement studentSt = null;
                PreparedStatement teacherSt = null;
                ResultSet studentResult = null;
                ResultSet teacherResult = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                    // Query to get the total number of students
                    String studentSql = "SELECT COUNT(*) AS totalStudents FROM project.studentsdata"; // Adjust table name as per your database schema
                    studentSt = con.prepareStatement(studentSql);
                    studentResult = studentSt.executeQuery();

                    // Query to get the total number of full-time teachers
                    String teacherSql = "SELECT COUNT(*) AS totalTeachers FROM fulltimeteachers";
                    teacherSt = con.prepareStatement(teacherSql);
                    teacherResult = teacherSt.executeQuery();

                    int totalStudents = 0;
                    int totalTeachers = 0;

                    if (studentResult.next()) {
                        totalStudents = studentResult.getInt("totalStudents");
                    }

                    if (teacherResult.next()) {
                        totalTeachers = teacherResult.getInt("totalTeachers");
                    }

                    if (totalTeachers > 0) {
                        double ratio = (double) totalStudents / totalTeachers;
                        // Display icons side by side with links to other pages
                        out.println("<div class='icon-container'>");
                        out.println("<a href='studentPage.jsp'>"); // Link for student icon
                        out.println("<img src='student.jpg' alt='Student Icon'>");
                        out.println("</a>");
                        out.println("<a href='teacherPage.jsp'>"); // Link for teacher icon
                        out.println("<img src='teacher.jpeg' alt='Teacher Icon'>");
                        out.println("</a>");
                        out.println("</div>");
                        // Display ratio below the icons
                        out.println("<p>Total Students: " + totalStudents + "</p>");
                        out.println("<p>Total Full-Time Teachers: " + totalTeachers + "</p>");
                        out.println("<p>Student to Teacher Ratio: " + String.format("%.2f", ratio) + "</p>");
                    } else {
                        out.println("<p>No full-time teachers found in the institution.</p>");
                    }

                } catch (SQLException e) {
                    out.println("SQL Exception: " + e.getMessage());
                    e.printStackTrace(); // Print detailed stack trace to server logs
                } catch (Exception e) {
                    out.println("Exception: " + e.getMessage());
                    e.printStackTrace(); // Print detailed stack trace to server logs
                } finally {
                    try {
                        if (studentResult != null) studentResult.close();
                        if (teacherResult != null) teacherResult.close();
                        if (studentSt != null) studentSt.close();
                        if (teacherSt != null) teacherSt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace(); // Print detailed stack trace to server logs
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
