<%@page import="kr.ac.kopo.member.dao.MemberDAO"%>
<%@page import="kr.ac.kopo.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 1. id, password 추출
	2. db 조회
	3. 로그인 성공/실패
	 */
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberVO memberVO = new MemberVO();
	memberVO.setId(id);
	memberVO.setPassword(password);
	
	MemberDAO dao = new MemberDAO();
	MemberVO userVO = dao.login(memberVO);
	
	String msg ="";
	String url = "";
	if (userVO == null){
		//로그인이 실패
		msg="아이디 또는 패스워드를 잘못 입력하셨습니다.";
		url="login.jsp";
		
		
	} else {
		switch(userVO.getType()){
		case "S" :
			msg="관리자님 환영합니다";
		case "U" :
			msg=userVO.getId() + "님 환영합니다";
		}
		msg="로그인 성공";
		url="/Mission-Web"; /* index.jsp로 이동 */
		
		//세션 등록
		session.setAttribute("userVO",userVO);
		
	}
	
	pageContext.setAttribute("msg",msg);  //자신의 페이지에서만 사용할거니까 pageContext 공유영역 사용
	pageContext.setAttribute("url",url);
	
	

%>
<!--스크립트 태그만 필요하므로 html 태그들은 지움 -->
<script>
	alert('${msg}');
	location.href = '${url}'; /*문자열을 인식하기 위해서 작은따음표 붙임  */
</script>
