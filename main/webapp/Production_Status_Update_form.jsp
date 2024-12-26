<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	String product_name = request.getParameter("product_name");
	Integer expected_production = Integer.parseInt(request.getParameter("expected_production"));
	Integer expected_consumption = Integer.parseInt(request.getParameter("expected_consumption"));
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE products " +
				 "SET product_name = ?, expected_production = ?, expected_consumption = ? " +
				 "WHERE product_name = ?";
	boolean isSuccess = false;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, product_name);
		pstmt.setInt(2, expected_production);
		pstmt.setInt(3, expected_consumption);
		pstmt.setString(4, product_name);
		
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
   location.href = './Production_Status.jsp'
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Production_Status_Update.jsp'
</script>
<%
   }
%>