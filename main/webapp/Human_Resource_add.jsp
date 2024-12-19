<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%
	String user_id = request.getParameter("user_id");
%>
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
        사원 번호 &nbsp;&nbsp;&nbsp;: <input type="text" placeholder="사원 번호를 입력해 주세요." required>
        <br>
        사원 이름 &nbsp;&nbsp;&nbsp;: <input type="text" placeholder="사원 이름을 입력해 주세요." required>
        <br>
        생년월일 &nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" placeholder="생년월일을 입력해 주세요." required>
        <br>
        핸드폰번호 &nbsp;: <input type="text" placeholder="핸드폰번호를 입력해 주세요." required>
        <br>
        입사일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" placeholder="입사일을 입력해 주세요." required>
        <br>
        <form action="">직책 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select name="position" required="">
          <option value="팀원">팀원</option>
          <option value="이사">팀장</option>
          <option value="팀장">이사</option>
        </select>
        </form>
        급여 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" placeholder="급여를 입력해 주세요." required>
        <hr>
        아이디 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" placeholder="아이디를 입력해 주세요." required>
        <br>
        비밀번호 &nbsp;&nbsp;&nbsp;: <input type="password" placeholder="비밀번호를 입력해 주세요." required>
        <br>
        이메일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="email" placeholder="이메일을 입력해 주세요." required>
        <br>
        닉네임 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" placeholder="닉네임을 입력해 주세요." >
        <div class="buttons">
        <button class="complete-button">완료</button>
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
		location.href = './Human_Resource.jsp'
	});
  </script>
</body>
</html>