<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<html>
<head>
    <title>Data Display</title>
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
    <!-- Dashboard container with three lines button and dashboard content -->
    <div id="dashboard-container">
        <!-- Toggle button for dashboard with three lines -->
        <button id="dashboard-toggle-btn" onclick="toggleDashboard()">☰</button>

        <!-- Dashboard content -->
        <div id="dashboard">
            <div id="menu">
                <a href="index.html">Insert</a>
                <a href="delete1.html">Delete</a>
                <a href="displayStudent.html">Retrieve</a>
            </div>
        </div>
    </div>
    <h2>Data Table</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Roll No</th>
            <th>Gender</th>
            <th>Admission Type</th>
            <th>Category of Admission</th>
            <th>Branch</th>
        </tr>
        <%
            int ncount = 0;
            int CQtype = 0;
            int MQtype = 0;
            String academicYear = request.getParameter("year");

            try {
                // Load MySQL JDBC driver and establish a database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // Prepare and execute SQL query
                String sqlQuery = "SELECT `Name`, `RollNo`, `Gender`, `Admission Type`, `CATEGORY OF ADMISSION`, `Branch` FROM project.`cse21-22`";

                PreparedStatement st = con.prepareStatement(sqlQuery);
                ResultSet result = st.executeQuery();

                // Retrieve data and populate the table
                while (result.next()) {
                    String Name = result.getString("Name");
                    int RollNo = result.getInt("RollNo");
                    String setGender = result.getString("Gender");
                    String setAdmissionType = result.getString("Admission Type");
                    String CategoryOfAdmission = result.getString("CATEGORY OF ADMISSION");
                    String branch = result.getString("Branch");
        %>
        <tr>
            <td><%= Name %></td>
            <td><%= RollNo %></td>
            <td><%= setGender %></td>
            <td><%= setAdmissionType %></td>
            <td><%= CategoryOfAdmission %></td>
            <td><%= branch %></td>
        </tr>
        <%
            ncount++;

            if (setAdmissionType != null) {
                if (setAdmissionType.equals("CQ")) {
                    CQtype++;
                } else {
                    MQtype++;
                }
            }
        }

        // Close database resources
        st.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace(); // Print the stack trace to the console for debugging
    }
%>
</table>
 <!-- JavaScript function to toggle the dashboard -->
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
    <h3>Total admitted students in 2021-22student is: <%= ncount %></h3>
    <h3>MQ category students in 2021-22student is: <%= MQtype %></h3>
    <h3>CQ category students in 2021-22student is: <%= CQtype %></h3>
</body>
</html>
