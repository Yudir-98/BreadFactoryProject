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

	String user_id = request.getParameter("user_id");
	String finance = request.getParameter("finance");
	Integer cash = Integer.parseInt(request.getParameter("cash"));
	String reason = request.getParameter("reason");
	Date reporting_date = Date.valueOf(request.getParameter("reporting_date"));
	Random random = new Random();
	Integer budget_no = random.nextInt(2000) + 1;
	
	
	boolean isSuccess = false;

	String sql = "INSERT INTO budget(finance, cash, reason, reporting_date) "
				 + "VALUES (?, ?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, budget_no);
		pstmt.setString(2, finance);
		pstmt.setInt(3, cash);
		pstmt.setString(4, reason);
		pstmt.setDate(5, reporting_date);
		
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
   location.href = './Accounting.jsp?user_id=' + '<%= user_id %>'
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Accounting_add.jsp?user_id=' + '<%= user_id %>'
</script>
<%
   }
%>