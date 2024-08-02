<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Faculty Data</title>

    <style>
        <!-- Your existing styles here -->
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
                    <a href="FacultyRetrieve.html">Retrieve</a>
                </div>
            </div>
        </div>

        <h2>Faculty Information</h2>

        <%
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/project";
            String user = "root";
            String password = "sowjanyapassword";
            int count = 0;
            int pc = 0;
            int mc = 0;

            Connection connection = null;  // Declare connection outside try block

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(url, user, password);

                String query = "SELECT * FROM project.`2019-20faculty`";
                try (Statement statement = connection.createStatement();
                     ResultSet resultSet = statement.executeQuery(query)) {
        %>

        <table border="1">
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Date Of Joining</th>
                <th>Qualification</th>
                <th>Area of Specialization</th>
                
            </tr>

            <%
                // Display the results
                while (resultSet.next()) {
                    int sNo = resultSet.getInt("S.No");
                    String name = resultSet.getString("Name");
                    String designation = resultSet.getString("Designation");
                    String dateOfJoining = resultSet.getString("Date Of Joining");
                    String qualification = resultSet.getString("Qualification");
                    String areaOfSpecialization = resultSet.getString("Area of Specialization");
                    
            %>

            <tr>
                <td><%= sNo %></td>
                <td><%= name %></td>
                <td><%= designation %></td>
                <td><%= dateOfJoining %></td>
                <td><%= qualification %></td>
                <td><%= areaOfSpecialization %></td>
                
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
