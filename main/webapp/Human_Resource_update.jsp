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
	String update_form_link = "./Human_Resource_update_form.jsp?user_id=" + user_id;
	
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
	
	emp_id = request.getParameter("emp_id");
	String emp_id_now = emp_id;
	String emp_name = "";
	String birth_date = "";
	String phone_number = "";
	String hire_date = "";
	String position = "";
	String salary = "";
	String user_password = "";
	String user_email = "";
	String user_nickname = "";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>인사 관리 수정 페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
		
		sql = "SELECT a.emp_id, a.emp_name, a.birth_date, a.phone_number, a.hire_date, c.dept_name, a.position, a.salary, d.user_id, d.user_password, d.user_email, d.user_nickname " +
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
		<form id="form_information" action="<%= update_form_link %>" method="POST">
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
	        <button class="update-button">수 정</button>
	        <button class="cancel-button">취 소</button>
       
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
	//취소 버튼 눌렀을 때
	let cancelbutton = document.querySelector('.cancel-button');
	
	cancelbutton.addEventListener('click', function(){
		location.href = './Human_Resource.jsp?user_id=' + '<%= user_id %>';
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