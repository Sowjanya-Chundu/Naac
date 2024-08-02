<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%
    // Get parameters
    String id = request.getParameter("sno");
    String name = request.getParameter("name");
    String designation = request.getParameter("designation");
    String qualification = request.getParameter("qualification");
    String experience = request.getParameter("experience");
    String specialization = request.getParameter("specialization");

    // Debugging information
    out.println("Received Parameters:<br>");
    out.println("ID: " + id + "<br>");
    out.println("Name: " + name + "<br>");
    out.println("Designation: " + designation + "<br>");
    out.println("Qualification: " + qualification + "<br>");
    out.println("Experience: " + experience + "<br>");
    out.println("Specialization: " + specialization + "<br>");

    // Validate ID
    if (id != null && !id.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

            // Prepare SQL update statement
            String sql = "UPDATE `2021-22faculty` SET `Name`=?, `Designation`=?, `Qualification`=?, `EXP`=?, `Area of Specialization`=? WHERE `S.No`=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, designation);
            stmt.setString(3, qualification);
            stmt.setString(4, experience);
            stmt.setString(5, specialization);
            stmt.setInt(6, Integer.parseInt(id));

            // Execute update
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("Faculty details updated successfully.<br><br>");

                // Prepare SQL select statement
                String selectSQL = "SELECT * FROM `2021-22faculty`";
                stmt = conn.prepareStatement(selectSQL);
                ResultSet rs = stmt.executeQuery();

                // Display table data
                out.println("<table border='1'>");
                out.println("<tr>");
                out.println("<th>S.No</th>");
                out.println("<th>Name</th>");
                out.println("<th>Designation</th>");
                out.println("<th>Qualification</th>");
                out.println("<th>EXP</th>");
                out.println("<th>Area of Specialization</th>");
                out.println("</tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("S.No") + "</td>");
                    out.println("<td>" + rs.getString("Name") + "</td>");
                    out.println("<td>" + rs.getString("Designation") + "</td>");
                    out.println("<td>" + rs.getString("Qualification") + "</td>");
                    out.println("<td>" + rs.getString("EXP") + "</td>");
                    out.println("<td>" + rs.getString("Area of Specialization") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");

            } else {
                out.println("Failed to update faculty details.");
            }
        } catch (Exception e) {
            // Convert stack trace to string
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String stackTrace = sw.toString();
            
            out.println("<pre>" + stackTrace + "</pre>");
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
    } else {
        out.println("Invalid ID.");
    }
%>
