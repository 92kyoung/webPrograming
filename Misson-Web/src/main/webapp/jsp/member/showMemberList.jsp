<%@page import="kr.ac.kopo.util.JDBCClose"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select id,name,password,tel1,tel2,tel3,POST,BASIC_ADDR");
	sql.append("  from T_MEMBER ");

	//실행객체
    PreparedStatement pstmt = conn.prepareStatement(sql.toString()); //stringBuilder는 toString으로 받는다.
    
    //ResultSet형으로 결과가 날라옴
    ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원목록</title>
<script src="/Misson-Web/resource/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div align="center">  <!-- align:center 가운데정렬 -->
		<hr>
		<h2>전체 회원 조회</h2>
		<hr>
		
		<table border="1" style="width:80%">
			<tr>
				<td width="7%" align="center">id</td>
				<td width="7%">이름</td>
				<td width="16%">패스워드</td>
				<td width="20%">휴대폰번호</td>
				<td width="20%">우편번호</td>
				<td width="20%">주소</td>
		    </tr>
	 
 	   <% 
	   	 while(rs.next()){ 
	   		 String id= rs.getString("id");
	   		 String name = rs.getString("name");
	   		 String passwd = rs.getString("password");
	   		 String tel = rs.getString("tel1")+rs.getString("tel2")+rs.getString("tel3");
	   		
	   		 if(rs.getString("tel1")==null){
	   			 tel="미입력";
	   		 };	
	   		 
	   		 
	   		 String postcode = rs.getString("POST");
	   		 
	   		 if(rs.getString("POST")==null){
	   			 postcode="미입력";
	   		 };	
	   		 
	   		 
	   		 String addr=rs.getString("BASIC_ADDR");
	   		 
	   		 if(rs.getString("BASIC_ADDR")==null){
	   			 addr="미입력";
	   		 };	
	   		 
	   %>
		    <tr>
		    	<td><%= id %></td>  <!-- scriptlet(<% %>) 을 사용해서 변수를 바로 직접 넣는다  -->
		    	<td><%= name %></td>
		    	<td><%= passwd %></td>
		    	<td><%= tel %></td>
		    	<td><%= postcode %></td>
		    	<td><%= addr %></td>
		    	
		    </tr>
	   <% 
	     } 
	   %>
	   
	  
		</table>
		<br>
	<!-- 	<button id="addBtn">새글등록</button> -->
	</div>
</body>
</html>

<% 
    //맨 마지막에 db연결 접속 해제
	JDBCClose.close(pstmt,conn);
%>