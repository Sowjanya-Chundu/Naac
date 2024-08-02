<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Faculty Data</title>

    <style>
       table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid black;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }

        #dashboard-container {
            position: fixed;
            top: 50px;
            right: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        #dashboard-toggle-btn {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 10px;
            margin-bottom: 10px;
        }

        #dashboard {
            display: none;
            width: 250px;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
            transition: display 0.3s ease;
        }

        #dashboard a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
            transition: background-color 0.3s ease;
        }

        #dashboard a:hover {
            background-color: #495057;
        }

        .dashboard-open {
            display: block;
        }
    </style>
</head>
<body>

    <div class="faculty-info">
       <div id="dashboard-container">
        <!-- Toggle button for dashboard with three lines -->
        <button id="dashboard-toggle-btn" onclick="toggleDashboard()">☰</button>

        <!-- Dashboard content -->
        <div id="dashboard">
            <div id="menu">
                <a href="FacultyInsert.html">Insert</a>
                <a href="FacultyDelete.html">Delete</a>
                <a href="FacultyRetrive.html">Retrive</a>
               
            </div>
        </div>
    </div>

        <h2>Faculty Information</h2>

        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/database";
            String user = "root";
            String password = "sowjanyapassword";
            int count = 0;
            int pc = 0;
            int mc = 0;
            String Designation = request.getParameter("designation");

            Connection connection = null;

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(url, user, password);

                // Construct the SQL query
                String query = "SELECT * FROM database.facultyinfo";
                try (Statement statement = connection.createStatement();
                     ResultSet resultSet = statement.executeQuery(query)) {
        %>

        <table border="1">
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Date Of Joining</th>
            </tr>

            <%
                // Display the results
                while (resultSet.next()) {
                    int sNo = resultSet.getInt("S. No");
                    String name = resultSet.getString("Name");
                    String designation = resultSet.getString("Designation");
                    String dateOfJoining = resultSet.getString("Date Of Joining");
            %>

            <tr>
                <td><%= sNo %></td>
                <td><%= name %></td>
                <td><%= designation %></td>
                <td><%= dateOfJoining %></td>
            </tr>

            <%
                count++;
                if (designation != null) {
                    if (designation.equals("Professor")) {
                        pc++;
                    } else {
                        mc++;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the connection in the finally block
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
            
        %>
        </table>

        <h3>Total Faculty Count: <%= count %></h3>
        <h3>Professor Count: <%= pc %></h3>
        <h3>Assistant Professor Count: <%= mc %></h3>

    </div>

     <script>
        var dashboardOpen = false;

        function toggleDashboard() {
            var dashboard = document.getElementById("dashboard");

            if (!dashboardOpen) {
                dashboard.style.display = "block";
            } else {
                dashboard.style.display = "none";
            }

            dashboardOpen = !dashboardOpen;
        }
    </script>
<br><br>
</body>
    <%}finally {
        // Close the connection in the finally block
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } %>
</html>
