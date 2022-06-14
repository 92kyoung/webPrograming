<%@page import="kr.ac.kopo.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.member.dao.MemberDAO"%>
<%@page import="kr.ac.kopo.util.JDBCClose"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	MemberDAO dao = new MemberDAO();	
	List <MemberVO> memberList = dao.showAllMember();
	
	//list를 el에서 사용하기 위해서 list를 공유영역에 올린다. 
	pageContext.setAttribute("memberList",memberList);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원목록</title>

<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">
<script src="/Misson-Web/resource/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<div align="center">  <!-- align:center 가운데정렬 -->
		<hr>
		<h2>전체 회원 조회</h2>
		<hr>
		
		<table border="1" style="width:100%">
			<tr>
				<th width="7%" align="center">id</td>
				<th width="7%">이름</th>
				<th width="16%">패스워드</th>
				<th width="20%">휴대폰번호</th>
				<th width="20%">우편번호</th>
				<th width="20%">주소</th>
		    </tr>
	 		
	 		<c:forEach items="${ memberList }" var="member" varStatus="loop">
	 		<tr <c:if test="${ loop.count mod 2 eq 0 }">class="even"</c:if>>
	 			<td><a href="detailMember.jsp?id=${member.id}"><c:out value="${member.id} " /></a></td>
	 			<td><c:out value="${ member.name }"/></td>
	 			<td><c:out value="${ member.password }"/></td>
	 			<td><c:out value="${ member.tel1 }${ member.tel2 }${ member.tel3 }"/></td>
	 			<td><c:out value="${ member.post }"/></td>
	 			<td><c:out value="${ member.basic_addr }"/></td>	 	
	 		</tr>
	 		</c:forEach>
		</table>
		<br>
		<button onclick="location.href='writeMemberForm.jsp'">회원가입</button>
		<!-- <a href="writeMemberForm.jsp">회원가입하기</a> -->
	</div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	</footer>
</body>
</html>

