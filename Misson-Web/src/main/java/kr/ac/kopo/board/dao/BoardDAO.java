package kr.ac.kopo.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.board.vo.BoardFileVO;
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
	

	//	새글 등록을 위한 seq_t_board_no의 시퀀스 추출
	
	public int selectBoardNo() {
		String sql = " select seq_t_board_no.nextval from dual";
	
		try(Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
	       ){
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return 0;
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
			sql.append(" values(?, ?, ?, ?) ");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			int loc = 1; 
			pstmt.setInt(loc++, board.getNo()); // 첫번째 ? 자리에 번호 집어넘
			pstmt.setString(loc++, board.getTitle()); // 두번째 ? 자리에 제목 집어넘
			pstmt.setString(loc++, board.getWriter()); 
			pstmt.setString(loc++, board.getContent()); 
			
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
	
	//첨부파일 crud
	
	public void insertBoardFile(BoardFileVO fileVO) {
		System.out.println(fileVO);
		StringBuilder sql = new StringBuilder();
		sql.append("insert into t_board_file( ");
		sql.append("              no, board_no, file_ori_name ");
		sql.append("              , file_save_name, file_size) ");
		sql.append(" values(seq_t_board_file_no.nextval, ?, ?, ?, ?) ");
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		) {
			 pstmt.setInt(1, fileVO.getBoardNo());
			 pstmt.setString(2, fileVO.getFileOriName());
			 pstmt.setString(3, fileVO.getFileSaveName());
			 pstmt.setInt(4, fileVO.getFileSize());
			 
			 pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	//첨부파일 조회
	public List<BoardFileVO> selectFileByNo(int boardNo) {
		
		List<BoardFileVO> fileList = new ArrayList<>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("select no, file_ori_name, file_save_name, file_size ");
		sql.append("  from t_board_file ");
		sql.append(" where board_no = ? ");
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		) {
			pstmt.setInt(1, boardNo);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardFileVO fileVO = new BoardFileVO();
				fileVO.setNo(rs.getInt("no"));
				fileVO.setFileOriName(rs.getString("file_ori_name"));
				fileVO.setFileSaveName(rs.getString("file_save_name"));
				fileVO.setFileSize(rs.getInt("file_size"));
				
				fileList.add(fileVO);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return fileList;
	}

	//조회수
	public void addViewCnt(int no) {
		String sql = "update t_board set view_cnt=view_cnt+1 where no = ? ";
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)
				){
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
