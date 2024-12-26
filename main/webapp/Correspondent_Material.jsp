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
  <title>Document</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Correspondent_Material.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
    <div class="Announcement">
		거래처 관리
		<button class="add-button">+</button>
    </div>
    
    <div class="Box1">
      <div class="box2">
        <div class="Accounts">
          <div class="Account" id="company">거래처명</div>
          <div class="Account" id="item">거래 품목</div>
          <div class="Account" id="country">원산지</div>
          <div class="Account" id="phone">Tel</div>
        </div>
        <div class="content"> 
       <ul class="content_list">
       
       <%
		//java로 sql실행하여 데이터 삽입하기
		 conn = DBManager.getDBConnection();
		
		sql = "SELECT cor_name, material, origin, cor_tel " +
					 "FROM correspondent_material ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				String cor_name = rs.getString("cor_name");
				String material = rs.getString("material");
				String origin = rs.getString("origin");
				String cor_tel = rs.getString("cor_tel");
%>
		<li class="contents">
			<div class="content" id="cor_name"><%= cor_name %></div>
			<div class="content" id="material"><%= material %></div>
			<div class="content" id="origin"><%= origin %></div>
			<div class="content" id="cor_tel"><%= cor_tel %></div>
		</li>
<%
			}
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
       </ul>
        </div>
        <div class="line1"></div>
        <div class="line2"></div>
        <div class="line3"></div>
        <div class="line4"></div>
        <div class="line5"></div>
      </div>
      <div class="box3">
      	<ul class="remake">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT cor_name " +
					 "FROM correspondent_material ";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
		 while(rs.next()){
%>
	<li>
		<button class="update-button" cor_name="<%= rs.getInt("cor_name") %>">수정</button>
		<button class="delete-button" cor_name="<%= rs.getInt("cor_name") %>">삭제</button>
	</li>
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
    
    
    <div class="Box2">
        <select class="search">
          <option value="search1" selected>거래처명</option>
          <option value="search1" >거래 품목</option>
          <option value="search1" >원산지</option>
          <option value="search1" >Tel</option>
        </select>
        <input class="box5"></input>
        <button class="btn1">검색</button>
      </div>
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
    
 // ------------ Personal 함수 --------------------
    function Logout_open() {
    	if(LogoutBox.style.height == '0px') {
			LogoutBox.style.height = '50px';
		} else {
			LogoutBox.style.height = '0px';
		}
    }
 
  //add-button 누르면 인원 추가
  	let addbutton = document.querySelector('.add-button');
  	
  	addbutton.addEventListener('click', function(){
  		location.href = './Correspondent_Material_add.jsp?user_id=' + '<%= user_id %>';
  	});
  	
  	// 수정 버튼 누르면 수정
  	let updatebutton = document.querySelectorAll(".update-button");

  	for(let i = 0; i < updatebutton.length; i++) {
  		updatebutton[i].addEventListener('click', function(){
  	  		const cor_name = updatebutton[i].getAttribute("cor_name");
  	  		location.href = './Correspondent_Material_update.jsp?user_id=' + '<%= user_id %>' + '&cor_name='+ cor_name;
  	  	});
  	}
  	
  	// 삭제 버튼 누르면 
	let deletebutton = document.querySelectorAll(".delete-button");

  	for(let i = 0; i < deletebutton.length; i++) {
  		deletebutton[i].addEventListener('click', function(){
  	  		const cor_name = deletebutton[i].getAttribute("cor_name");
  	  		if(confirm('삭제하시겠습니까?')){
  	  		location.href = './Correspondent_Material_delete.jsp?user_id=' + '<%= user_id %>' + '&cor_name='+ cor_name;
  	  		}
  	  		
  	  	});
  	}
</script>

</body>
</html>