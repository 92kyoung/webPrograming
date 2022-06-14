<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table border="1" style="width:100%">
	<tr>
		<td rowspan="2">
			<a href="/Mission-Web">
			<img src="/Mission-Web/resources/images/hanaLogo.jpg" style="width : 150 px; height:45px;">
			</a>
		</td>
		<td align="right">
		즐겨찾기
			<c:if test="${ not empty userVO }">
				[${ userVO.name }님으로 로그인 중...]  <!-- loginProcess에서 userVO를 세션등록해서 사용가능 -->
			</c:if>
		</td>
	</tr>
	<tr>
		<td>
			<nav> 
				<c:if test="${ userVO.type eq 'S' }">
					<a href="/Mission-Web/jsp/member/showMemberList.jsp">회원 관리</a> | 
				</c:if>
				
				  <a href="/Mission-Web/jsp/board/list.jsp">게시판</a> | 
				<c:choose>
				  	<c:when test="${ empty userVO }">
				  			<a href="/Mission-Web/jsp/member/writeMemberForm.jsp">회원가입</a> | 
				  			<a href="/Mission-Web/jsp/login/login.jsp">로그인</a> |  
				  	</c:when>
				  	<c:otherwise>
				  			마이페이지 | 
				  			<a href="/Mission-Web/jsp/login/logout.jsp">로그아웃</a> </nav>
				  	</c:otherwise>
			    </c:choose>
		</td>
	</tr>
</table>