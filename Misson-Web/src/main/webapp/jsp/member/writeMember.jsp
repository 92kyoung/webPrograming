<%@page import="kr.ac.kopo.member.dao.MemberDAO"%>
<%@page import="kr.ac.kopo.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8"); //post 방식에서는 캐릭터 인코딩이 꼭 필요 : 한글 깨짐을 방지하기 위해
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String email_id = request.getParameter("email_id");
	String email_domain = request.getParameter("email_domain");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String telephone = request.getParameter("tel1")+request.getParameter("tel2")+request.getParameter("tel3");
	String post = request.getParameter("post");
	String basic_addr = request.getParameter("basic_addr");
	String detail_addr = request.getParameter("detail_addr");
	String type = request.getParameter("type");
	
	MemberVO member = new MemberVO();
	member.setId(id);
	member.setName(name);
	member.setPassword(password);
	member.setEmail_id(email_id);
	member.setEmail_domain(email_domain);
	member.setTel1(tel1);
	member.setTel2(tel2);
	member.setTel3(tel3);
	member.setTelephone(telephone);
	member.setPost(post);
	member.setBasic_addr(basic_addr);
	member.setDetail_addr(detail_addr);
	member.setType(type);
	
	MemberDAO dao = new MemberDAO();
	dao.insertMember(member);



%>
<script>
	alert("회원 가입이 완료되었습니다.")
	location.href="showMemberList.jsp" /* 상대경로 */
</script>