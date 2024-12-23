<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>

<%
	String material = request.getParameter("material");
	Integer amount = Integer.parseInt(request.getParameter("amount"));
	String unit = request.getParameter("unit");
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE material " +
				"SET material = ?, amount = ?, unit = ? " +
				"WHERE material = ?";
		boolean isSuccess = false;
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, material);
			pstmt.setInt(2, amount);
			pstmt.setString(3, unit);
			pstmt.setString(4, material);
			
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
   location.href = './Inventory.jsp'
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Inventory_Update.jsp'
</script>
<%
   }
%>