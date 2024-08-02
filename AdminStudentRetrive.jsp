<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retrieve Student Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2; /* Set a light background color */
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        h2 {
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            margin-bottom: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="submit"] {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
            width: 100%;
            max-width: 400px;
        }
        input[type="submit"] {
            background-color: #333;
            color: #fff;
            cursor: pointer;
            border: none;
            max-width: 200px;
        }
        input[type="submit"]:hover {
            background-color: #575757;
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
            padding: 10px;
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
    <div class="container">
        <h2>Retrieve Student Data</h2>
        <form action="" method="post">
            <label for="rollNumber">Enter Roll Number:</label>
            <input type="text" id="rollNumber" name="rollNumber" required>
            <label for="studentName">Enter Student Name:</label>
            <input type="text" id="studentName" name="studentName" required>
            <input type="submit" value="Retrieve">
        </form>

        <% 
            String rollNumber = request.getParameter("rollNumber");
            String studentName = request.getParameter("studentName");

            if (rollNumber != null && !rollNumber.isEmpty() && studentName != null && !studentName.isEmpty()) {
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                    String query = "SELECT * FROM studentsdata WHERE rollno = ? AND Name = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, rollNumber);
                    preparedStatement.setString(2, studentName);

                    resultSet = preparedStatement.executeQuery();
        %>
                    <h3>Student Data</h3>
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
            }
        %>
    </div>
     <div class="navigation">
    <a href="<%=request.getContextPath()%>/studentList.jsp">Back</a>  ||
    <a href="<%=request.getContextPath()%>/123.html">Home</a>
</div>
</body>
</html>
