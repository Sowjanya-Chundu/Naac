<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<head>
<meta charset="UTF-8">
<title>Student Admission Details</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js library -->
<style>
    #dataContainer {
        max-width: 800px;
        margin: 20px auto;
        text-align: center;
    }
    #dataTable {
        width: 100%;
        margin-bottom: 20px;
        border-collapse: collapse;
    }
    #dataTable th, #dataTable td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    #myChart {
        max-width: 600px;
        margin: 0 auto;
    }
</style>
</head>
<body>
<div id="dataContainer">
    <h2>Student Admission Details</h2>
    <table id="dataTable">
        <thead>
            <tr>
                <th>Serial Number</th>
                <th>Programme Name</th>
                <th>Programme Code</th>
                <th>Number of Seats Sanctioned</th>
                <th>Number of Students Admitted</th>
                <th>Academic Year</th>
            </tr>
        </thead>
        <tbody>
        <% 
            List<Integer> sanctionedSeats = new ArrayList<>();
            List<Integer> enrolledSeats = new ArrayList<>();

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                // Create and execute SQL query
                String sql = "SELECT * FROM studentadmitted";
                PreparedStatement st = con.prepareStatement(sql);
                ResultSet result = st.executeQuery();

                int serialNumber = 1;

                while (result.next()) {
                    String name = result.getString("Programme Name");
                    int branch = result.getInt("Programme Code");
                    int admissionType = result.getInt("Number of seats sanctioned");
                    int admission = result.getInt("Number of Students admitted");
                    String categoryOfAdmission = result.getString("Academic Year");

                    // Add data to lists for chart
                    sanctionedSeats.add(admissionType);
                    enrolledSeats.add(admission);

                    // Display data in table rows
                    out.println("<tr>");
                    out.println("<td>" + serialNumber + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + branch + "</td>");
                    out.println("<td>" + admissionType + "</td>");
                    out.println("<td>" + admission + "</td>");
                    out.println("<td>" + categoryOfAdmission + "</td>");
                    out.println("</tr>");

                    serialNumber++;
                }

                result.close();
                st.close();
                con.close();
            } catch (SQLException e) {
                out.println("SQL Exception: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                out.println("Exception: " + e);
            }
        %>
        </tbody>
    </table>

    <!-- Canvas for Chart.js -->
    <canvas id="myChart"></canvas>

</div>

<script>
    // JavaScript code for Chart.js
    var sanctionedData = <%= sanctionedSeats %>;
    var enrolledData = <%= enrolledSeats %>;

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: sanctionedData.map((_, index) => 'Data ' + (index + 1)),
            datasets: [{
                label: 'Sanctioned Seats',
                data: sanctionedData,
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderWidth: 1,
                fill: false,
                cubicInterpolationMode: 'monotone' // Smooth curve
            }, {
                label: 'Enrolled Seats',
                data: enrolledData,
                borderColor: 'rgba(54, 162, 235, 1)',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderWidth: 1,
                fill: false,
                cubicInterpolationMode: 'monotone' // Smooth curve
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>
