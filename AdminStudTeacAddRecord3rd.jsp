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
    String regdno = request.getParameter("regdno");
    String name = request.getParameter("name");
    String mobile = request.getParameter("mobile");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

        // SQL insert query including S.No
        String insertSql = "INSERT INTO project.councel3rdbtech (`S.No`, `IIIB.TECH`, `Name of the Counselor`, `Counselor Mobile Number`) VALUES (?, ?, ?, ?)";
        pst = con.prepareStatement(insertSql);
        pst.setInt(1, Integer.parseInt(sno)); // Assuming S.No is an integer
        pst.setString(2, regdno);
        pst.setString(3, name);
        pst.setString(4, mobile);

        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Record added successfully.");
        } else {
            out.println("Failed to add the record.");
        }

        // SQL select query
        String selectSql = "SELECT * FROM project.councel3rdbtech";
        pst = con.prepareStatement(selectSql);
        rs = pst.executeQuery();

%>
        <h2>Data from Database:</h2>
        <table border="1">
            <tr>
                <th>S.No</th>
                <th>III B.TECH</th>
                <th>Name of the Counselor</th>
                <th>Counselor Mobile Number</th>
            </tr>
<%
        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("S.No") %></td>
                <td><%= rs.getString("IIIB.TECH") %></td>
                <td><%= rs.getString("Name of the Counselor") %></td>
                <td><%= rs.getString("Counselor Mobile Number") %></td>
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
