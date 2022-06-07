<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--write.jsp : 사용자가 입력한 값을 db에 저장하는 역할
    		1. 파라미터 추출(제목,작성자,내용) // 입력 값 추출
    		2. t_board 테이블에 새로운 레코드(게시글) 저장(db에 저장)
    		3. 클라이언트에게 결과 전송
     -->
     
<%

request.setCharacterEncoding("utf-8");

String title = request.getParameter("title");
String writer = request.getParameter("writer");
String content = request.getParameter("content");

Connection conn = new ConnectionFactory().getConnection();

StringBuilder sql = new StringBuilder();
/* 시퀀스 다음 값 추출 할 때는 nextval */
sql.append("insert into t_board(no, title, writer, content) ");
sql.append(" values(seq_t_board_no.nextval, ?, ?, ?) ");
PreparedStatement pstmt = conn.prepareStatement(sql.toString());
pstmt.setString(1, title);/* 첫번째 물음표 자리 */
pstmt.setString(2, writer);
pstmt.setString(3, content);

	
pstmt.executeUpdate();
	
	
%>

<script>
	alert("새글 등록을 완료하였습니다.")
	location.href="list.jsp" /* 상대경로 */
</script>
<!--
이 페이지는 db에 저장하는 용도로만 사용되므로
html 페이지를 보여줄 필요 없이 바로 list.jsp 페이지로 이동하면된다.
그래서 html 코드 다 삭제한다.
-->