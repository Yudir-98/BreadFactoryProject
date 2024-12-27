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
<%@ page import="java.time.Instant" %>
<%
	Connection conn = DBManager.getDBConnection();

	String user_id = request.getParameter("user_id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	LocalDate now = LocalDate.now();
	Date write_date = Date.valueOf(now);
	Random random = new Random();
	Integer bno = random.nextInt(5000) + 1;
	String nickname = "";
	
	String sql = "SELECT user_nickname " + 
			     "FROM users " +
				 "WHERE user_id = ?";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		nickname = rs.getString("user_nickname");
		
		DBManager.dbClose(conn, pstmt, rs);
		
	} catch(Exception e) {
		e.printStackTrace();
		//exit();
	}

	
	boolean isSuccess = false;
	
	conn = DBManager.getDBConnection();

	sql = "INSERT INTO board(bno, title, content, writer, nickname, write_date) "
				 + "VALUES (?, ?, ?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bno);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		pstmt.setString(4, user_id);
		pstmt.setString(5, nickname);
		pstmt.setDate(6, write_date);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
		isSuccess = true;
		
	} catch(Exception e) {
		e.printStackTrace();
		//exit();
	}
%>
<%
   if(isSuccess){
%>
   <script>
   alert('추가되었습니다.');
   location.href = './Board.jsp?user_id=' + '<%= user_id %>';
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Board_add.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>