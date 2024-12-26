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
	String hist_num = request.getParameter("hist_num");
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
	
	sql = "DELETE FROM history WHERE product_hist_num = ?";
	
	try{
		conn = DBManager.getDBConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(hist_num));
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<%
   if(isSuccess){
%>
   <script>
   alert('삭제되었습니다.');
   location.href = './Quality_Control.jsp?user_id=' + '<%= user_id %>';
   </script>
<%
   } else {
%>
<script>
   alert('삭제되지않았습니다.');
   location.href = './Human_Resource.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>