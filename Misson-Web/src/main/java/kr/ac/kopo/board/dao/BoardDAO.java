package kr.ac.kopo.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.board.vo.BoardVO;
import kr.ac.kopo.util.ConnectionFactory;
import kr.ac.kopo.util.JDBCClose;

/*
 * t_board 테이블의 CRUD 담당 클래스  
 * 
 */
public class BoardDAO {
	/**
	 * 전체 게시글 조회 메소드 생성
	 */
	/*
	하나의 레코드를 저장하는 단위 : vo
	전체 레코드를 저장해야 되므로 배열이나 콜렉션 단위로 저장해야한다.
	여기서는 list를 사용해봄 
	
	레코드가 한개 이상이므로 List<BoardVO>
	
	리턴타입이 boardvo 타입이어야 한다. boardvo 단위로 결과를 list.jsp로 보내주겠다. 
	*/
	public List<BoardVO> selectAll(){
		
		List <BoardVO> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = new ConnectionFactory().getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select no, title, writer, to_char(reg_date,'yyyy-mm-dd') as reg_date ");
			sql.append("  from t_board ");
			sql.append(" order by no desc ");
	    
			//실행객체
			pstmt = conn.prepareStatement(sql.toString()); //stringBuilder는 toString으로 받는다.
	    
			//ResultSet형으로 결과가 날라옴
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int no = rs.getInt("no");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String regDate = rs.getString("reg_date");
				
				BoardVO board = new BoardVO();
				board.setNo(no);
				board.setTitle(title);
				board.setWriter(writer);
				board.setRegDate(regDate);
				
				list.add(board);
			}
			System.out.println("data access complete");
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCClose.close(pstmt, conn);
		}
			return list;
	}
	
	
	
	/**
	 * 새글등록
	 *
	 */
	public void insertBoard(BoardVO board){
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = new ConnectionFactory().getConnection();

			StringBuilder sql = new StringBuilder();
			/* 시퀀스 다음 값 추출 할 때는 nextval */
			sql.append("insert into t_board(no, title, writer, content) ");
			sql.append(" values(seq_t_board_no.nextval, ?, ?, ?) ");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, board.getTitle()); // 첫번째 ? 자리에 제목 집어넘
			pstmt.setString(2, board.getWriter()); 
			pstmt.setString(3, board.getContent()); 
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			
		} finally {
			JDBCClose.close(pstmt, conn);
		}
	}
	
	/***
	 * no에 해당하는 게시물 조회 메소드
	 * 
	 * 리턴되는 레코드가 한개이므로 리턴타입은 BoardVO
	 */
	public BoardVO selectByNo(int no) {
		StringBuilder sql = new StringBuilder();
		sql.append("select no,title,writer,content,view_cnt ");
		sql.append(" , to_char(reg_date, 'yyyy-mm-dd') as reg_date from t_board where no=?");
		
		try(  Connection conn = new ConnectionFactory().getConnection();  
			  PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			){
			
			pstmt.setInt(1,no);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
	
				int boardNo = rs.getInt("no");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String content = rs.getString("content");
				int viewCnt = rs.getInt("view_cnt");
				String regDate = rs.getString("reg_date");
				
				BoardVO board = new BoardVO(boardNo, title, writer, content, viewCnt, regDate);
				
				return board;
			}
			
		} catch ( Exception e) {
			e.printStackTrace();
		}
			
		return null;  //아무것도 조회되지 않을 때 null 출력
	}
}
