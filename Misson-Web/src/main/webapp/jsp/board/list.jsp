
<%@page import="kr.ac.kopo.util.JDBCClose"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%-- 작업순서
		1. t_board 테이블에서 전체 게시글 조회
		2. 조회된 게시물를 하나씩 웹브라우저에 출력
 --%>    
    
 <%
 	//연결 객체
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no, title, writer, to_char(reg_date,'yyyy-mm-dd') as reg_date ");
	sql.append("  from t_board ");
	sql.append(" order by no desc ");
    
    //실행객체
    PreparedStatement pstmt = conn.prepareStatement(sql.toString()); //stringBuilder는 toString으로 받는다.
    
    //ResultSet형으로 결과가 날라옴
    ResultSet rs = pstmt.executeQuery();
 	
    
 %>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--url경로: http://localhost:9999/Mission-Web/jsp/board/list.jsp -->
<title>전체 게시판 조회</title>
<script src="/Misson-Web/resource/js/jquery-3.6.0.min.js"></script>

<script>
	$(document).ready(function(){
		
		$('#addBtn').click(function(){
			location.href='writeForm.jsp' 
		})
		
	})
</script>

</head>
<body>
  	<div align="center">  <!-- align:center 가운데정렬 -->
		<hr>
		<h2>전체 게시글 조회</h2>
		<hr>
		
		<table border="1" style="width:80%">
			<tr>
				<td width="7%" align="center">번호</td>
				<td>제목</td>
				<td width="16%">작성자</td>
				<td width="20%">등록일</td>
		    </tr>
	   <% 
	   	 while(rs.next()){ 
	   		 int no= rs.getInt("no");
	   		 String title = rs.getString("title");
	   		 String writer = rs.getString("writer");
	   		 String regDate = rs.getString("reg_date");
	   		 
	   %>
		    <tr>
		    	<td><%= no %></td>  <!-- scriptlet(<% %>) 을 사용해서 변수를 바로 직접 넣는다  -->
		    	<td><a href="detail.jsp?no=<%= no %>"><%= title %></a></td>
		    	<td><%= writer %></td>
		    	<td><%= regDate %></td>
		    	
		    </tr>
	   <% 
	     } 
	   %>
		</table>
		<br>
		<button id="addBtn">새글등록</button>
	</div>
</body>
</html>

<% 
    //맨 마지막에 db연결 접속 해제
	JDBCClose.close(pstmt,conn);
%>