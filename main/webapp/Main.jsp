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
	String department_id = "0";
	Integer message_count = 0;
	String emp_id = "";
	String today_work_add_link = "./Main_Today_Work_add.jsp?user_id=" + user_id;
	String board_content_link = "./Board_Content.jsp?user_id=" + user_id + "&bno=";
	
	Connection conn = DBManager.getDBConnection();

	String sql = "SELECT b.emp_id, c.dept_id " +
				 "FROM USERS a, EMPLOYEES b, DEPT_EMP c " +
				 "WHERE a.user_id=b.user_id AND b.emp_id=c.emp_id " +
				 "AND a.user_id = ?";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		emp_id = rs.getString("emp_id");
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
  <title>Main</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Main.css">
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
        <div class="TodayWork">
        	<h1 class="today_work_title">오늘의할일</h1>
        	<button class="today_work_add_button">+</button>
        	<div class="today_work_add_box">
        		<form id="today_work_information" action="<%= today_work_add_link %>" method="POST">
        			<input type="text" id="today_work" name="today_work" placeholder="해야할 일을 작성하세요.">
        		</form>
        		<button class="today_work_add_accept">추가</button>
        	</div>
        	<ul class="today_work_list">
<%
			conn = DBManager.getDBConnection();
			
			sql ="SELECT work, work_num " + 
				 "FROM today_work " +
				 "WHERE emp_id = ?";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, emp_id);
				
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					String work_num = rs.getString("work_num");
%>
			<li class="today_work_li"><span class="today_work_check" work_num="<%= work_num %>">&check;</span><%= rs.getString("work") %></li>
<% 
				}
				
				DBManager.dbClose(conn, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
%>
        	</ul>
        </div>
      </div>
      
    <!-- 메인 콘텐츠 박스 2 -->
      <div class="Main_ContentBox2">
      <!-- 캘린더 -->
        <div class="SecBox1">
        	<div class="calendar">
		        <div class="week" id="week">
		            <!-- 일요일부터 토요일까지 미리 만든 div 요소들 -->
		            <div class="day" id="sun"><h4>일</h4><p></p></div>
		            <div class="day" id="mon"><h4>월</h4><p></p></div>
		            <div class="day" id="tue"><h4>화</h4><p></p></div>
		            <div class="day" id="wed"><h4>수</h4><p></p></div>
		            <div class="day" id="thu"><h4>목</h4><p></p></div>
		            <div class="day" id="fri"><h4>금</h4><p></p></div>
		            <div class="day" id="sat"><h4>토</h4><p></p></div>
		        </div>
		    </div>
        </div>
        <!-- 사내 게시판 -->
        <div class="SecBox2">
        	<div class="Board_Title">사내 게시판</div>
        	<div class="line_box_for_board"></div>
        	<div class="Board-Content">
        		<ul class="content_list">
       
<%
				//java로 sql실행하여 데이터 삽입하기
				conn = DBManager.getDBConnection();
				
				sql = "SELECT bno, title, writer, nickname, write_date " +
							 "FROM board";
				
				try {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					
					ResultSet rs = pstmt.executeQuery();
					
					Integer max_num = 0 ;
					while(rs.next() && max_num < 3) {
						Integer bno = rs.getInt("bno");
						String title = rs.getString("title");
						String writer = rs.getString("writer");
						String nickname = rs.getString("nickname");
						String write_date = rs.getString("write_date");
						
						String pre = board_content_link;
						board_content_link = board_content_link + bno;
		%>
				<li class="board_contents">
					<div class="board_content" id="title"><a href="<%= board_content_link %>"><%= title %></a></div>
					<div class="board_content" id="nickname"><%= nickname %></div>
				</li>
		<%
						board_content_link = pre;
						max_num++;
					}
					
					DBManager.dbClose(conn, pstmt, rs);
				} catch (Exception e) {
					e.printStackTrace();
				}
		%>
		       </ul>
        	</div>
        </div>
      </div>
    </div>
	
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
  
//------------ MainContent 박스 --------------------
	let Announcement = document.querySelector(".Announcement");
	let Notice1 = document.getElementById("notice1");
	let Notice2 = document.getElementById("notice2");
	let Notice3 = document.getElementById("notice3");
	let Today_Work_add_Button = document.querySelector(".today_work_add_button");
	let Today_Work_add_Box = document.querySelector(".today_work_add_box");
	let Today_Work_add_Accept = document.querySelector(".today_work_add_accept");
	let Today_Work_check = document.querySelectorAll('.today_work_check');
	let today = new Date();
	let daysOfWeek = {
            sun: document.getElementById('sun'),
            mon: document.getElementById('mon'),
            tue: document.getElementById('tue'),
            wed: document.getElementById('wed'),
            thu: document.getElementById('thu'),
            fri: document.getElementById('fri'),
            sat: document.getElementById('sat')
        };

// ------------ 메뉴박스 --------------------
  	let user_id = "<%= user_id %>";
    let MenuButton = document.querySelector(".MenuButton");
    let Workmenu = document.querySelector(".Workmenu");
    let menu_WorksBox = document.querySelector(".menu_WorksBox");
    let WorksBox_Tag = document.querySelector(".WorksBox_Tag");
    let Menu_BoardBox = document.querySelector(".Menu_BoardBox");
    
    
// ------------ 시계 --------------------
    let DateTime = document.querySelector(".DateTime");
    let clock = document.getElementById("clock");
    let yearTag = document.getElementById("year");

// ------------ Personal 박스 --------------------
    let messageBox = document.querySelector("#message_box");
    let LoginBox = document.querySelector("#Login_box");
    let LogoutBox = document.querySelector("#Logout_box");
    let MainContent = document.querySelector(".MainContent");
    let LogoutBox_opend = false;
    

<%
	conn = DBManager.getDBConnection();

	sql ="SELECT dept_id FROM DEPT_EMP " +
				"WHERE emp_id = ?";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, department_id);
		
		ResultSet rs = pstmt.executeQuery();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>


