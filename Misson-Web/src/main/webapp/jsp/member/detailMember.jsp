<%@page import="kr.ac.kopo.member.vo.MemberVO"%>
<%@page import="kr.ac.kopo.member.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세정보조회</title>


<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">
</head>

<!-- <script>
	let pwd = window.prompt(");
	alert("pwd": pwd)
</script> -->

<%
/*  
	http://localhost:9999/Misson-Web/jsp/member/detailMember.jsp?id=id1
	
	작업순서
	1.id추출
	2.id로 회원정보 조회 (db-t_member)
	3.화면에 출력

*/
	//1.id 추출
	String id = request.getParameter("id");

	//2.추출한 id를 memberDAO의 selectById로 전달
	//2-1.DAO의 메소드를 사용하기 위해서 객체 생성
	MemberDAO dao = new MemberDAO();
	//2-2.메소드 리턴값을  VO에 대입
	MemberVO member = dao.selectById(id);
	
	//3.el을 사용하기 위해서 공유영역에 등록
	pageContext.setAttribute("member",member);


%>

<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		 <div align="center">
	<table border="1" style="width: 100@%">
		<tr>
			<th width="25%">아이디</th>
			<td>${ member.id }</td>
		</tr>
		
		<tr>
			<th width="25%">이름</th>
			<td>${ member.name }</td>
		</tr>
		
		<tr>
			<th width="25%">패스워드</th>
			<td>${ member.password }</td>
		</tr>
			
		<tr>
			<th width="25%">이메일</th>
		    <c:choose>
		    	<c:when test="${ empty member.email_id }">
		    		<td>미입력</td>
		    	</c:when>
		    	<c:otherwise>
		    		<td>${ member.email_id }@${ member.email_domain }</td>
		    	</c:otherwise>
		    </c:choose>
	 	</tr>


		<tr>
			<th width="25%">전화번호</th>
		    <c:choose>
		    	<c:when test="${ empty member.tel1 }">
		    		<td>미입력</td>
		    	</c:when>
		    	<c:otherwise>
		    		<td>${ member.tel1 }${ member.tel2 }${ member.tel3 }</td>
		    	</c:otherwise>
		    </c:choose>
	 	</tr>

		<tr>
			<th width="25%">우편번호</th>
			<c:choose>
				<c:when test="${ empty member.post}">
					<td>미입력</td>
				</c:when>
				<c:otherwise>
					<td>${ member.post }</td>
				</c:otherwise>
			</c:choose>
		</tr>
		
		<tr>
			<th width="25%">주소</th>
			<c:choose>
				<c:when test="${ empty member.basic_addr}">
					<td>미입력</td>
				</c:when>
				<c:otherwise>
					<td>${ member.basic_addr } ${ member.detail_addr }</td>
				</c:otherwise>
			</c:choose>
		</tr>
		
		<tr>
			<th width="25%">회원구분</th>
			<td>${ member.type }</td>
		</tr>
		
		<tr>
			<th width="25%">회원가입 일시</th>
			<td>${ member.reg_date }</td>
		</tr>
	</table>
	<button onclick="location.href='showMemberList.jsp'">목 록</button>&nbsp;&nbsp;
  </div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	</footer>
</body>
</html>

