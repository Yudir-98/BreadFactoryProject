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
  <title>자재현황분석</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="./css/Material_Status_Analyze.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="Announcement">
        <h1>자재현황분석</h1>
      </div>
      <div class="MainContentBox">
        <div class="title">
          <div class="title1"><b>재 료</b></div>
          <div class="title2"><b>예상생산량</b></div>
          <div class="title3"><b>현재보유량</b></div>
          <div class="title4"><b>필요량</b></div>
          <div class="title5"><b>차 이</b></div>
          <div class="title6"><b>단 위</b></div>
        </div>
        <div class="content">
          <ul class="material">
<% 
			Integer expected_production_sum = 0;
			Integer mensuration_sum = 0;
			Integer result = 0;
			Double have_now = 0.0;
			Double need = 0.0;
			Double result2 = 0.0;
			Integer a =0;
			
			
			
			conn = DBManager.getDBConnection();
	
			sql = "SELECT material, amount, unit " +
						 "FROM material"; 
			
			try{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				ResultSet rs = pstmt.executeQuery();
				
				String material;
				while(rs.next()){
					material = rs.getString("material");
%>
<li><%= material %></li>
<%
				}
				DBManager.dbClose(conn, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
%>         
          </ul>
          <ul class="expected_production">
<% 
          	conn = DBManager.getDBConnection();
          	
			sql =  "SELECT material, amount, unit " +
				   "FROM material";
			
			try{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					String material_now = rs.getString("material");
					
					sql = "SELECT b.expected_production " +
						  "FROM PRODUCT_COMB a, PRODUCTS b " +
						  "WHERE a.product_id = b.product_id " +
						  "AND a.material = ? ";
					 
					try{
						PreparedStatement pstmt2 = conn.prepareStatement(sql);
						pstmt2.setString(1, material_now);
						
						ResultSet rs2 = pstmt2.executeQuery();
						
						
						while(rs2.next()) {
							expected_production_sum += rs2.getInt("expected_production");
						}
						%>
						<li><%= expected_production_sum %></li>
						<% 
						expected_production_sum = 0;	
						DBManager.dbClose(null, pstmt2, rs2);
					}catch (Exception e) {
						e.printStackTrace();
					}
				}		
			DBManager.dbClose(conn, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
%>
          </ul>
          <ul class="amount">
<% 
			
			conn = DBManager.getDBConnection();
	
			sql = "SELECT material, amount, unit " +
						 "FROM material"; 
			
			try{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				ResultSet rs = pstmt.executeQuery();
				
				Integer amount;
				while(rs.next()){
					amount = rs.getInt("amount");
%>
<li><%= amount %></li>
<%
				}
				DBManager.dbClose(conn, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
%>           
          </ul>
          <ul class="need">
<%
conn = DBManager.getDBConnection();

sql =  "SELECT material, amount, unit " +
	   "FROM material";

try{
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()){
		String material_now = rs.getString("material");
		conn = DBManager.getDBConnection();
		
		sql = "SELECT a.mensuration, b.expected_production "
			+ "FROM PRODUCT_COMB a, PRODUCTS b "
			+ "WHERE a.product_id = b.product_id "
			+ "AND a.material = ? ";
		try{
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, material_now);
			
			ResultSet rs2 = pstmt2.executeQuery();
			
			while(rs2.next()){
				mensuration_sum = rs2.getInt("mensuration");
				
				expected_production_sum = rs2.getInt("expected_production");
				
				result += (mensuration_sum * expected_production_sum) * 7;
			}
			if("땅콩버터".equals(rs.getString("material"))) result = result/1000;
			if("밀가루".equals(rs.getString("material"))) result = result/1000;
			if("우유".equals(rs.getString("material"))) result = result/1000;
			if("소금".equals(rs.getString("material"))) result = result/1000;
			if("버터".equals(rs.getString("material"))) result = result/1000;
			if("이스트".equals(rs.getString("material"))) result = result/1000;
			if("설탕".equals(rs.getString("material"))) result = result/1000;
			if("생크림".equals(rs.getString("material"))) result = result/1000;
			if("딸기".equals(rs.getString("material"))) result = result/1000;
			if("팥".equals(rs.getString("material"))) result = result/1000;
			if("옥수수".equals(rs.getString("material"))) result = result/1000;
			if("초콜릿".equals(rs.getString("material"))) result = result/1000;
			%>
			<li><%= result %></li>
			<%
			
			result = 0;
			
			DBManager.dbClose(null, pstmt2, rs2);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	DBManager.dbClose(conn, pstmt, rs);
}  catch (Exception e) {
	e.printStackTrace();
}
%>
          </ul>
          <ul class="difference">
<%
conn = DBManager.getDBConnection();

sql =  "SELECT material, amount, unit " +
	   "FROM material";

try{
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()){
		String material_now = rs.getString("material");
		
		conn = DBManager.getDBConnection();
		
		sql = "SELECT a.mensuration, b.expected_production, c.amount "
			+ "FROM PRODUCT_COMB a, PRODUCTS b, material c "
			+ "WHERE a.product_id = b.product_id AND a.material = c.material "
			+ "AND a.material = ? ";
		try{
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, material_now);
			
			ResultSet rs2 = pstmt2.executeQuery();
			
			while(rs2.next()){
				mensuration_sum = rs2.getInt("mensuration");
				Double mensuration_sum2 = mensuration_sum * 1.0;
				expected_production_sum = rs2.getInt("expected_production");
				Double expected_production_sum2 = expected_production_sum * 1.0;
				have_now = rs2.getDouble("amount");
				
				Double presum = (mensuration_sum2 * expected_production_sum2) * 7;

				need = need + presum;

			}
			if("땅콩버터".equals(rs.getString("material"))) need = need/1000.0;
			if("밀가루".equals(rs.getString("material"))) need = need/1000.0;
			if("우유".equals(rs.getString("material"))) need = need/1000.0;
			if("소금".equals(rs.getString("material"))) need = need/1000.0;
			if("버터".equals(rs.getString("material"))) need = need/1000.0;
			if("이스트".equals(rs.getString("material"))) need = need/1000.0;
			if("설탕".equals(rs.getString("material"))) need = need/1000.0;
			if("생크림".equals(rs.getString("material"))) need = need/1000.0;
			if("딸기".equals(rs.getString("material"))) need = need/1000.0;
			if("팥".equals(rs.getString("material"))) need = need/1000.0;
			if("옥수수".equals(rs.getString("material"))) need = need/1000.0;
			if("초콜릿".equals(rs.getString("material"))) need = need/1000.0;
			
			result2 = have_now - need;
			int intValue = (int) Math.ceil(result2);
			need = 0.0;
			
			
			if(intValue >= 0)
			{
			%>
			<li style="color: blue;"><%= intValue %></li>
			<%
			} else {
			%>
			<li style="color: red;"><%= intValue %></li>
			<%
			}
			result2 = 0.0;
			
			DBManager.dbClose(null, pstmt2, rs2);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	DBManager.dbClose(conn, pstmt, rs);
}  catch (Exception e) {
	e.printStackTrace();
}
%>
          </ul>
          <ul class="unit">
<% 
			
			conn = DBManager.getDBConnection();
	
			sql = "SELECT material, amount, unit " +
						 "FROM material"; 
			
			try{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				
				ResultSet rs = pstmt.executeQuery();
				
				String unit;
				while(rs.next()){
					unit = rs.getString("unit");
%>
<li><%= unit %></li>
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