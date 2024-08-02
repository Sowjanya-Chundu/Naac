<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<html>
<head>
    <title>Faculty Data - 2019-2020</title>
    <style>
        
      
        
        table {
            width: 60%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
   
</head>
<body>
    
        <h2>Faculty Data for 2019-2020</h2>
        <%
            
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Replace with your database connection details
                String dbURL = "jdbc:mysql://localhost:3306/project";
                String dbUser = "root";
                String dbPassword = "sowjanyapassword"; // Ensure this is the correct password

                // Connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Sample query for retrieving all data from 2019-20faculty
                String query = "SELECT * FROM `2019-20faculty`";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p>No matching data found.</p>");
                } else {
                    out.println("<table>");
                    out.println("<tr><th>ID</th><th>Name</th><th>Designation</th><th>Qualifaction</th><th>Area Of Specailization</th><th>Experience</th></tr>");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("S.No") + "</td>");
                        out.println("<td>" + rs.getString("Name") + "</td>");
                        out.println("<td>" + rs.getString("Designation") + "</td>");
                        out.println("<td>" + rs.getString("Qualification") + "</td>");
                        out.println("<td>" + rs.getString("Area of Specialization") + "</td>");
                        out.println("<td>" + rs.getInt("EXP") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<p>An error occurred: Class not found.</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>An error occurred while retrieving data: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
