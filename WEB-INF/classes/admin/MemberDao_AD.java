package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import paging.PagingUtil2;
import jdbc.DBConn;
import paging.PagingBean;

public class MemberDao_AD implements IMemberDao_AD {
	
private static MemberDao_AD memberdao = null;
	
	private MemberDao_AD() {
		DBConn.initConnect();
	}
	
	public static MemberDao_AD getInstance() {
		if(memberdao == null){
			memberdao = new MemberDao_AD();
		}
		return memberdao;
	}

	@Override
	public List<MemberDto_AD> getMemberList() {
		
		String sql = " SELECT ID, PWD, NAME, PHONE, EMAIL, BIRTH, GRADE, AUTH, DEL, M_NUM "
				+ " FROM AIR_MEMBER "
				+ " WHERE DEL != 1 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto_AD> list = new ArrayList<MemberDto_AD>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getMemberList");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/6 S getMemberList");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getMemberList");
			
			while(rs.next()){
				int i = 1;
				MemberDto_AD dto = new MemberDto_AD(rs.getString(i++), 		// id
														rs.getString(i++), 	// pwd
														rs.getString(i++), 	// name
														rs.getString(i++),  // phone
														rs.getString(i++),  // email
														rs.getString(i++),  // birth
														rs.getInt(i++), 	// grade
														rs.getInt(i++), 	// auth
														rs.getInt(i++),		// del
														rs.getInt(i++));	// seq
				list.add(dto);
			}
			System.out.println("5/6 S getMemberList");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("6/6 S getMemberList");
		}		
		return list;
	}

	@Override
	public boolean updateMember(MemberDto_AD dto) {
		
		String sql = " UPDATE AIR_MEMBER "
				+ " SET PWD = ?, "
				+ " NAME = ?, "
				+ " PHONE = ?, "
				+ " EMAIL = ?, "
				+ " BIRTH = ?, "
				+ " GRADE = ? "
				+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S updateMember");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getPwd());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPhone());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getBirth());
			psmt.setInt(6, dto.getGrade());
			psmt.setString(7, dto.getId());
			System.out.println("3/6 S updateMember");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S updateMember");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S updateMember");
		}		
		return count>0?true:false;
	}

	@Override
	public boolean delId(String id) {
		String sql = " UPDATE AIR_MEMBER "
				+ " SET DEL = 1 "
				+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S delId");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S delId");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S delId");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S delId");
		}		
		return count>0?true:false;
	}

	@Override
	public List<MemberDto_AD> getMemberListPaging(PagingBean paging) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto_AD> list = new ArrayList<>();		
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S getMemberListPaging");
			
			String totalSql = " SELECT COUNT(*) FROM AIR_MEMBER WHERE DEL != 1 ";
			psmt = conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1);	// row의 총 갯수
			paging.setTotalCount(totalCount);
			paging = PagingUtil2.setPasingInfo(paging);
			
			psmt.close();
			rs.close();			
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_MEMBER WHERE DEL != 1 "
					+ " ORDER BY M_NUM) "
					+ " WHERE ROWNUM <=" + paging.getStartNum() + " ORDER BY M_NUM DESC) "
					+ " WHERE ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("paging.getStartNum():" + paging.getStartNum());
			System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 S getMemberListPaging");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 S getMemberListPaging");
			
			while(rs.next()){
				int i = 1;
				MemberDto_AD dto = new MemberDto_AD(rs.getString(i++), 	// id
													rs.getString(i++), 	// pwd
													rs.getString(i++), 	// name
													rs.getString(i++),  // phone
													rs.getString(i++),  // email
													rs.getString(i++),  // birth
													rs.getInt(i++), 	// grade
													rs.getInt(i++), 	// auth
													rs.getInt(i++),		// del
													rs.getInt(i++));	// seq
				list.add(dto);				
			}	
			System.out.println("4/6 S getMemberListPaging");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("5/6 S getMemberListPaging");
		}			
		return list;
	}

	@Override
	public MemberDto_AD getMember(String id) {
		String sql = " SELECT ID, PWD, NAME, PHONE, EMAIL, BIRTH, GRADE, AUTH, DEL, M_NUM "
				+ " FROM AIR_MEMBER "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto_AD dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getMember");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S getMember");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getMember");
			
			while(rs.next()){
				int i = 1;
			 dto = new MemberDto_AD(rs.getString(i++), 		// id
									rs.getString(i++), 	// pwd
									rs.getString(i++), 	// name
									rs.getString(i++),  // phone
									rs.getString(i++),  // email
									rs.getString(i++),  // birth
									rs.getInt(i++), 	// grade
									rs.getInt(i++), 	// auth
									rs.getInt(i++),		// del
									rs.getInt(i++));	// seq
				
			}
			System.out.println("5/6 S getMember");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("6/6 S getMember");
		}		
		return dto;
	}

	@Override
	public boolean addGrade(int people, String id) {
		
		String sql = " UPDATE AIR_MEMBER SET GRADE = GRADE +"+people
				+ " WHERE ID =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count =0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addGrade");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S addGrade");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addGrade");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addGrade");
		}		
		
		return count>0?true:false;
	}

}










