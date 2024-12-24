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
<%@ page import="java.util.Random" %>
<%
	Connection conn = DBManager.getDBConnection();

	String sender = request.getParameter("user_id");
	String user_id = request.getParameter("destination_id");
	String message = request.getParameter("message");
	Random random = new Random();
	Integer message_no = random.nextInt(2000) + 1;
	
	boolean isSuccess = false;

	String sql = "INSERT INTO messages(user_id, sender, message, read, message_no) "
				 + "VALUES (?, ?, ?, 0, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		pstmt.setString(2, sender);
		pstmt.setString(3, message);
		pstmt.setInt(4, message_no);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
		isSuccess = true;
	} catch(Exception e) {
		e.printStackTrace();
	}
%>	

<%
   if(isSuccess){
%>
   <script>
   alert('추가되었습니다.');
   location.href = './Message.jsp?user_id=' + user_id;
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = 'Message.jsp?user_id=' + user_id;
</script>
<%
   }
%>