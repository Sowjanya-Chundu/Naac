<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String firstname=request.getParameter("firstname");
String lastname=request.getParameter("lastname");
String gender=request.getParameter("gender");
int numb=Integer.parseInt(request.getParameter("numb"));
String bday=request.getParameter("bday");
String email=request.getParameter("email");
String dept=request.getParameter("dept");
int rollno=Integer.parseInt(request.getParameter("rollno"));
int mobileno=Integer.parseInt(request.getParameter("mobileno"));
int status=0;

try {
 
 Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vvit","root","sowjanyapassword");
	
 PreparedStatement ps=con.prepareStatement("insert into studentdetails(firstname,lastname,gender,numb,bday,email,dept,rollno,mobileno) values(?,?,?,?,?,?,?,?,?)");
 ps.setString(1, firstname);
 ps.setString(2, lastname);
 ps.setString(3, gender);
 ps.setInt(4, numb);
 ps.setString(5,bday);
 ps.setString(6,email);
 ps.setString(7,dept);
 ps.setInt(8,rollno);
 ps.setInt(9,mobileno);
 status=ps.executeUpdate();
 out.print(status);
 if(status>0) {
	 out.println("<p>records saved successfully</p>");
	
 }else {
	 out.println("<p>sorry records not successful");

 }
	
	

 
 
}catch(Exception e) {
 out.println(e);
 
}

%>
</body>
</html>