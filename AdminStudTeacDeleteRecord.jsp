<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("sno");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sowjanyapassword");

        // SQL delete query
        String sql = "DELETE FROM project.councelling4thbtech WHERE `S.No`=?";
        pst = con.prepareStatement(sql);
        pst.setInt(1, Integer.parseInt(id));

        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Record deleted successfully.");
        } else {
            out.println("Failed to delete the record.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
