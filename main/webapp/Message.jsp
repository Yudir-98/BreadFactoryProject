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
  <title>메일함</title>
<!-- 긁어오기 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Message.css">
  <style>
  	@font-face {
	   font-family: 'Moneygraphy-Roundend';
	   src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
	}
	
	body {
		font-family: 'Moneygraphy-Roundend';
	}
  </style>
</head>
<body>
  <div class="fullScreen">    
<!-- 메인콘텐츠 -->
    <div class="MainContent">
      
      <div class="Announcement">
        <h1>메일함</h1>
      </div>
      <div class="void_for_button"><button class="add-button">메시지 작성</button></div>
      <div class="MainContentBox">
        <div class="title">
          <div class="title1"><p><b>발송자</b></p></div>
          <div class="title2"><p><b>메시지내용</b></p></div>
        </div>
        <div class="RowLine"></div>
        <div class="content">
          <ul class="emp-id">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT sender " +
					 "FROM MESSAGES " +
					 "WHERE user_id = ?";
		
		if(department_id.equals("1")) sql="SELECT work FROM DEPT_WORK ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			if(!(department_id.equals("1"))) pstmt.setString(1, department_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			String sender;
			
			while(rs.next()) {
				sender = rs.getString("sender");
%>
		<li><%= sender %></li>
<%
			}
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
          </ul>
          <ul class="RightLine1"></ul>
          <ul class="emp-name">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT message " +
			  "FROM MESSAGES " +
			  "WHERE user_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			String message;
			while(rs.next()) {
				message = rs.getString("message");
%>
				<li><%= message %></li>
<%
			}
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
          </ul>
          <ul class="RightLine4"></ul>
          
          <ul class="remake">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT message_no " +
				 "FROM MESSAGES " +
				 "WHERE user_id = ?";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			ResultSet rs = pstmt.executeQuery();
		 while(rs.next()){			 
%>
	<li>
		<button class="delete-button" message_no="<%= rs.getInt("message_no") %>">삭제</button>
	</li>
<%
		 }
		DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		  </ul>
		  <div class="height-box"></div>
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
			
			if(department_id.equals("1")) sql="SELECT work FROM DEPT_WORK ";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				if(!(department_id.equals("1"))) pstmt.setString(1, department_id);
				
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
	let Menu_BoardBox = document.querySelector(".Menu_BoardBox");
  
//------------ Personal 박스 --------------------
	let messageBox = document.querySelector("#message_box");
	let LoginBox = document.querySelector("#Login_box");
	let LogoutBox = document.querySelector("#Logout_box");
	let MainContent = document.querySelector(".MainContent");
	let LogoutBox_opend = false;
  
  	//add-button 누르면 인원 추가
  	let addbutton = document.querySelector('.add-button');
  	
  	addbutton.addEventListener('click', function(){
  		location.href = './Message_send.jsp?user_id=' + "<%= user_id %>";
  	});
  	
  	// 수정 버튼 누르면 수정
  	let updatebutton = document.querySelectorAll(".update-button");

  	for(let i = 0; i < updatebutton.length; i++) {
  		updatebutton[i].addEventListener('click', function(){
  	  		const emp_id = updatebutton[i].getAttribute("emp-id");
  	  		location.href = './Human_Resource_update.jsp?emp_id=' + emp_id;
  	  	});
  	}
	
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

// ------------ 메뉴 박스 --------------------
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
    
    Menu_BoardBox.addEventListener ('click', function() {
    	location.href='./Board.jsp?user_id=' + '<%= user_id %>';
    });
    
 // ------------ Personal 함수 --------------------
    function Logout_open() {
    	if(LogoutBox.style.height == '0px') {
			LogoutBox.style.height = '50px';
		} else {
			LogoutBox.style.height = '0px';
		}
    }  	

 
    let deletebutton = document.querySelectorAll(".delete-button");

  	for(let i = 0; i < deletebutton.length; i++) {
  		deletebutton[i].addEventListener('click', function(){
  	  		const message_no = deletebutton[i].getAttribute("message_no");
  	  		if(confirm('삭제하시겠습니까?')){
  	  		location.href = './Message_delete.jsp?message_no=' + message_no + '&user_id=' + '<%= user_id %>';
  	  		}
  	  		
  	  	});
  	}
  </script>
</body>
</html>