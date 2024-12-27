<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>
<%@ page import="Link.Link" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.time.LocalDateTime" %>
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
  <title>인사 관리</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Production_Profile.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="Announcement">
        <h1>&nbsp;생산 현황 관리</h1>
      </div>
      <div class="MainContentBox">
        <div class="title">
          <div class="title1"><p><b>제품</b></p></div>
          <div class="title2"><p><b>현재생산량</b></p></div>
          <div class="title3"><p><b>현 주문량</b></p></div>
          <div class="title4"><p><b>비고</b></p></div>
        </div>
        <div class="RowLine"></div>
        <div class="content">
          <ul class="emp-id">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT product_id, product_name " + 
			  "FROM PRODUCTS";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			
			String product_id_now;
			
			String product_name = "";
			Double production_now = 0.0;
			Double then_num = 0.0;
			Double sum = 0.0;
			Double consumption = 1.0;
			Double production = 1.0;
			
			while(rs.next()) {
				sum=0.0;
				
				product_id_now = rs.getString("product_id");
				
				sql = "SELECT a.product_id, a.product_name, a.expected_production, b.production, b.consumption " + 
					  "FROM PRODUCTS a, HISTORY b " +
					  "WHERE a.product_id = b.product_id " +
					  "AND a.product_id = ?";
				try {
					PreparedStatement pstmt2 = conn.prepareStatement(sql);
					pstmt2.setInt(1, Integer.parseInt(product_id_now));	
				
					ResultSet rs2 = pstmt2.executeQuery();
					
					Random random = new Random();
					Double random_num = 0.5 + random.nextDouble();
					LocalDateTime now = LocalDateTime.now();
					Integer hour = now.getHour();
					consumption = 1.0;
					
					
					String then = "";
					
					rs2.next();
					product_name =rs2.getString("product_name");
					production = rs2.getDouble("production");
					consumption = rs2.getDouble("consumption");
					
					double truncatedValue = Math.floor(consumption/production * random_num) / 100;

					double hour_num = Math.floor(((9 - (20.0 - hour))/9.0) * 100);
					hour_num = hour_num / 100.0;
					
					production_now = production * (1-truncatedValue) * hour_num * 9.1;
					System.out.println(production_now);
					DBManager.dbClose(null, pstmt2, rs2);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				sql = "SELECT quantity " +
					  "FROM SALE " +
					  "WHERE product_id = ?";
				try {
					PreparedStatement pstmt2 = conn.prepareStatement(sql);
					pstmt2.setInt(1, Integer.parseInt(product_id_now));
					
				
					ResultSet rs2 = pstmt2.executeQuery();
					
					while(rs2.next()) {
						sum = sum + rs2.getDouble("quantity");
					}
					
					DBManager.dbClose(null, pstmt2, rs2);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				//System.out.println(production_now);
				then_num = production_now - sum;
%>
				<li>
				<div class="product_name"><%= product_name %></div>
				<div class="production_now"><%= production_now %></div>
				<div class="order_now"><%= sum %></div>
				<%
				if(then_num >= 100) {
				%>
					<div class="then" style="color: blue">생산 과다+</div>
				<%
				} else if (then_num < 100 && then_num >= 30) {
				%>
					<div class="then" style="color: blue">생산 과다</div>
				<%
				} else if (then_num < 30 && then_num >-30) {
				%>
					<div class="then" style="color: blue">유지</div>
				<%  
				} else if (then_num <= -30 && then_num > -100) {
				%>
					<div class="then" style="color: red">생산 부족</div>
				<%
				} else {
				%>
					<div class="then" style="color: red">생산 부족+</div>
				<%
				}
				%>
				</li>
<%
			}	
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
          </ul>
          <ul class="RightLine1"></ul>
          <ul class="RightLine4"></ul>
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

  	
  </script>
</body>
</html>