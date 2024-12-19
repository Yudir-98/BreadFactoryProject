<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%

	Connection conn = DBManager.getDBConnection();

	String emp_id = request.getParameter("emp_id");
	String emp_id_now = emp_id;
	String emp_name = "";
	String birth_date = "";
	String phone_number = "";
	String hire_date = "";
	String position = "";
	String salary = "";
	String user_id = "";
	String user_password = "";
	String user_email = "";
	String user_nickname = "";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수정 페이지</title>
<link rel="stylesheet" href="./css/Human-Resource-update.css">
</head>
<body>
	<div class="fullScreen">
		<div class="MainContent">
			<div class="Announcement">
				<h1>&nbsp;수 정</h1>
			</div>
      <div class="content">
<% 
		conn = DBManager.getDBConnection();
		
		String sql = "SELECT a.emp_id, a.emp_name, a.birth_date, a.phone_number, a.hire_date, c.dept_name, a.position, a.salary, d.user_id, d.user_password, d.user_email, d.user_nickname " +
			 	"FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c, USERS d " + 
				"WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id AND a.user_id = d.user_id " +
			 	"AND a.emp_id = ? ";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, emp_id_now);
			
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			emp_name = rs.getString("emp_name");
			birth_date = rs.getString("birth_date");
			phone_number = rs.getString("phone_number");
			hire_date = rs.getString("hire_date");
			position = rs.getString("position");
			salary = rs.getString("salary");
			user_id = rs.getString("user_id");
			user_password = rs.getString("user_password");
			user_email = rs.getString("user_email");
			user_nickname = rs.getString("user_nickname");
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		<form id="form_information" action="./Human_Resource_update_form.jsp" method="POST">
	        사원 번호 &nbsp;&nbsp;&nbsp;: <input type="text" value="<%= emp_id %>" name="emp_id" required>
	        <br>
	        사원 이름 &nbsp;&nbsp;&nbsp;: <input type="text" value="<%= emp_name %>" name="emp_name" required>
	        <br>
	        생년월일 &nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= birth_date %>" name="birth_date" required>
	        <br>
	        핸드폰번호 &nbsp;: <input type="text" value="<%= phone_number %>" name="phone_number" required>
	        <br>
	        입사일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= hire_date %>" name="hire_date" required>
	        <br>
	        직책 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= position %>" name="position" required>
	        <br>
	        급여 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= salary %>" name="salary" required>
	        <hr>
	        아이디 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= user_id %>" name="user_id" required>
	        <br>
	        비밀번호 &nbsp;&nbsp;&nbsp;: <input type="password" value="<%= user_password %>" name="user_password" required>
	        <br>
	        이메일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="email" value="<%= user_email %>"  name="user_email" required>
	        <br>
	        닉네임 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" value="<%= user_nickname %>" name="user_nickname" >
	         </form>
	        <div class="buttons">
	        <button class="update-button">수정</button>
	        <button class="cancel-button">취소</button>
       
        </div>
      </div>
		</div>
		<div class="Personal">
	      <div id="login_box"></div>
	      <div id="message_box"></div>
    	</div>
    	<div class="Menu">
	      <div class="menu1"></div>
	      <div class="menu2"></div>
	      <div class="menu3"></div>
	    </div>
	</div>
	<script>
	//취소 버튼 눌렀을 때
	let cancelbutton = document.querySelector('.cancel-button');
	
	cancelbutton.addEventListener('click', function(){
		location.href = './Human_Resource.jsp'
	});
	//수정 버튼 눌렀을 때
	let updatebutton = document.querySelector('.update-button');
	const form_information = document.getElementById('form_information');
	
	updatebutton.addEventListener('click', function(){
		event.preventDefault();  // 기본 동작을 막음
	    
	    form_information.submit();   // form1의 action값으로 input데이터를 이동
	});
	</script>
</body>
</html>