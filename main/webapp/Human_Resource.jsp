<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DBConnection.DBManager" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="./css/Human-Resource.css">
</head>
<body>
  <div class="fullScreen">
    <div class="MainContent">
      <div class="Announcement">
        <h1>&nbsp;인사 관리</h1>
        <button class="add-button">+</button>
      </div>
      <div class="MainContentBox">
        <div class="title">
          <div class="title1"><p><b>사원 번호</b></p></div>
          <div class="title2"><p><b>사원 이름</b></p></div>
          <div class="title3"><p><b>부서</b></p></div>
          <div class="title4"><p><b>직책</b></p></div>
        </div>
        <div class="RowLine"></div>
        <div class="content">
          <ul class="emp-id">
<%
		//java로 sql실행하여 데이터 삽입하기
		Connection conn = DBManager.getDBConnection();
		
		String sql = "SELECT a.emp_id, a.emp_name, c.dept_name, a.position " +
					 "FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c " + 
					 "WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			Integer emp_id;
			while(rs.next()) {
				emp_id = rs.getInt("emp_id");
%>
		<li><%= emp_id %></li>
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
		
		sql = "SELECT a.emp_id, a.emp_name, c.dept_name, a.position " +
					 "FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c " + 
					 "WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			String emp_name;
			while(rs.next()) {
				emp_name = rs.getString("emp_name");
%>
		<li><%= emp_name %></li>
<%
			}
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
          </ul>
          <ul class="RightLine2"></ul>
          <ul class="department">
<%
//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT a.emp_id, a.emp_name, c.dept_name, a.position " +
					 "FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c " + 
					 "WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			String dept_name;
			while(rs.next()) {
				dept_name = rs.getString("dept_name");
%>
		<li><%= dept_name %></li>
<%
			}
			
			DBManager.dbClose(conn, pstmt, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
%>         
          </ul>
          <ul class="RightLine3"></ul>
          <ul class="position">
<%
		//java로 sql실행하여 데이터 삽입하기
		conn = DBManager.getDBConnection();
		
		sql = "SELECT a.emp_id, a.emp_name, c.dept_name, a.position " +
					 "FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c " + 
					 "WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			String position;
			while(rs.next()) {
				position = rs.getString("position");
%>
		<li><%= position %></li>
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
		
		sql = "SELECT a.emp_id, a.emp_name, c.dept_name, a.position " +
					 "FROM EMPLOYEES a, DEPT_EMP b, DEPARTMENT c " + 
					 "WHERE a.emp_id = b.emp_id AND b.dept_id = c.dept_id";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
		 while(rs.next()){
			 
%>
	<li>
		<button class="update-button" emp-id="<%= rs.getInt("emp_id") %>">수정</button>
		<button class="delete-button" emp-id="<%= rs.getInt("emp_id") %>">삭제</button>
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
  </div>
  <script>
  	//add-button 누르면 인원 추가
  	let addbutton = document.querySelector('.add-button');
  	
  	addbutton.addEventListener('click', function(){
  		location.href = './Human_Resource_add.jsp'
  	});
  	
  	// 수정 버튼 누르면 수정
  	let updatebutton = document.querySelectorAll(".update-button");

  	for(let i = 0; i < updatebutton.length; i++) {
  		updatebutton[i].addEventListener('click', function(){
  	  		const emp_id = updatebutton[i].getAttribute("emp-id");
  	  		location.href = './Human_Resource_update.jsp?emp_id=' + emp_id;
  	  	});
  	}
	
  	
  </script>
</body>
</html>