//------------ MainContent 박스 -------------------
	document.addEventListener('DOMContentLoaded', function() {
		//----------- 공지 사항 ----------
		Announcement.style.background = "url('./img/imge1.jpg') no-repeat center center";
		Announcement.style.bakcgroundSize = "cover";
		
		//----------- MainContentBox1 -------------
		Today_Work_add_Box.disabled = true;
		Today_Work_add_Box.style.width = '0px';
		Today_Work_add_Box.style.height = '0px';
		Today_Work_add_Box.style.opacity = 0;
	});
	
	//----------- 공지 사항 ----------
	Notice1.addEventListener('click', function() {
		Announcement.style.background = "url('./img/imge1.jpg') no-repeat center center";
		Announcement.style.bakcgroundSize = "cover";
	});
	
	Notice2.addEventListener('click', function() {
		Announcement.style.background = "url('./img/imge2.jpg') no-repeat center center";
		Announcement.style.bakcgroundSize = "cover";
	});
	
	Notice3.addEventListener('click', function() {
		Announcement.style.background = "url('./img/imge3.jpg') no-repeat center center";
		Announcement.style.bakcgroundSize = "cover";
	});
	
	//----------- MainContentBox1 ----------
	Today_Work_add_Button.addEventListener('click', function() {
		today_work_add_open();
	});
	
	Today_Work_add_Accept.addEventListener('click', function() {
		event.preventDefault();
		    
	    today_work_information.submit();
	});
	for(let i = 0; i < Today_Work_check.length; i++) {
		Today_Work_check[i].addEventListener('click', function() {
			
			location.href = './Main_Today_Work_delete.jsp?work_num=' + 
							this.getAttribute("work_num") +
							'&user_id=' +
							'<%= user_id %>';
		});
	}
	
	//----------- MainContentBox2 ----------
	// 일주일 날짜 설정 및 렌더링
    function renderWeek() {
        const startOfWeek = new Date(today);
        startOfWeek.setDate(today.getDate() - today.getDay()); // 이번 주 일요일 기준

        for (let i = 0; i < 7; i++) {
            const currentDate = new Date(startOfWeek);
            currentDate.setDate(startOfWeek.getDate() + i);

            const year = currentDate.getFullYear();
            let month = currentDate.getMonth() + 1;
            if (month < 10) {
                month = "0" + month;
            };
            const day = currentDate.getDate();
            if (day < 10) {
                day = "0" + day;
            };
            const dateString = year + '-' + month + '-' + day; // "YYYY-MM-DD"

            // 오늘 날짜
            const todayYear = today.getFullYear();
            const todayMonth = today.getMonth();
            const todayDate = today.getDate();

            // 비교 날짜
            const currentYear = currentDate.getFullYear();
            const currentMonth = currentDate.getMonth();
            const currentDateValue = currentDate.getDate();

            // 해당 요일에 날짜 설정
            let dayId;
            switch (i) {
                case 0:
                    dayId = "sun";
                    break;
                case 1:
                    dayId = "mon";
                    break;
                case 2:
                    dayId = "tue";
                    break;
                case 3:
                    dayId = "wed";
                    break;
                case 4:
                    dayId = "thu";
                    break;
                case 5:
                    dayId = "fri";
                    break;
                case 6:
                    dayId = "sat";
                    break;
            }

            const dayDiv = document.getElementById(dayId);
            const dayDate = dayDiv.querySelector("p");
            dayDate.textContent = dateString;

            // 클릭 이벤트 추가
            dayDiv.addEventListener("click", function () {
                console.log(dateString); // 클릭된 날짜를 콘솔에 출력
            });
        }
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
   		location.href='./Message.jsp?user_id=' + '<%= user_id %>';
   	})

// ------------ 메뉴 박스 --------------------
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
    
    Menu_BoardBox.addEventListener ('click', function() {
    	location.href='./Board.jsp?user_id=' + '<%= user_id %>';
    });
    
    
 // ------------ MainContent1 함수 --------------------
    function today_work_add_open() {
    	if(Today_Work_add_Box.disabled){
    		Today_Work_add_Box.disabled = false;
    		Today_Work_add_Box.style.width = '240px';
    		Today_Work_add_Box.style.height = '50px';
    		Today_Work_add_Box.style.opacity = 1;
    	} else {
    		Today_Work_add_Box.disabled = true;
    		Today_Work_add_Box.style.width = '0px';
    		Today_Work_add_Box.style.height = '0px';
    		Today_Work_add_Box.style.opacity = 0;
    	}
    }
 
 
 // ------------ 메뉴 함수 --------------------
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
    
 // ------------ 시계 함수 --------------------
    function updateClock() {
    	let now = new Date();
    	let hours = now.getHours().toString().padStart(2, '0');
    	let minutes = now.getMinutes().toString().padStart(2, '0');
    	let year = now.getFullYear();
    	let month = now.getMonth() + 1;
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