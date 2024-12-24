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

	Integer product_hist_num= Integer.parseInt(request.getParameter("product_hist_num"));
	String product_name = request.getParameter("product_name");
	Integer production = Integer.parseInt(request.getParameter("production"));
	String defective = request.getParameter("defective");
	Date reporting_date = Date.valueOf(request.getParameter("reporting_date"));
	Integer product_id = 0;

	String sql = "SELECT a.product_id " +
				 "FROM PRODUCTS a, HISTORY b " +
				 "WHERE a.product_id = b.product_id " +
				 "AND a.product_name = ?";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, product_name);
		
		ResultSet rs = pstmt.executeQuery();
		
		product_id = rs.getInt("product_id");
		
		DBManager.dbClose(conn, pstmt, rs);
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	boolean isSuccess = false;

	sql = "INSERT INTO History(product_hist_num, product_id, production, consumption, defective, reporting_date) "
				 + "VALUES (?, ?, ?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,product_hist_num );
		pstmt.setInt(2,  product_id);
		pstmt.setInt(3, production);
		pstmt.setString(4, null);
		pstmt.setString(5, defective);
		pstmt.setDate(6, reporting_date);
		
		pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
		 isSuccess=true;
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
   location.href = './Human_Resource.jsp'
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Human_Resource_add.jsp'
</script>
<%
   }
%>