<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
// localhost:9999/Mission-Web/jsp/board/detail.jsp?no=2

//번호 추출 해서 db t_board 에 해당하는 정보를 가져오기
//그리고 화면에 출력하기
	String number = request.getParameter("no");
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no,title,writer,content,view_cnt,reg_date from t_board where no=?");
	
	//실행객체
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	
	pstmt.setString(1,number);
	ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 상세 페이지</title>
</head>
<body>
	<div align="center">
	 <hr>
	 	<h2>게시판 상세</h2>
	 <hr>
	</div>
	
    <% 
	   	 while(rs.next()){ 
	   		 int no= rs.getInt("no");
	   		 String title = rs.getString("title");
	   		 String writer = rs.getString("writer");
	   		 String content = rs.getString("content");
	   		 String view_cnt = rs.getString("view_cnt");
	   		 String regDate = rs.getString("reg_date");		 
	 %>	
	
	<%= no %>
	<%= title %>
	<%= writer %>
	<%= content %>
	<%= view_cnt %>
	<%= regDate %>
	<%
	   	 }
	%>
</body>
</html>