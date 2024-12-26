<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	String user_id = request.getParameter("user_id");
	Integer emp_id = Integer.parseInt(request.getParameter("emp_id"));
	String finance = request.getParameter("finance");
	Integer cash = Integer.parseInt(request.getParameter("cash"));
	String reason = request.getParameter("reason");
	String reporting_date = request.getParameter("reporting_date");
	
	
	//실제 db에서 수정하는 코드
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE budget " +
			 "SET finance = ?, cash = ?, reason = ?, reporting_date = ? " +
			 "WHERE user_id = ?";

		boolean isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finance);
			pstmt.setInt(2, cash);
			pstmt.setString(3, reason);
			pstmt.setString(4, reporting_date);
			
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