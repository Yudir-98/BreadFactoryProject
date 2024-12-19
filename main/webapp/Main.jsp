<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%@ page import="Link.Link" %>
<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");
	String department_id = request.getParameter("department_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Main</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Main.css">
</head>
<body>
  <div class="fullScreen">
  <div class=box-for-div></div>
  
<!-- 메뉴 바 -->

	<div class="MenuButton">
      <div class="menuButtonBar"></div>
      <div class="menuButtonBar"></div>
      <div class="menuButtonBar"></div>
    </div>
	<div class="Workmenu">
        <div class="WelcomeFont">환영합니다!</div>
        <div class="division_line"></div>
        <span class="WorksBox_Tag">- Works</span>
        <div class="menu_WorksBox">
          <ul class="Menu_Works">
          
<%
			Connection conn = DBManager.getDBConnection();

			String sql ="SELECT work FROM DEPT_WORK " +
						"WHERE dept_id = ?";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, department_id);
				
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
					
					String work = rs.getString("work");
					String Page_Link = Link.getPageLink(work) + "?user_id=" + user_id + "&department_id=" + department_id;
%>
					<li class="work_list"><a href=<%= Page_Link %>><%= rs.getString("work") %></a></li>
<%
				}
				
				DBManager.dbClose(conn, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
%>
          </ul>
        </div>
        <span class="company_board">- 사내 게시판</span>
        <div class="Menu_BoardBox">
        	<ul class="Menu_Boards">
        		<li class="board_list"><a>사내 게시판</a></li>
        	</ul>
        	<ul class="socials">
	          <li><a href="#" id="instagram"><i class="fa-brands fa-instagram"></i></a></li>
	          <li><a href="#" id="facebook"><i class="fa-brands fa-square-facebook"></i></a></li>
	          <li><a href="#" id="youtube"><i class="fa-brands fa-youtube"></i></a></li>
	        </ul>
        </div>	
    </div>
      
<!-- 시계 --> 
    <div class="DateTime">
    	<div id="year"></div>
    	<div id="clock"></div>
    </div>
    
<!-- 메인 콘텐츠 -->
    <div class="MainContent">
    <!-- 공지사항 -->
      <div class="Announcement">
        <div class="notices">
          <div class="notice" id="notice1"></div>
          <div class="notice" id="notice2"></div>
          <div class="notice" id="notice3"></div>
        </div>
      </div>
    <!-- 메인 콘텐츠 박스 1 -->
      <div class="Main_ContentBox1">
        <div class="TodayWork"></div>
      </div>
      
    <!-- 메인 콘텐츠 박스 2 -->
      <div class="Main_ContentBox2">
        <div class="SecBox1"></div>
        <div class="SecBox2"></div>
      </div>
    </div>
	
<!-- 로그인 창 -->
    <div class="Personal">
      <div id="Login_box"></div>
      <div id="message_box"></div>
      <div id="Logout_box"><a href='./Main.jsp'>로그아웃</a></div>
    </div>
    
    
    
  </div>
  <script>
  	let user_id = "<%= user_id %>";
    let MenuButton = document.querySelector(".MenuButton");
    let Workmenu = document.querySelector(".Workmenu");
    let MainContent = document.querySelector(".MainContent");
    let menu_WorksBox = document.querySelector(".menu_WorksBox");
    let WorksBox_Tag = document.querySelector(".WorksBox_Tag");
    let DateTime = document.querySelector(".DateTime");
    let clock = document.getElementById("clock");
    let yearTag = document.getElementById("year");
    let messageBox = document.querySelector("#message_box");
    let LoginBox = document.querySelector("#Login_box");
    let LogoutBox = document.querySelector("#Logout_box");
    let LogoutBox_opend = false;
    
    
   	if(user_id == "null") {
   		messageBox.style.opacity = 0;
   		messageBox.disabled = true;
   		LoginBox.addEventListener('click', function() {
   			location.href='./LoginPage.jsp';
   		});
   	} else {
   		messageBox.style.opacity = 1;
   		LoginBox.addEventListener('click', function() {
   			LogoutBox.disabled = false;
   			LogoutBox_opend = true;
   			Logout_open();
   		});
   	}

    MenuButton.addEventListener ('click', function() {
    	MenuButton.style.opacity = 0;
    	Workmenu.style.opacity = 0.7;
    	Workmenu.style.left = '0.5vw';
    	MainContent.style.opacity = 0.3;
    	DateTime.style.opacity = 0.1;
    });

    document.addEventListener ('click', function(event) {
    	if (!Workmenu.contains(event.target) && !MenuButton.contains(event.target)) {
	        Workmenu.style.opacity = 0.0;
	        Workmenu.style.left = '-400px';
	        MenuButton.style.opacity = 1;
	        MainContent.style.opacity = 1;
	        DateTime.style.opacity = 1;
      }
    });
    
    WorksBox_Tag.addEventListener ('click', function() {
    	WorkBox_open();
    });
    
    function WorkBox_open() {
    	if(menu_WorksBox.style.height == '0px') {
    		menu_WorksBox.style.height = 'auto';
    	} else {
    		menu_WorksBox.style.height = '0px';
    	}
    }
    
    function Logout_open() {
    	if(LogoutBox.style.height == '0px') {
			LogoutBox.style.height = '50px';
		} else {
			LogoutBox.style.height = '0px';
		}
    }
    
    function updateClock() {
    	let now = new Date();
    	let hours = now.getHours().toString().padStart(2, '0');
    	let minutes = now.getMinutes().toString().padStart(2, '0');
    	let year = now.getFullYear();
    	let month = now.getMonth();
    	let day = now.getDate();
    	
    	let yearString = year + '-' + month + '-' + day;
    	let timeString = hours + ':' + minutes + " ";
    	clock.textContent = timeString;
    	yearTag.textContent = yearString;
    }
    
    updateClock();
    setInterval(updateClock, 1000);
  </script>
</body>
</html>