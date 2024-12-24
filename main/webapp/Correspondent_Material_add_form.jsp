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
<%@ page import="Link.Link" %>
<%
	String user_id = request.getParameter("user_id");
	String department_id = request.getParameter("department_id");
	Integer message_count = 0;
	String emp_id = "";
	String add_form_link = "./Correspondent_Material_add_form.jsp?user_id=" + user_id;
	
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
%>

<%
	conn = DBManager.getDBConnection();

	String cor_name = request.getParameter("cor_name");
	String cor_tel = request.getParameter("cor_tel");
	String material = request.getParameter("material");
	String origin = request.getParameter("origin");
	
	
	boolean isSuccess = false;

	sql = "INSERT INTO correspondent_material(cor_name, cor_tel, material, origin) "
				 + "VALUES (?, ?, ?, ?)";
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cor_name);
		pstmt.setString(2, cor_tel);
		pstmt.setString(3, material);
		pstmt.setString(4, origin);
		
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
   location.href = './Correspondent_Material.jsp?user_id=' + '<%= user_id%>';
   </script>
<%
   } else {
%>
<script>
   alert('추가되지않았습니다.');
   location.href = './Correspondent_Material.jsp?user_id=' + '<%= user_id%>';
</script>
<%
   }
%>