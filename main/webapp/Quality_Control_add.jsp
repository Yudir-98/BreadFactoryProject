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
	String user_id = request.getParameter("user_id");
	String department_id = request.getParameter("department_id");
	Integer message_count = 0;
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>인원 추가</title>
  <link rel="stylesheet" href="./css/Quality_Control_add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="Announcement">
        <h1>&nbsp;추 가</h1>
      </div>
      <div class="content">
      <form id="form_information" action="./Quality_Control_add_form.jsp" method="POST">
      생산 넘버 &nbsp;&nbsp;&nbsp;: <input name="product_hist_num" type="text" placeholder="생산 넘버를 입력해주세요." required>
        <br>
       품목 &nbsp;&nbsp;&nbsp;: <input name="product_name" type="text" placeholder="제품명을 입력해주세요." required>
        <br>
        생산량 &nbsp;&nbsp;&nbsp;: <input name="production" type="text" placeholder="생산 수량을 입력해 주세요." required>
        <br>
        불량품 &nbsp;&nbsp;&nbsp;: <input name="defective" type="text" placeholder="불량 수량을 입력해 주세요." required>
        <br>
        날짜 &nbsp;&nbsp;&nbsp;&nbsp;: <input name ="reporting_date" type="text" placeholder="날짜를 입력해 주세요." required>
		</form>
        <div class="buttons">
        <button class="complete-button">완료</button>
        <button class="cancel-button">취소</button>
        </div>
      </div>
    </div>

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
			conn = DBManager.getDBConnection();

			sql ="SELECT work FROM DEPT_WORK " +
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
<!-- 여기까지 -->

<!-- 로그인 창 -->
<%
	conn = DBManager.getDBConnection();

	sql ="SELECT message " + 
		 "FROM MESSAGES " +
		 "WHERE user_id = ? AND READ = 0";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			message_count++;
		}
		
		DBManager.dbClose(conn, pstmt, rs);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
    <div class="Personal">
      <div id="Login_box"><a id="Login_icon"><i class="fa-solid fa-user"></i></a></div>
      <div id="message_box">
      	<a id="Message_icon"><i class="fa-solid fa-envelope"></i></a>
      	<div class="message_amount"><span class="message_count"><%= message_count %></span></div>
      </div>
      <div id="Logout_box"><a href='./Main.jsp'>로그아웃</a></div>
    </div>
<!-- 여기까지 -->
    
  </div>
  <script>
//------------ 메뉴박스 --------------------
	let user_id = "<%= user_id %>";
	let MenuButton = document.querySelector(".MenuButton");
	let Workmenu = document.querySelector(".Workmenu");
	let menu_WorksBox = document.querySelector(".menu_WorksBox");
	let WorksBox_Tag = document.querySelector(".WorksBox_Tag");

//------------ Personal 박스 --------------------
	let messageBox = document.querySelector("#message_box");
	let LoginBox = document.querySelector("#Login_box");
	let LogoutBox = document.querySelector("#Logout_box");
	let MainContent = document.querySelector(".MainContent");
	let LogoutBox_opend = false;


	 // ------------ Personal 박스 --------------------
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
 	
 	messageBox.addEventListener ('click', function() {
 		location.href='./Message.jsp?user_id=' + "<%= user_id %>";
 	})

//------------ 메뉴 박스 --------------------
  MenuButton.addEventListener ('click', function() {
  	MenuButton.style.opacity = 0;
  	Workmenu.style.opacity = 0.7;
  	Workmenu.style.left = '0.5vw';
  	MainContent.style.opacity = 0.3;
  });

  document.addEventListener ('click', function(event) {
  	if (!Workmenu.contains(event.target) && !MenuButton.contains(event.target)) {
	        Workmenu.style.opacity = 0.0;
	        Workmenu.style.left = '-400px';
	        MenuButton.style.opacity = 1;
	        MainContent.style.opacity = 1;
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
  
// ------------ Personal 함수 --------------------
  function Logout_open() {
  	if(LogoutBox.style.height == '0px') {
			LogoutBox.style.height = '50px';
		} else {
			LogoutBox.style.height = '0px';
		}
  }  	

  let cancelbutton = document.querySelector('.cancel-button');
  let completebutton = document.querySelector('.complete-button');
	
	cancelbutton.addEventListener('click', function(){
		location.href = './Quality_Control.jsp'	
		
	});
	completebutton.addEventListener('click', function(){
		const form_information = document.getElementById('form_information')
		
		event.preventDefault();
			form_information.submit();
		
	});
	
	
  </script>
</body>
</html>