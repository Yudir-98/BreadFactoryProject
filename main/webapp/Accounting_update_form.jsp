<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	Integer emp_id = Integer.parseInt(request.getParameter("emp_id"));
	String emp_name = request.getParameter("emp_name");
	String birth_date = request.getParameter("birth_date");
	String phone_number = request.getParameter("phone_number");
	String hire_date = request.getParameter("hire_date");
	String position = request.getParameter("position");
	Integer salary = Integer.parseInt(request.getParameter("salary"));
	String user_id = request.getParameter("user_id");
	String user_password = request.getParameter("user_password");
	String user_email = request.getParameter("user_email");
	String user_nickname = request.getParameter("user_nickname");
	
	//실제 db에서 수정하는 코드
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE USERS " +
			 "SET user_password = ?, user_email = ?, user_nickname = ? " +
			 "WHERE user_id = ?";

		boolean isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_password);
			pstmt.setString(2, user_email);
			pstmt.setString(3, user_nickname);
			pstmt.setString(4, user_id);
			
			pstmt.executeUpdate();
			
			DBManager.dbClose(conn, pstmt, null);
			
			isSuccess = true;
		} catch (Exception e) {
		     e.printStackTrace();
		}
	
		conn = DBManager.getDBConnection();
		
		sql = "UPDATE EMPLOYEES " +
				  "SET emp_name = ?, phone_number = ?, position = ?, salary = ? " +
				  "WHERE emp_id = ?";
		isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, emp_name);
			pstmt.setString(2, phone_number);
			pstmt.setString(3, position);
			pstmt.setInt(4, salary);
			pstmt.setInt(5, emp_id);
			
			pstmt.executeUpdate();
			
			DBManager.dbClose(conn, pstmt, null);
			
			isSuccess = true;
		} catch (Exception e) {
		     e.printStackTrace();
		}
%>
<%
   if(isSuccess){
%>
   <script>
   alert('수정되었습니다.');
   location.href = './Accounting.jsp'
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Accounting_update.jsp'
</script>
<%
   }
%>