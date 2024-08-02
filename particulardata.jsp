<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retrieve Data</title>
</head>
<body>
    <h2>Student Details for 2021 and 2022 Batches</h2>
    
    <% 
        Connection conn = null;
        PreparedStatement pstmt2021 = null;
        PreparedStatement pstmt2022 = null;
        ResultSet rs2021 = null;
        ResultSet rs2022 = null;
        
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection to MySQL database
            String url = "jdbc:mysql://localhost:3306/project";
            String user = "root";
            String password = "sowjanyapassword";
            conn = DriverManager.getConnection(url, user, password);
            
            // SQL query for 2021 batch
            String sql2021 = "SELECT * FROM studentsdata WHERE EnrollmentYear = ? AND Rollno BETWEEN ? AND ?";
            pstmt2021 = conn.prepareStatement(sql2021);
            pstmt2021.setInt(1, 2021); // Set EnrollmentYear for 2021
            pstmt2021.setString(2, "21BQ1A1201"); // Set Rollno start for 2021
            pstmt2021.setString(3, "21BQ1A6163"); // Set Rollno end for 2021
            rs2021 = pstmt2021.executeQuery();
            
            // SQL query for 2022 batch
            String sql2022 = "SELECT * FROM studentsdata WHERE EnrollmentYear = ? AND Rollno BETWEEN ? AND ?";
            pstmt2022 = conn.prepareStatement(sql2022);
            pstmt2022.setInt(1, 2022); // Set EnrollmentYear for 2022
            pstmt2022.setString(2, "22BQ1A0101"); // Set Rollno start for 2022
            pstmt2022.setString(3, "22BQ1A6152"); // Set Rollno end for 2022
            rs2022 = pstmt2022.executeQuery();
            		
            String sql2019 = "SELECT * FROM studentsdata WHERE EnrollmentYear = ? AND Rollno BETWEEN ? AND ?";
            pstmt2022 = conn.prepareStatement(sql2019);
            pstmt2022.setInt(1, 2019); // Set EnrollmentYear for 2022
            pstmt2022.setString(2, "19BQ1A0102"); // Set Rollno start for 2022
            pstmt2022.setString(3, "19BQ1A12I9	"); // Set Rollno end for 2022
            rs2022 = pstmt2022.executeQuery();
            		
            String sql2020 = "SELECT * FROM studentsdata WHERE EnrollmentYear = ? AND Rollno BETWEEN ? AND ?";
            pstmt2022 = conn.prepareStatement(sql2020);
            pstmt2022.setInt(1, 2020); // Set EnrollmentYear for 2022
            pstmt2022.setString(2, "20BQ5A1201"); // Set Rollno start for 2022
            pstmt2022.setString(3, "20BQ1A0396"); // Set Rollno end for 2022
            rs2022 = pstmt2022.executeQuery();
    %>
    
    <h3>Batch 2021</h3>
    <table border="1">
        <tr>
           
            <th>Name</th>
            <th>Enrollment Year</th>
            <th>Roll Number</th>
        </tr>
        
        <% 
            // Iterate over the result set for 2021 batch and display data
            while (rs2021.next()) {
                String studentId = rs2021.getString("Name");
                int enrollmentYear = rs2021.getInt("EnrollmentYear");
                String rollNumber = rs2021.getString("Rollno");
        %>
        
        <tr>
            <td><%= studentId %></td>
            <td><%= enrollmentYear %></td>
            <td><%= rollNumber %></td>
        </tr>
        
        <% 
            }
        %>
    </table>
    
    <h3>Batch 2022</h3>
    <table border="1">
        <tr>
            <th>Student ID</th>
            <th>Name</th>
            <th>Enrollment Year</th>
            <th>Roll Number</th>
        </tr>
        
        <% 
            // Iterate over the result set for 2022 batch and display data
            while (rs2022.next()) {
                String studentId = rs2022.getString("Name");
                int enrollmentYear = rs2022.getInt("EnrollmentYear");
                String rollNumber = rs2022.getString("Rollno");
        %>
        
        <tr>
            <td><%= studentId %></td>
            <td><%= enrollmentYear %></td>
            <td><%= rollNumber %></td>
        </tr>
        
        <% 
            }
        %>
    </table>
    
    <% 
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close JDBC objects in finally block to ensure they're closed properly
            try {
                if (rs2021 != null) rs2021.close();
                if (rs2022 != null) rs2022.close();
                if (pstmt2021 != null) pstmt2021.close();
                if (pstmt2022 != null) pstmt2022.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</body>
</html>
