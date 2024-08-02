<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<head>
    <meta charset="UTF-8">
    <title>Reservation Categories</title>
    <style>
    .navigation {
            position: fixed;
            bottom: 10px;
            right: 10px;
        }
    </style>
</head>
<body>
    <div id="dataContainer">
        
        <table id="dataTable" border="1">
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
                        out.println("<td><a href='AdvJava.jsp?branch=" + branch + "&program=" + slowAndAdvance + "'>" + slowAndAdvance + "</a></td>");
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
    <div class="navigation">
    <a href="<%=request.getContextPath()%>/MentorMente.jsp">Back</a> ||
    <a href="<%=request.getContextPath()%>/home.html">Home</a>
</div>
</body>
</html>
