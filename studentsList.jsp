<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="data:image/jpeg;base64,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">
    <title>Vasireddy Venkatadri Institute of Technology</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2; /* Set a light background color */
        }
        .menu-toggle-button {
            font-size: 30px;
            cursor: pointer;
            position: fixed;
            top: 15px;
            left: 15px; /* Position on the left side */
            z-index: 999; /* Ensure button is above other elements */
            color: #333; /* Dark gray color for contrast */
            background-color: #fff; /* White background */
            padding: 10px; /* Increase padding for larger clickable area */
            border-radius: 5px; /* Rounded corners for a modern look */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Drop shadow for depth */
        }
        .menu-toggle-button:hover {
            background-color: #e0e0e0; /* Light gray on hover */
        }
        .menu-options {
            position: fixed;
            top: 60px; /* Adjust top position for alignment */
            left: 15px; /* Adjust left position for alignment */
            width: 200px; /* Adjust width as needed */
            background-color: #333;
            z-index: 1000; /* Ensure options are above other content */
            padding: 10px; /* Add padding for spacing */
            border-radius: 5px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Drop shadow for depth */
            display: none; /* Initially hide */
        }
        .menu-options.opened {
            display: block; /* Show when opened */
        }
        .menu-options a {
            display: block;
            padding: 10px 0;
            text-decoration: none;
            color: white;
            font-size: 18px;
            text-align: center;
        }
        .menu-options a:hover {
            background-color: #575757;
        }
        .content {
            margin-left: 240px; /* Adjust margin for menu width + spacing */
            padding: 20px;
            transition: margin-left 0.3s ease; /* Smooth transition */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
           .navigation {
            position: fixed;
            bottom: 10px;
            right: 10px;
        }
    </style>
</head>
<body>
<div class="menu-toggle-button" onclick="toggleMenu()">
    &#9776; <!-- Hamburger icon -->
</div>

<div class="menu-options" id="menuOptions">
    <a href="AdminStudentInsert.jsp">Insert</a>
    <a href="AdminStudentDelete.jsp">Delete</a>
    <a href="AdminStudentRetrive.jsp">Retrieve</a>
</div> 

<div class="content">
    <h2>Retrieve Student Data</h2>
    <%
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

            String query = "SELECT * FROM project.studentsdata;";
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
    %>
            <h2>Student Data</h2>
            <table>
                <thead>
                    <tr>
                        <th>Registration Number</th>
                        <th>Student Name</th>
                        <th>Enrollment Year</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    while (resultSet.next()) {
                %>
                        <tr>
                            <td><%= resultSet.getString("rollno") %></td>
                            <td><%= resultSet.getString("Name") %></td>
                            <td><%= resultSet.getString("enrollmentyear") %></td>
                        </tr>
                <%
                    }
                %>
                </tbody>
            </table>
    <%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving data</p>");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</div>

<script>
    var menuOptions = document.getElementById("menuOptions");

    function toggleMenu() {
        menuOptions.classList.toggle('opened');
    }

    // Close menu options when clicking outside
    document.addEventListener('click', function(e) {
        if (!menuOptions.contains(e.target) && e.target !== document.querySelector('.menu-toggle-button')) {
            menuOptions.classList.remove('opened');
        }
    });
</script>
 <div class="navigation">
    <a href="<%=request.getContextPath()%>/AdminStudentFullTimeTeacher.jsp">Back</a>  ||
    <a href="<%=request.getContextPath()%>/123.html">Home</a>
</div>
</body>
</html>
