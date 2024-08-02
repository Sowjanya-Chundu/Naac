<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student to Full-Time Teacher Ratio</title>
    <style>
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .icon-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .icon-item {
            margin: 0 20px;
            text-align: center;
        }
        .icon-item img {
            width: 150px;
            height: 150px;
            border-radius: 70px;
        }
        .icon-item a {
            text-decoration: none;
            color: inherit;
        }
        .icon-item p {
            margin-top: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
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
            String studentSql = "SELECT COUNT(*) AS totalStudents FROM project.studentinfbatch20";
            studentSt = con.prepareStatement(studentSql);
            studentResult = studentSt.executeQuery();

            // Query to get the total number of full-time teachers
            String teacherSql = "SELECT COUNT(*) AS totalTeachers FROM project.`2020-21faculty`";
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
                // Display links with counts for students and teachers
                out.println("<div class='icon-container'>");
                out.println("<div class='icon-item'><a href='studentsList.jsp?totalStudents=" + totalStudents + "'><img src='student.jpg' alt='Students Icon'><p>Total Students: " + totalStudents + "</p></a></div>");
                out.println("<div class='icon-item'><a href='TeacherList.jsp?totalTeachers=" + totalTeachers + "'><img src='teacher.jpeg' alt='Teachers Icon'><p>Total Full-Time Teachers: " + totalTeachers + "</p></a></div>");
                out.println("</div>");
                // Display ratio below the links
                out.println("<h4>Student to Teacher Ratio: " + String.format("%.2f", ratio) + "</h4>");
            } else {
                out.println("<p>No full-time teachers found in the institution.</p>");
            }

        } catch (SQLException e) {
            out.println("<p>SQL Exception: " + e.getMessage() + "</p>");
            e.printStackTrace(); // Print detailed stack trace to server logs
        } catch (Exception e) {
            out.println("<p>Exception: " + e.getMessage() + "</p>");
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
</body>
</html>
