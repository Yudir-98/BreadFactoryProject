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
	String user_id = request.getParameter("user_id");
	Integer budget_no = Integer.parseInt(request.getParameter("budget_no"));
	Integer emp_id = Integer.parseInt(request.getParameter("emp_id"));
	String finance = request.getParameter("finance");
	Integer cash = Integer.parseInt(request.getParameter("cash"));
	String reason = request.getParameter("reason");
	Date reporting_date = Date.valueOf(request.getParameter("reporting_date"));
	
	
	//실제 db에서 수정하는 코드
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE budget " +
			 "SET finance = ?, cash = ?, reason = ?, reporting_date = ? " +
			 "WHERE budget_no = ?";

		boolean isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finance);
			pstmt.setInt(2, cash);
			pstmt.setString(3, reason);
			pstmt.setDate(4, reporting_date);
			pstmt.setInt(5, budget_no);
			
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
   location.href = './Accounting.jsp?user_id=' + '<%=user_id%>';
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Accounting.jsp?user_id=' + '<%=user_id%>';
</script>
<%
   }
%>