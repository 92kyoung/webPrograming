package kr.ac.kopo.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.member.vo.MemberVO;
import kr.ac.kopo.util.ConnectionFactory;
import kr.ac.kopo.util.JDBCClose;

public class MemberDAO {
	// 전체 회원 조회 메소드
	public List<MemberVO> showAllMember() {
		List<MemberVO> memberList = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select id,name,password,tel1,tel2,tel3,POST,BASIC_ADDR");
		sql.append("  from T_MEMBER order by id ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String password = rs.getString("password");

				String tel1 = rs.getString("tel1");
				String tel2 = rs.getString("tel2");
				String tel3 = rs.getString("tel3");
				if (rs.getString("tel1") == null || rs.getString("tel2") == null || rs.getString("tel3") == null) {
					tel1 = "미입력";
				}
				;

				String post = rs.getString("POST");

				if (rs.getString("POST") == null) {
					post = "미입력";
				}
				;

				String basic_addr = rs.getString("BASIC_ADDR");

				if (rs.getString("BASIC_ADDR") == null) {
					basic_addr = "미입력";
				}
				;

				MemberVO member = new MemberVO(id, name, password, tel1, tel2, tel3, post, basic_addr);

				memberList.add(member);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		return memberList;
	}

	// 인서트 메소드
	public void insertMember(MemberVO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = new ConnectionFactory().getConnection();

			StringBuilder sql = new StringBuilder();
			sql.append(
					"insert into t_member (id,name,password,email_id,email_domain,tel1,tel2,tel3,post,basic_addr,detail_addr) values (?,?,?,?,?,?,?,?,?,?,?) ");

			pstmt = conn.prepareStatement(sql.toString());

			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPassword());
			pstmt.setString(4, member.getEmail_id());
			pstmt.setString(5, member.getEmail_domain());
			pstmt.setString(6, member.getTel1());
			pstmt.setString(7, member.getTel2());
			pstmt.setString(8, member.getTel3());
			pstmt.setString(9, member.getPost());
			pstmt.setString(10, member.getBasic_addr());
			pstmt.setString(11, member.getDetail_addr());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			JDBCClose.close(pstmt, conn);
		}
	}

	public MemberVO selectById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = new ConnectionFactory().getConnection();

			StringBuilder sql = new StringBuilder();
			sql.append("select id,name,password,email_id,email_domain,tel1,tel2,tel3,post,basic_addr,detail_addr,type");
			sql.append(" , to_char(reg_date, 'yyyy-mm-dd') as reg_date from t_member where id=?");

			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String memberId = rs.getString("id");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String email_id = rs.getString("email_id");
				String email_domain = rs.getString("email_domain");
				String tel1 = rs.getString("tel1");
				String tel2 = rs.getString("tel2");
				String tel3 = rs.getString("tel3");
				String post = rs.getString("post");
				String basic_addr = rs.getString("basic_addr");
				String detail_addr = rs.getString("detail_addr");
				String type = rs.getString("type");
				String reg_date = rs.getString("reg_date");

				MemberVO member = new MemberVO(memberId, name, password, email_id, email_domain, tel1, tel2, tel3, post,
						basic_addr, detail_addr, type, reg_date);
				
				return member;
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return null;
	}
}
