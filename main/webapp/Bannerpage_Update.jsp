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
  <title>Document</title>
  <link rel="stylesheet" href="./css/Bannerpage_Update.css">
</head>
<body>
  <div class="fullScreen">
    <div class="Workmenu"></div>
    <div class="MainContent">
      <div class="box1">
        <div class="Announcement">
          공지사항 관리
        </div>
      </div>
        <div class="Boxes">
        <div class="Box1">
            <div class="bannerbox1">
              <div class="banner1">
                <img class="imge1" src="./img/imge1.jpg">
              </div>
            </div>
            <div class="imgbox1">
              <div class="img1">
                <img class="imgs1" src="./img/imgs1.jpg">
              </div>
            </div>
            <button class="btn1">수정</button>
          </div>
        <div class="Box2">
          <div class="bannerbox2">
            <div class="banner2">
              <img class="imge2" src="./img/imge2.jpg">
            </div>
          </div>
          <div class="imgbox2">
            <div class="img2">
              <img class="imgs2" src="./img/imgs2.jpg">
            </div>
          </div>
          <button class="btn1">수정</button>
        </div>
        <div class="Box3">
          <div class="bannerbox3">
            <div class="banner3">
              <img class="imge3" src="./img/imge3.jpg">
            </div>
          </div>
          <div class="imgbox3">
            <div class="img3">
              <img class="imgs3" src="./img/imgs3.jpg">
            </div>
          </div>
          <button class="btn1">수정</button>
        </div>
      </div>
        <div class="line1"></div>
        <div class="line2"></div>
  </div>
    <div class="Personal">
      <div id="login_box"></div>
      <div id="message_box"></div>
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
  
  </div>
</body>
</html>