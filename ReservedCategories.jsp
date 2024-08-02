<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<head>
    <meta charset="UTF-8">
    <title>Reservation Categories</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Category', 'Count'],
                ['SC', 16],
                ['ST', 9],
                ['OBC', 26],
                ['General', 30],
                ['Others', 19]
            ]);

            var options = {
                title: 'Reservation Categories',
                pieHole: 0.4
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <div id="dataContainer">
        <h2>Reservation Categories</h2>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
        <table id="dataTable" border="1">
            <thead>
                <tr>
                    <th>Serial Number</th>
                    <th>SC</th>
                    <th>ST</th>
                    <th>OBC</th>
                    <th>General</th>
                    <th>Others</th>
                </tr>
            </thead>
            <tbody>
            <% 
                Connection con = null;
                PreparedStatement st = null;
                ResultSet result = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

                    // Create and execute SQL query
                    String sql = "SELECT * FROM reservedcategories";
                    st = con.prepareStatement(sql);
                    result = st.executeQuery();

                    int serialNumber = 1;

                    while (result.next()) {
                        int sc = result.getInt("SC");
                        int stValue = result.getInt("ST");
                        int obc = result.getInt("OBC");
                        int gen = result.getInt("Gen");
                        int others = result.getInt("Others");

                        // Display data in table rows
                        out.println("<tr>");
                        out.println("<td>" + serialNumber + "</td>");
                        out.println("<td>" + sc + "</td>");
                        out.println("<td>" + stValue + "</td>");
                        out.println("<td>" + obc + "</td>");
                        out.println("<td>" + gen + "</td>");
                        out.println("<td>" + others + "</td>");
                        out.println("</tr>");

                        serialNumber++;
                    }

                } catch (SQLException e) {
                    out.println("SQL Exception: " + e.getMessage());
                    e.printStackTrace();
                } catch (Exception e) {
                    out.println("Exception: " + e);
                    e.printStackTrace();
                } finally {
                    try {
                        if (result != null) result.close();
                        if (st != null) st.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
