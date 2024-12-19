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
	request.setCharacterEncoding("UTF-8");

	// request라는 변수는 tomcat-servlet에서 요청에 대한 정보를 담아서 사용하는 객체
	// input의 name이 subject의 값을 가져옴
	String user_id = request.getParameter("id-box");
	System.out.println("id: " + user_id);
	
	String password = request.getParameter("password-box");
	System.out.println("password: " + password);
	
	String department_id="";

	// java로 sql실행하여 데이터 삽입하기
	Connection conn = DBManager.getDBConnection();
	
	String sql = "SELECT a.user_id, a.user_password, b.emp_id, c.dept_id " +
				 "FROM USERS a, EMPLOYEES b, DEPT_EMP c " +
				 "WHERE a.user_id = b.user_id AND b.emp_id = c.emp_id " +
				 "AND a.user_id = ? AND a.user_password = ?";
	
	String destination_page = "";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		pstmt.setString(2, password);
		
		// SQL문을 진짜 실행
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			department_id = rs.getString("dept_id");
			destination_page = "./Main.jsp?user_id=" + user_id + "&department_id=" + department_id;
		} else {
%>
			<script>
				alert("아이디 혹은 비밀번호가 잘못되었습니다.");
			</script>
<%
			destination_page = "./LoginPage.jsp";
		}
		
		DBManager.dbClose(conn, pstmt, null);
	} catch (Exception e) {
		e.printStackTrace();
	}

	
%>
<script>
	location.href = '<%= destination_page%>';
</script>