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
	
	Integer message_no = Integer.parseInt(request.getParameter("message_no"));
	String user_id = "";
	
	boolean isSuccess = false;
	
	String sql = "DELETE FROM messages WHERE message_no = ?";
	
	try{
		conn = DBManager.getDBConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, message_no);
		
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
   location.href = './Message.jsp?user_id=' + <%= user_id %>;
   </script>
<%
   } else {
%>
<script>
   alert('삭제되지않았습니다.');
   location.href = './Message.jsp?user_id=' + <%= user_id %>;
</script>
<%
   }
%>