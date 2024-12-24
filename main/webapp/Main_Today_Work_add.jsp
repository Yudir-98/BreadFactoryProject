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
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%

	String user_id = request.getParameter("user_id");
	String department_id = request.getParameter("department_id");
	String today_work = request.getParameter("today_work");
	Random random = new Random();
	Integer work_num = random.nextInt(2000) + 1;
	LocalDateTime now = LocalDateTime.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	Date formattedDate = Date.valueOf(now.format(formatter));
	String emp_id = "";
	
	Connection conn = DBManager.getDBConnection();

	String sql = "SELECT b.emp_id, c.dept_id " +
			 "FROM USERS a, EMPLOYEES b, DEPT_EMP c " +
			 "WHERE a.user_id=b.user_id AND b.emp_id=c.emp_id " +
			 "AND a.user_id = ?";

	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		emp_id = rs.getString("emp_id");
		department_id = rs.getString("dept_id");
		
		DBManager.dbClose(conn, pstmt, rs);
	} catch (Exception e) {
		e.printStackTrace();
	}

	
    
	
	boolean isSuccess = false;
	
	conn = DBManager.getDBConnection();
	sql = "INSERT INTO today_work(work_num, emp_id, work, checked, start_date) "
				 + "VALUES (?, ?, ?, 0, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, work_num);
		pstmt.setString(2, emp_id);
		pstmt.setString(3, today_work);
		pstmt.setDate(4, formattedDate);
		
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
   location.href = './Main.jsp?user_id=' + '<%= user_id %>'; 
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Main.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>