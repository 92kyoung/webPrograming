<%@page import="kr.ac.kopo.board.vo.BoardFileVO"%>
<%@page import="kr.ac.kopo.board.vo.BoardVO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="kr.ac.kopo.util.KopoFileNamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.ac.kopo.board.dao.BoardDAO"%>
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
 	//method가 post인 방식은 파라미터 값이 넘어올 때 한글이 깨지므로 꼭 캐릭터 인코딩을 해주어야 한다. 
	request.setCharacterEncoding("utf-8");
	
	//첨부파일 저장 경로 ( upload 파일 > 우클릭 > properties > location )
	String saveFolder = "D:/git-workspace/Misson-Web/src/main/webapp/upload";
	
	//  ↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
	// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
	// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
	
	MultipartRequest multi = new MultipartRequest(
			request,
			saveFolder,
			1024*1024*3,
			"utf-8",
			new KopoFileNamePolicy()
	);
	// MultipartRequest로 전송받은 데이터를 불러온다.
	// enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
	
	String title = multi.getParameter("title");
	String writer = multi.getParameter("writer");
	String content = multi.getParameter("content");

	// 1. 게시판 저장
	BoardVO board = new BoardVO();
	board.setTitle(title);
	board.setWriter(writer);
	board.setContent(content);

	BoardDAO dao = new BoardDAO();
	
	//등록할 글 번호 조회
	int boardNo = dao.selectBoardNo();
	board.setNo(boardNo);
	
	
	dao.insertBoard(board);

	// 2. 첨부파일 저장
	//여러 파일을 받을 경우 
	Enumeration<String> files =  multi.getFileNames(); //form 에 작성한 name 받아옴 ex)attachfile1 
	while(files.hasMoreElements()) {
		String fileName = files.nextElement();
	//	System.out.println(fileName);
		File f = multi.getFile(fileName);
	
	if(f != null) {
		String fileOriName = multi.getOriginalFileName(fileName);
		String fileSaveName = multi.getFilesystemName(fileName);
		
		int fileSize = (int)f.length();
		
		BoardFileVO fileVO = new BoardFileVO();
		fileVO.setFileOriName(fileOriName);
		fileVO.setFileSaveName(fileSaveName);
		fileVO.setFileSize(fileSize);
		fileVO.setBoardNo(boardNo);
		
		//System.out.println(fileVO);	
		
		dao.insertBoardFile(fileVO);
	}
}



/*
//첨부파일을 받고 난 후 정보가 제대로 날라오지 않음
String title = request.getParameter("title");
String writer = request.getParameter("writer");
String content = request.getParameter("content");


BoardVO board = new BoardVO();
board.setTitle(title);
board.setWriter(writer);
board.setContent(content);

System.out.println(board);

BoardDAO dao = new BoardDAO();
dao.insertBoard(board); 
*/


/*
이 코드를 BoardDAO에 옮김

Connection conn = new ConnectionFactory().getConnection();

StringBuilder sql = new StringBuilder();
// 시퀀스 다음 값 추출 할 때는 nextval 
sql.append("insert into t_board(no, title, writer, content) ");
sql.append(" values(seq_t_board_no.nextval, ?, ?, ?) ");
PreparedStatement pstmt = conn.prepareStatement(sql.toString());


 pstmt.setString(1, title);// 첫번째 물음표 자리 
pstmt.setString(2, writer);
pstmt.setString(3, content);

	
pstmt.executeUpdate();
 */	
	
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