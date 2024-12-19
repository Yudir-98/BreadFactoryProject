<%@ page language="java" contentType="text/html; charset=uTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LoginPage</title>
  <link rel="stylesheet" href="./css/LoginPage.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div id="icon-box"></div>
      <form class="login-box" id="login-form" action="./Login.jsp" method="POST">
        <input class="input-box" id="id-box" name="id-box" type="text" placeholder="   사용자 아이디" required>
        <input class="input-box" id="password-box" name="password-box" type="password" placeholder="  사용자 비밀번호" required>
        <button class="login-button">로그인</button>
      </form>
    </div>
  </div>
  <script>
  	document.addEventListener("DOMContentLoaded", function() {
  		const LoginButton = document.querySelector(".login-button");
  		LoginButton.addEventListener("click" function(){
  			event.preventDefault();   // 기본 동작을 막음
  	        Login();
  		})
  	});
  	
  	function Login() {
  		if(!document.getElementById("id-box").value) {
      	  alert('아이디를 적어주세요.');
      	  return;
        }
  		
  		if(!document.getElementById("password-box").value) {
        	  alert('비밀번호를 적어주세요.');
        	  return;
        }
      	
        let loginForm = document.getElementById('login-form');
        loginForm.submit();	// from1의 action값으로 input 데이터를 이동
      }
  	}
  </script>
</body>
</html>