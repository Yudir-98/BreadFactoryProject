<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>

<%
	Connection conn = DBManager.getDBConnection();

	String emp_id = request.getParameter("emp_id");
	String user_id = "";
	
	conn = DBManager.getDBConnection();
	
	String sql = "SELECT a.user_id " +
				 "FROM USERS a, EMPLOYEES b " +
				 "WHERE a.user_id = b.user_id " +
				 "AND b.emp_id = ?";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(emp_id));
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		user_id = rs.getString("user_id");
		
		DBManager.dbClose(conn, pstmt, rs);
	} catch(Exception e){
		e.printStackTrace();
	}
	
	boolean isSuccess = false;
	
	sql = "DELETE FROM dept_emp WHERE emp_id = ?";
	
	try{
		conn = DBManager.getDBConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(emp_id));
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	} catch(Exception e){
		e.printStackTrace();
	}
	
	sql = "DELETE FROM employees WHERE emp_id = ?";
	
	try{
		conn = DBManager.getDBConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(emp_id));
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	} catch(Exception e){
		e.printStackTrace();
	}
	
	sql = "DELETE FROM users WHERE user_id = ?";
	
	try{
		conn = DBManager.getDBConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
		isSuccess = true;
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<%
   if(isSuccess){
%>
   <script>
   alert('삭제되었습니다.');
   location.href = './Accounting.jsp';
   </script>
<%
   } else {
%>
<script>
   alert('삭제되지않았습니다.');
   location.href = './Accounting.jsp';
</script>
<%
   }
%>