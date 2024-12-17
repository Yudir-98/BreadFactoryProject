<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	// 한글 처리
	// request.setCharacterEncoding("UTF-8");  // 한글이 안될 경우 사용

	// request라는 변수는 tomcat-servlet에서 요청에 대한 정보를 담아서 사용하는 객체
	// input의 name이 subject의 값을 가져옴
	String id = request.getParameter("id-box");
	System.out.println("id: " + id);
	
	String password = request.getParameter("password-box");
	System.out.println("password: " + password);

	// java로 sql실행하여 데이터 삽입하기
	Connection conn = DBManager.getDBConnection();
	
	String sql = "SELECT user_id, user_password FROM USERS " 
				+ "WHERE user_id = ? AND user_password = ?";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		
		// SQL문을 진짜 실행
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
%>
로그인 되었습니다.
<%
		}

		DBManager.dbClose(conn, pstmt, null);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
%>
<script>

</script>