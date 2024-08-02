<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert and Retrieve Data</title>
</head>
<body>
<%
    String sno = request.getParameter("sno");
    String regdno = request.getParameter("name");
    String name = request.getParameter("designation");
    String mobile = request.getParameter("qualification");
    String specialization = request.getParameter("specialization");
    String exp = request.getParameter("experience");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

        // SQL insert query including S.No
        String insertSql = "INSERT INTO project.`2023-24faculty` (`S.No`, `Name`, `Designation`, `Qualification`, `Area of Specialization`, `EXP`) VALUES (?, ?, ?, ?, ?, ?)";
        pst = con.prepareStatement(insertSql);
        pst.setInt(1, Integer.parseInt(sno)); // Assuming S.No is an integer
        pst.setString(2, regdno);
        pst.setString(3, name);
        pst.setString(4, mobile);
        pst.setString(5, specialization);
        pst.setInt(6, Integer.parseInt(exp)); // Assuming EXP is an integer

        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Record added successfully.");
        } else {
            out.println("Failed to add the record.");
        }

        // SQL select query
        String selectSql = "SELECT * FROM project.`2023-24faculty`";
        pst = con.prepareStatement(selectSql);
        rs = pst.executeQuery();

%>
        <h2>Data from Database:</h2>
        <table border="1">
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Qualification</th>
                <th>Area Of Specialization</th>
                <th>Experience</th>
            </tr>
<%
        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("S.No") %></td>
                <td><%= rs.getString("Name") %></td>
                <td><%= rs.getString("Designation") %></td>
                <td><%= rs.getString("Qualification") %></td>
                <td><%= rs.getString("Area of Specialization") %></td>
                <td><%= rs.getInt("EXP") %></td>
            </tr>
<%
        }
%>
        </table>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
