
<%@page import="kr.ac.kopo.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.board.dao.BoardDAO"%>
<%@page import="kr.ac.kopo.util.JDBCClose"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%-- 작업순서
		1. t_board 테이블에서 전체 게시글 조회
		2. 조회된 게시물를 하나씩 웹브라우저에 출력
 --%>    
 
 
 <%
 	BoardDAO dao = new BoardDAO();
 	List <BoardVO> list = dao.selectAll();
 	
 	//list를 el에서 사용하기 위해서 list를 공유영역에 올린다. 
 	pageContext.setAttribute("list", list);
 %>
 
  <%--  
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
 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--url경로: http://localhost:9999/Mission-Web/jsp/board/list.jsp -->
<title>전체 게시판 조회</title>

<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">
<script src="/Mission-Web/resources/js/jquery-3.6.0.min.js"></script>

<script>
	$(document).ready(function(){
		
		$('#addBtn').click(function(){
			location.href='writeForm.jsp' 
		})
	})
	
 	function checkLogin(boardNo){
		<c:choose>
			<c:when test="${empty userVO}">
				if(confirm('로그인 후 사용가능합니다\n 로그인 페이지로 이동할까요?')){
					location.href="/Mission-Web/jsp/login/login.jsp"				
				} 
			</c:when>
			
			<c:otherwise>
				location.href="detail.jsp?no="+boardNo
			</c:otherwise>
		</c:choose>
	}
</script>
	

</head>
<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<div align="center">  <!-- align:center 가운데정렬 -->
		<hr>
		<h2>전체 게시글 조회</h2>
		<hr>
		
		<table border="1" style="width:100%">
			<tr>
				<th width="7%" align="center">번호</th>
				<th>제목</th>
				<th width="16%">작성자</th>
				<th width="20%">등록일</th>
		    </tr>
	 		<c:forEach items="${ list }" var="board" varStatus="loop">
		    <tr <c:if test="${ loop.count mod 2 eq 0 }">class="even"</c:if>>
		         <!-- varStatus는 first, last, index, count 존재 count는 1부터 순자 셈 
		         	짝수인 수에만 even class 붙임
		         -->
		    	<td> ${ board.no } </td>
		    	<td> 
				    <a href="javascript:checkLogin(${board.no})"> 
		    			<c:out value="${board.title} " /> 
		    		</a> 
				<%-- 		    		
					<a href="detail.jsp?no=${board.no}"> 
		    			<c:out value="${board.title} " />  <!-- el대신 out 태그 사용 
		    			제목에 html 태그를 쓰면 그 태그를 html로 읽게 하면 악성코드를 심을 수 있다. 
		    			그래서 out 태그를 써서 html 태그도 문자열로 인식하게 만듬 -->
		    		</a>  
		    		--%>
		    	</td>
		    	<td> ${ board.writer } </td>
		    	<td> ${ board.regDate } </td>
		    </tr>
	 		</c:forEach>
		</table>
		<br>
		<c:if test="${ not empty userVO }">
			<button id="addBtn" onclick="location.href='writeForm.jsp'">새글등록</button>
		</c:if>
	</div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	
	</footer>
</body>
</html>

