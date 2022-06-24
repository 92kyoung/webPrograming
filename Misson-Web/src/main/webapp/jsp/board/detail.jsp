<%@page import="kr.ac.kopo.board.vo.BoardFileVO"%>
<%@page import="kr.ac.kopo.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.board.dao.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.ac.kopo.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
// localhost:9999/Mission-Web/jsp/board/detail.jsp?no=2

/*
	작업순서 (1,2-java 3-html)
	1. no 파라미터 추출
	2. 추출된 no에 해당 게시물 조회(t_board)
	3. 조회된 게시물을 화면에 출력
*/

//번호 추출 해서 db t_board 에 해당하는 정보를 가져오기
//그리고 화면에 출력하기
	int no = Integer.parseInt(request.getParameter("no"));
	BoardDAO dao = new BoardDAO();
   
	//0. 조회수 증가시키기
	dao.addViewCnt(no);
	
	//1. 게시물 조회
	BoardVO board =  dao.selectByNo(no);
	
	//2. 첨부파일 조회
	List<BoardFileVO> fileList = dao.selectFileByNo(no);
	
	//3. 공유영역 등록
	// 저 보드를 화면에 출력하고 싶다 => 공유영역에 등록을 해야한다. 		
	pageContext.setAttribute("board", board);
	pageContext.setAttribute("fileList", fileList);
	
	

/* 

	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no,title,writer,content,view_cnt,t0_char(reg_date, 'yyyy-mm-dd') as reg_date from t_board where no=?");
	
	//실행객체
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	
	pstmt.setString(1,no);
	ResultSet rs = pstmt.executeQuery();
 */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 상세 페이지</title>

<link rel="stylesheet" href="/Mission-Web/resources/css/layout.css">
<link rel="stylesheet" href="/Mission-Web/resources/css/table.css">


<script>
	function doAction(type){
		switch(type){
		case'U':
			/* 수정하고자하는 번호를 넘겨야함 
			  no는 detail.jsp 의 파라미터로 넘어온 애임
			  그래서 request.getParamer 의 el 매핑객체인
			  param을 사용해서 no를 가져온다. 
			*/
			location.href="update.jsp?no=${param.no}"
			break;
		case'D':
			if(confirm("정말 삭제하시겠습니까?")){
			location.href="delete.jsp?no=${param.no}"
			}
			
			break;
		case'L':
			/* 목록으로 이동 로케이션 객체 이용 */
			location.href="list.jsp"
			break;
		}
	}

</script>

</head>
<body>
	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<div align="center">
	 <hr>
	 	<h2>게시판 상세</h2>
	 <hr>
	 
	 <table border="1" style="width: 80%">
	 		<tr>
				<th width="25%">번호</th>
				<td>${ board.no }</td>
			</tr>
			
			<tr>
				<th width="25%">제목</th>
				<td>${ board.title}</td>
			</tr>
			
			<tr>
				<th width="25%">작성자</th>
				<td>${ board.writer }</td>
			</tr>
			
			<tr>
				<th width="25%">내용</th>
				<td>${ board.content }</td>
			</tr>
			
			<tr>
				<th width="25%">조회수</th>
				<td>${ board.viewCnt }</td>
			</tr>
			
			<tr>
				<th width="25%">등록일</th>
				<td>${ board.regDate }</td>
			</tr>
			
			<tr>
				<th>첨부파일</th>
				<td>
					<c:forEach items="${ fileList }" var="fileVO">
						<a href="/Mission-Web/upload/${ fileVO.fileSaveName }">
							${ fileVO.fileOriName }
						</a> 
						(${ fileVO.fileSize }bytes)
						<br>
					</c:forEach>
				</td>
			</tr> 
	 </table>
	<button onclick="doAction('U')">수 정</button>&nbsp;&nbsp;
	<button onclick="doAction('D')">삭 제</button>&nbsp;&nbsp;
	<button onclick="doAction('L')">목 록</button>&nbsp;&nbsp;
	</div>
	</section>
	<footer>
		<%@ include file="/jsp/include/footer.jsp" %> <!-- 지시자 include --> <!--절대경로 : 루트는 보통 localhost:9999를 의미하지만 (xml,include,forward에서만 루트는 Mission-Web을 의미한다)  -->
	</footer>
</body>
</html>

