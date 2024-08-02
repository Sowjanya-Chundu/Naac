<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #000;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<%
    // Retrieve parameters from request
    String id = request.getParameter("sno");
    String regdno = request.getParameter("regdno");
    String name = request.getParameter("name");
    String mobile = request.getParameter("mobile");

    // Debugging output
    out.println("<h2>Debug Information</h2>");
    out.println("<p>id: " + (id != null ? id : "null") + "</p>");
    out.println("<p>regdno: " + (regdno != null ? regdno : "null") + "</p>");
    out.println("<p>name: " + (name != null ? name : "null") + "</p>");
    out.println("<p>mobile: " + (mobile != null ? mobile : "null") + "</p>");

    // Check for missing or empty parameters
    if (id == null || id.isEmpty() || regdno == null || regdno.isEmpty() || name == null || name.isEmpty() || mobile == null || mobile.isEmpty()) {
        out.println("<p>Error: Missing or empty parameters.</p>");
        return;
    }

    int sno;
    try {
        sno = Integer.parseInt(id);
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid number format for 'sno'.</p>");
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

        // Update SQL query
        String sql = "UPDATE project.councelling4thbtech SET `IV B.TECH`=?, `Name of the Counselor`=?, `CounselorMobileNumber`=? WHERE `S.No`=?";
        pst = con.prepareStatement(sql);
        pst.setString(1, regdno);
        pst.setString(2, name);
        pst.setString(3, mobile);
        pst.setInt(4, sno); // Set the `S.No` value in the WHERE clause

        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p>Record updated successfully.</p>");
        } else {
            out.println("<p>Failed to update the record. The record may not exist or the data may be unchanged.</p>");
        }

        // Retrieve updated data
        out.println("<h2>Updated Records</h2>");
        sql = "SELECT * FROM project.councelling4thbtech";
        pst = con.prepareStatement(sql);
        ResultSet result = pst.executeQuery();

        out.println("<table>");
        out.println("<thead><tr><th>S.No</th><th>4th Btech</th><th>Name of the Counselor</th><th>Mobile No</th></thead>");
        out.println("<tbody>");
        while (result.next()) {
            int dbSno = result.getInt("S.No");
            String updatedRegdno = result.getString("IV B.TECH");
            String updatedName = result.getString("Name of the Counselor");
            String updatedMobile = result.getString("CounselorMobileNumber");
            out.println("<tr>");
            out.println("<td>" + dbSno + "</td>");
            out.println("<td>" + updatedRegdno + "</td>");
            out.println("<td>" + updatedName + "</td>");
            out.println("<td>" + updatedMobile + "</td>");
            out.println("</tr>");
        }
        out.println("</tbody>");
        out.println("</table>");

        // Close resources
        result.close();
        pst.close();
        con.close();
    } catch (SQLException e) {
        out.println("<p>Error: SQL Exception - " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<a href="AdminMentorMente.jsp">Go back</a>

</body>
</html>
