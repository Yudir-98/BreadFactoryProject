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
		
		Integer product_id = Integer.parseInt(request.getParameter("product_id"));
		String product_name = request.getParameter("product_name");
		Integer expected_production = Integer.parseInt(request.getParameter("expected_production"));
		Integer expected_consumption = Integer.parseInt(request.getParameter("expected_consumption"));
		Integer consumer_price = Integer.parseInt(request.getParameter("consumer_price"));
		Integer cost = Integer.parseInt(request.getParameter("cost"));
		
		boolean isSuccess = false;
		
		String sql = "INSERT INTO products(product_id, product_name, expected_production, expected_consumption, consumer_price, cost) "
				 + "VALUES (?, ?, ?, ?, ?, ?)";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, product_name);
			pstmt.setInt(3, expected_production);
			pstmt.setInt(4, expected_consumption);
			pstmt.setInt(5, consumer_price);
			pstmt.setInt(6, cost);
			
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
   location.href = './Production_Status.jsp';
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = 'Production_Status_Add./.jsp'
</script>
<%
   }
%>