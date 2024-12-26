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
	Integer emp_id = Integer.parseInt(request.getParameter("emp_id"));
	Integer hist_num = Integer.parseInt(request.getParameter("hist_num"));
	String product_name = request.getParameter("hist_num");
	Integer product_id = Integer.parseInt(request.getParameter("product_id"));
	Integer production = Integer.parseInt(request.getParameter("emp_id"));
	Integer consumption = Integer.parseInt(request.getParameter("emp_id"));
	Integer defective = Integer.parseInt(request.getParameter("emp_id"));
	Date reporting_date = Date.valueOf(request.getParameter("reporting_date"));
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "SLECT product_id " +
				 "FROM PRODUCTS " +
				 "WHERE product_name = ?";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, product_name);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		product_id = Integer.parseInt(rs.getString("product_id"));
		
		
		DBManager.dbClose(conn, pstmt, rs);
	} catch (Exception e) {
	     e.printStackTrace();
	}
	
	//실제 db에서 수정하는 코드
	conn = DBManager.getDBConnection();
	
	sql = "UPDATE history " +
			 "SET product_id = ?, production = ?, consumption = ?, defective = ?, reporting_date " +
			 "WHERE product_hist_num = ?";

		boolean isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setInt(2, production);
			pstmt.setInt(3, consumption);
			pstmt.setInt(4, defective);
			pstmt.setDate(5, reporting_date);
			
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
   location.href = './Quality_Control.jsp?user_id=' + '<%= user_id %>';
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Quality_Control.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>