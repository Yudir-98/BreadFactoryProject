<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	String cor_name = request.getParameter("cor_name");
	String cor_address = request.getParameter("cor_address");
	String cor_tel = request.getParameter("cor_tel");
	
	String user_id = request.getParameter("user_id");
	String department_id = request.getParameter("department_id");
	String emp_id = "";
	
	//java로 sql실행하여 데이터 삽입하기
	Connection conn = DBManager.getDBConnection();
	
	String sql = "SELECT c.dept_id " +
				 "FROM USERS a, EMPLOYEES b, DEPT_EMP c " +
				 "WHERE a.user_id=b.user_id AND b.emp_id=c.emp_id " +
				 "AND a.user_id = ?";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		department_id = rs.getString("dept_id");
		
		DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	//실제 db에서 수정하는 코드
	conn = DBManager.getDBConnection();
	
	sql = "UPDATE correspondent_product " +
			 "SET cor_name = ?, cor_address = ?, cor_tel = ?" +
			 "WHERE cor_name = ?";

		boolean isSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cor_name);
			pstmt.setString(2, cor_address);
			pstmt.setString(3, cor_tel);
			pstmt.setString(4, cor_name);
			
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
   location.href = './Correspondent_Product.jsp?user_id=' + '<%= user_id%>';
   </script>
<%
   } else {
%>
<script>
   alert('수정에 실패하였습니다.');
   location.href = './Correspondent_Product.jsp?user_id=' + '<%= user_id %>';
</script>
<%
   }
%>