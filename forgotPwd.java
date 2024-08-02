package JavaFiles;

import java.io.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ServletClasses.DBConnect;

@WebServlet(name = "forgot", urlPatterns = { "/forgot" })
public class forgotPwd extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			Connection con = DBConnect.connect();
			String uname = request.getParameter("uname");
			String pass1 = request.getParameter("pwd1");
			String pass2 = request.getParameter("pwd2");
			PrintWriter out = response.getWriter();
			boolean flag = pass1.equals(pass2);
			if(!flag) {
				out.println("<script>");
				out.println("alert('Please enter the same password in both fields');");
				out.println("window.open('forgotPass.jsp','_self');");
				out.println("</script>");
			}
			else {
				PreparedStatement st = con.prepareStatement("update users set password=? where uname=?");
				st.setString(1, pass2);
				st.setString(2, uname);
				
				//RequestDispatcher dispatcher = null;
				ResultSet rs=st.executeQuery();
				
				if(rs.next() ) {
					request.setAttribute("status", "success");
					out.println("<script>");
					out.println("alert('Successfully Changed the Password!!!');");
					out.println("window.open('loginPage.jsp','_self');");
					out.println("</script>");
				}
				else {
					request.setAttribute("status", "failed");
					out.println("<script>");
					out.println("alert('Can't update the password');");
					out.println("window.open('forgotPass.jsp','_self');");
					out.println("</script>");
				}
				//dispatcher.forward(request, response);
				st.close();
				con.close();
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse   response) throws ServletException, IOException {
        doPost(request, response);
	}


}
