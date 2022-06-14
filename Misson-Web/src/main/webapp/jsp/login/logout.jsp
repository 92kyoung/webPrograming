<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 로그아웃
	1. 세션 종료
	2. 메인페이지로 이동
	*/
	session.invalidate();
	response.sendRedirect("/Mission-Web");
%>
<!-- 
<script>
	loaction.href='/Mission-Web'
</script> 

센트리다이렉트 대신 사용해도됨
-->