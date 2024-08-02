<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<head>
    <meta charset="UTF-8">
    <style>
        /* Style for the navigation bar with icons */
        .navigation {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            align-items: center;
            background-color: transparent;
        }

        .navigation .icon {
            margin-right: 10px;
        }

        .navigation .icon img {
            width: 30px;
            height: 30px;
            vertical-align: middle;
        }

        /* Ensure the data container is not obscured by the navigation bar */
        #dataContainer {
            padding-top: 50px; /* Adjust if necessary */
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Basic styling for table */
        #dataTable {
            width: 100%;
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        #dataTable th, #dataTable td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="navigation">
        <a href="home.html" class="icon"><img src="home-icon.jpeg" alt="Home"></a>
        <a href="123.html" class="icon" onclick="history.back()"><img src="back-icon.jpeg" alt="Back"></a>
    </div>
    <div id="dataContainer">
        <table id="dataTable">
            <thead>
                <tr>
                    <th>Serial Number</th>
                    <th>Branch</th>
                    <th>Special Programs</th>
                    <th>Slow and Advance</th>
                    <th>Date and Time</th>
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
                    String sql = "SELECT * FROM project.advslow;";
                    st = con.prepareStatement(sql);
                    result = st.executeQuery();

                    int serialNumber = 1;

                    while (result.next()) {
                        String branch = result.getString("Branch");
                        String specialPrograms = result.getString("SpecialPrograms");
                        String slowAndAdvance = result.getString("SlowandAdvance");
                        String dateAndTime = result.getString("DateandTime");

                        // Display data in table rows
                        out.println("<tr>");
                        out.println("<td>" + serialNumber + "</td>");
                        out.println("<td>" + branch + "</td>");
                        out.println("<td><a href='projectsList.jsp?branch=" + branch + "&program=" + specialPrograms + "'>" + specialPrograms + "</a></td>");
                        out.println("<td><a href='advanslow.jsp?branch=" + branch + "&program=" + slowAndAdvance + "'>" + slowAndAdvance + "</a></td>");
                        out.println("<td>" + dateAndTime + "</td>");
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
