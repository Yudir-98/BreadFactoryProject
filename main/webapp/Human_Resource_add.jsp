<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>인원 추가</title>
  <link rel="stylesheet" href="./css/Human-Resource-add.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="Announcement">
        <h1>&nbsp;추 가</h1>
      </div>
      <div class="content">
		<form id="form_information" action="./Human_Resource_add_form.jsp" method="POST">
	        사원 번호 &nbsp;&nbsp;&nbsp;: <input type="text" name="emp_id" placeholder="사원 번호를 입력해 주세요.">
	        <br>
	        사원 이름 &nbsp;&nbsp;&nbsp;: <input type="text" name="emp_name" placeholder="사원 이름을 입력해 주세요." >
	        <br>
	        생년월일 &nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="birth_date" placeholder="YYYY-MM-DD형태로 입력해 주세요." >
	        <br>
	        핸드폰번호 &nbsp;: <input type="text" name="phone_number" placeholder="핸드폰번호를 입력해 주세요." >
	        <br>
	        입사일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="hire_date" placeholder="YYYY-MM-DD형태로 입력해 주세요." >
	        <br>
	        직책 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="position" placeholder="직책을 입력해 주세요.">
	        <br>
	        급여 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="salary" placeholder="급여를 입력해 주세요." >
	        <hr>
	        아이디 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="user_id" placeholder="아이디를 입력해 주세요." >
	        <br>
	        비밀번호 &nbsp;&nbsp;&nbsp;: <input type="password"  name="user_password" placeholder="비밀번호를 입력해 주세요." >
	        <br>
	        이메일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="email" name="user_email" placeholder="이메일을 입력해 주세요." >
	        <br>
	        닉네임 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="user_nickname" placeholder="닉네임을 입력해 주세요." >
	        <hr>
	        부서 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" name="dept_id" placeholder="2.인사 3.재무 4.분석 5.자재 6.생산 7.매장">
        </form>
        <div class="buttons">
        <button class="add-button">추가</button>
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
	  let cancelbutton = document.querySelector('.cancel-button');
		
		cancelbutton.addEventListener('click', function(){
			location.href = './Human_Resource.jsp';
		});
		
	  let addbutton = document.querySelector('.add-button');
	  
  	  addbutton.addEventListener('click', function(){
  		  const form_information = document.getElementById('form_information');
  		
 			  event.preventDefault();  // 기본 동작을 막음
 		    
 		      form_information.submit();   // form1의 action값으로 input데이터를 이동
  	  });
  </script>
</body>
</html>