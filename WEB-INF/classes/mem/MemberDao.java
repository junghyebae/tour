package mem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.DBConn;

public class MemberDao implements IMemberDao {
	
private static MemberDao memberdao = null;
	
	private MemberDao() {
		DBConn.initConnect();
	}
	
	public static MemberDao getInstance() {
		if(memberdao == null){
			memberdao = new MemberDao();
		}
		return memberdao;
	}

	@Override
	public boolean addMember(MemberDto dto) {
		
		String sql = " INSERT INTO AIR_MEMBER "
				+ " (ID, PWD, NAME, PHONE, EMAIL, BIRTH, GRADE, AUTH, DEL, M_NUM) "
				+ " VALUES(?, ?, ?, ?, ?, ?, 0, 0, 0, SEQ_M_NUM.NEXTVAL) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addMember");		// 확인용
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getBirth());
			System.out.println("3/6 S addMember");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addMember");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addMember");
		}		
		return count>0 ? true:false;
	}

	@Override
	public boolean checkId(String id) {
		
		String sql = " SELECT ID FROM AIR_MEMBER "
				+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean b = true;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S checkId");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S checkId");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S checkId");
			
			while(rs.next()){
				b = false;
				System.out.println("5/6 S checkId");
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S checkId");
		}		
		return b;
	}

	@Override
	public boolean checkEmail(String email) {
		
		String sql = " SELECT EMAIL FROM AIR_MEMBER "
				+ " WHERE EMAIL = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean b = true;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S checkEmail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			System.out.println("3/6 S checkEmail");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S checkEmail");
			
			while(rs.next()){
				b = false;
				System.out.println("5/6 S checkEmail");
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S checkEmail");
		}		
		return b;
	}

	@Override
	public MemberDto login(String id, String pwd) {
		String sql = " SELECT ID, PWD, NAME, PHONE, EMAIL, BIRTH, GRADE, AUTH, DEL, M_NUM "
				+ " FROM AIR_MEMBER "
				+ " WHERE ID = ? AND PWD = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S login");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("3/6 S login");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S login");
			
			while(rs.next()){
				int i = 1;
				dto = new MemberDto(rs.getString(i++), 	// id
									rs.getString(i++), 	// pwd
									rs.getString(i++),  // name
									rs.getString(i++),  // phone
									rs.getString(i++), 	// email
									rs.getString(i++),  // birth
									rs.getInt(i++), 	// grade
									rs.getInt(i++), 	// auth
									rs.getInt(i++),		// del
									rs.getInt(i++));	// seq
				
			}	
			System.out.println("5/6 S login");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S login");
		}		
		return dto;
	}

	@Override
	public boolean delId(String id) {
		String sql = " UPDATE AIR_MEMBER "
				+ " SET DEL = 1, EMAIL = NULL "
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
	public String findId(String email, String phone) {
		
		String sql = " SELECT ID "
				+ " FROM AIR_MEMBER "
				+ " WHERE EMAIL = ? AND PHONE = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String id = "";
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S findId");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			psmt.setString(2, phone);
			System.out.println("3/6 S findId");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S findId");
			
			while(rs.next()){
				id = rs.getString(1);
				System.out.println("5/6 S findId");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S findId");
		}		
		return id;
	}

	@Override
	public String findPwd(String id, String email) {

		String sql = " SELECT PWD "
				+ " FROM AIR_MEMBER "
				+ " WHERE ID = ? AND EMAIL = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String pwd = "";
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S findPwd");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, email);
			System.out.println("3/6 S findPwd");
			System.out.println(id+"e" +email);
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S findPwd");
			
			while(rs.next()){
				pwd = rs.getString(1);
				System.out.println("5/6 S findPwd");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S findPwd");
		}		
		return pwd;
	}

	@Override
	public boolean updateMember(String id, MemberDto dto) {
		
		String sql = " UPDATE AIR_MEMBER"
				+ " SET PWD = ?, NAME = ?, PHONE = ?, EMAIL = ?, BIRTH = ? "
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
			psmt.setString(6, dto.getId());
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
	public boolean plusGrade(String id, int num) {
		
		String sql = " UPDATE AIR_MEMBER "
				+ " SET GRADE = GRADE + ? "
				+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S plusGrade");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			psmt.setString(2, id);
			System.out.println("3/6 S plusGrade");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S plusGrade");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S plusGrade");
		}		
		return count>0?true:false;
	}

	@Override
	public boolean minusGrade(String id, int num) {
		String sql = " UPDATE AIR_MEMBER "
				+ " SET GRADE = GRADE - ? "
				+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S minusGrade");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			psmt.setString(2, id);
			System.out.println("3/6 S minusGrade");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S minusGrade");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S minusGrade");
		}		
		return count>0?true:false;
	}
	
	@Override
	public int getGrade(String id) {
		
		String sql = " SELECT GRADE "
				+ " FROM AIR_MEMBER "
				+ " WHERE ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int grade = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getGrade");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S getGrade");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getGrade");
			
			while(rs.next()){
				grade = rs.getInt(1);
				System.out.println("5/6 S getGrade");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S getGrade");
		}		
		return grade;
	}

}










