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
	String material = request.getParameter("material");
	Integer amount = Integer.parseInt(request.getParameter("amount"));
	String unit = request.getParameter("unit");
	
	boolean isSuccess = false;
	
	String sql = "INSERT INTO material(material, amount, unit) "
				 + "VALUES (?, ?, ?)";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, material);
		pstmt.setInt(2, amount);
		pstmt.setString(3, unit);
		
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
   location.href = './Inventory.jsp?user_id=' + '<%= user_id %>';
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Inventory_add.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>