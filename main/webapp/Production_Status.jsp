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
  <link rel="stylesheet" href="./css/Production_Status.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="box1">
        <div class="Announcement">
          생산현황 관리
          <button class="add-button">+</button>
        </div>
      </div>
    <div class="Box1">
      <div class="box2">
        <div class="Accounts">
          <div class="Account" id="item">제품</div>
          <div class="Account" id="company">거래처명</div>
          <div class="Account" id="Currentproduction">현재 생산량</div>
          <div class="Account" id="Expectedproduction">예상 생산량</div>
        </div>
        <div class="databox">
          <ul class="data">
           
          </ul>
        </div>

      </div>
      <div class="box3">
        <ul class="buttons">

        </ul>
      </div>
      
      <div class="line1"></div>
      <div class="line2"></div>
      <div class="line3"></div>
      <div class="line4"></div>
    </div>
    <div class="Box2">
        <select class="search">
          <option value="search1" selected>제품</option>
          <option value="search1" >거래처명</option>
          <option value="search1" >현재 생산량</option>
          <option value="search1" >예상 생산량</option>
        </select>
        <div class="box5"></div>
        <button class="btn1">검색</button>
      </div>
    </div>
    </div>
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