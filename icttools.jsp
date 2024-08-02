<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Retrieve Data Example</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 8px;
        }
        .navigation {
            position: fixed;
            top: 10px;
            left: 10px;
            display: flex;
            gap: 10px; /* Space between icons */
        }
        .navigation img {
            width: 30px; /* Adjust size as needed */
            height: 30px; /* Ensure height matches width for circular shape */
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="navigation">
    <a href="sublist2.html">
        <img src="back-icon.jpeg" alt="Back">
    </a>
    <a href="home.html">
        <img src="home-icon.jpeg" alt="Home">
    </a>
</div>

  <center><h2>Icttools Information</h2></center>

<%
// Define database connection variables
String url = "jdbc:mysql://localhost:3306/project";
String username = "root";
String password = "sowjanyapassword";

// Initialize JDBC objects
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    // Load and register the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish a connection to the database
    conn = DriverManager.getConnection(url, username, password);

    // Create a SQL statement
    stmt = conn.createStatement();

    // Execute SQL query to retrieve data
    String sql = "SELECT `SL.NO`, `NAME OF THE DEPATRMENT`, `ROOM NO`, `MAKE`, `AVAILABLE` FROM icttool";

    rs = stmt.executeQuery(sql);

    // Display retrieved data in a table
    out.println("<table>");
    out.println("<tr><th>S.NO</th><th>NAME OF THE DEPARTMENT</th><th>ROOM NO</th><th>MAKE</th><th>AVAILABLE</th></tr>");
    while (rs.next()) {
        int slNo = rs.getInt("SL.NO");
        String departmentName = rs.getString("NAME OF THE DEPATRMENT");
        String roomNo = rs.getString("ROOM NO");
        String make = rs.getString("MAKE");
        int available = rs.getInt("AVAILABLE");

        out.println("<tr>");
        out.println("<td>" + slNo + "</td>");
        out.println("<td>" + departmentName + "</td>");
        out.println("<td>" + roomNo + "</td>");
        out.println("<td>" + make + "</td>");
        out.println("<td>" + available + "</td>");
        out.println("</tr>");
    }
    out.println("</table>");

} catch (SQLException | ClassNotFoundException e) {
    out.println("Error: " + e.getMessage());
} finally {
    // Close JDBC objects
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("Error closing resources: " + e.getMessage());
    }
}
%>

</body>
</html>
