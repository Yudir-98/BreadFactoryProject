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

	String user_id = request.getParameter("user_id");
	String user_password = request.getParameter("user_password");
	String user_email = request.getParameter("user_email");
	String user_nickname = request.getParameter("user_nickname");
	Integer emp_id = Integer.parseInt(request.getParameter("emp_id"));
	String emp_name = request.getParameter("emp_name");
	Date birth_date = Date.valueOf(request.getParameter("birth_date"));
	String phone_number = request.getParameter("phone_number");
	Date hire_date = Date.valueOf(request.getParameter("hire_date"));
	String position = request.getParameter("position");
	Integer salary = Integer.parseInt(request.getParameter("salary"));
	Integer dept_id = Integer.parseInt(request.getParameter("dept_id"));
	
	boolean isSuccess = false;

	String sql = "INSERT INTO users(user_id, user_password, user_email, user_nickname) "
				 + "VALUES (?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		pstmt.setString(2, user_password);
		pstmt.setString(3, user_email);
		pstmt.setString(4, user_nickname);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
	} catch(Exception e) {
		e.printStackTrace();
		//exit();
	}
	
	conn = DBManager.getDBConnection();
	
	sql = "INSERT INTO employees(emp_id, emp_name, birth_date, hire_date, phone_number, user_id, position, salary) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, emp_id);
		pstmt.setString(2, emp_name);
		pstmt.setDate(3, birth_date);
		pstmt.setDate(4, hire_date);
		pstmt.setString(5, phone_number);
		pstmt.setString(6, user_id);
		pstmt.setString(7, position);
		pstmt.setInt(8, salary);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
		
	}  catch(Exception e) {
		e.printStackTrace();
		//exit();
	}
	
	conn = DBManager.getDBConnection();
	
	sql = "INSERT INTO dept_emp(dept_id, emp_id) "
			+ "VALUES(?, ?)";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, dept_id);
		pstmt.setInt(2, emp_id);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		
		isSuccess = true;
	}  catch(Exception e) {
		e.printStackTrace();
		//exit();
	}
%>
<%
   if(isSuccess){
%>
   <script>
   alert('추가되었습니다.');
   location.href = './Board.jsp'
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Board_add.jsp'
</script>
<%
   }
%>