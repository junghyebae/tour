package hotelRes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;

public class hotelResDao implements IhotelResDao {

private static hotelResDao hotelresDao = null;
	
	private hotelResDao() {
		DBConn.initConnect();
	}
	
	public static hotelResDao getInstance() {
		if(hotelresDao == null){
			hotelresDao = new hotelResDao();
		}
		return hotelresDao;
	}
	
	
	/*@Override
	public boolean addHotelRes(hotelResDto dto) {
		
		String sql = " INSERT INTO AIR_HOTEL_RESERVE (H_SEQ, H_NUM, H_ID, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_PRICE, H_ROOM, H_LOCATION, H_WDATE, H_EMAIL) "
				+ " VALUES (SEQ_AIR_HOTEL_RES.NEXTVAL, "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addHotelRes");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, dto.getNum());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getCheckIn());
			psmt.setString(5, dto.getCheckOut());
			psmt.setInt(6, dto.getPrice());
			psmt.setInt(7, dto.getRoom());
			psmt.setString(8, dto.getLocation());
			psmt.setString(9, dto.getEmail());
			System.out.println("3/6 S addHotelRes");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addHotelRes");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addHotelRes");
		}			
		return count>0?true:false;
	}*/

	@Override
	public List<hotelResDto> getHotelList(String id) {
		
		String sql = " SELECT H_SEQ, H_NUM, H_ID, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_PRICE, H_ROOM, H_LOCATION, H_WDATE, H_EMAIL "
				+ " FROM AIR_HOTEL_RESERVE "
				+ " WHERE H_ID = ? "
				+ " ORDER BY H_SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<hotelResDto> list = new ArrayList<hotelResDto>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getHotelList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S getHotelList");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getHotelList");
			
			while(rs.next()){
				int i = 1;
				hotelResDto dto = new hotelResDto(rs.getInt(i++), 	// seq
												rs.getInt(i++),
												rs.getString(i++), 	// id
												rs.getString(i++), 	// name
												rs.getString(i++), 	// checkin
												rs.getString(i++), 	// checkout
												rs.getInt(i++), 	// price
												rs.getInt(i++), 	// room
												rs.getString(i++), 	// location
												rs.getString(i++),	// date
												rs.getString(i++)); // email
				list.add(dto);
			}
			System.out.println("5/6 S getHotelList");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S getHotelList");
		}	
		return list;
	}

	@Override
	public boolean cancelHotel(int seq) {
		
		String sql = " DELETE FROM AIR_HOTEL_RESERVE "
				+ " WHERE H_SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S cancelHotel");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S cancelHotel");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S cancelHotel");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S cancelHotel");
		}			
		return count>0?true:false;
	}

	@Override
	public int addHotelRes(hotelResDto dto) {
		// insert
		String sql1 = " INSERT INTO AIR_HOTEL_RESERVE (H_SEQ, H_NUM, H_ID, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_PRICE, H_ROOM, H_LOCATION, H_WDATE, H_EMAIL) "
				+ " VALUES (SEQ_AIR_HOTEL_RES.NEXTVAL, "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?) ";
		
		// select
		String sql2 = " SELECT SEQ_AIR_HOTEL_RES.CURRVAL FROM DUAL ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int seq = 0;
		
		try {
			conn = DBConn.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 S addHotelRes");
			
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, dto.getNum());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getCheckIn());
			psmt.setString(5, dto.getCheckOut());
			psmt.setInt(6, dto.getPrice());
			psmt.setInt(7, dto.getRoom());
			psmt.setString(8, dto.getLocation());
			psmt.setString(9, dto.getEmail());
			System.out.println("2/6 S addHotelRes");
			
			psmt.executeUpdate();
			System.out.println("3/6 S addHotelRes");
			
			psmt.clearParameters();			
			
			psmt = conn.prepareStatement(sql2);
			System.out.println("4/6 S addHotelRes");
			
			rs = psmt.executeQuery();
			
			while(rs.next()){
				seq = rs.getInt(1);
			}
			conn.commit();
			System.out.println("5/6 S addHotelRes");
			
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConn.close(psmt, conn);
			System.out.println("6/6 S addHotelRes");
		}		
		return seq;
	}

	@Override
	public List<hotelResDto> getHotelList2(int resNum, String email) {
		
		String sql = " SELECT H_SEQ, H_NUM, H_ID, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_PRICE, H_ROOM, H_LOCATION, H_WDATE, H_EMAIL "
				+ " FROM AIR_HOTEL_RESERVE "
				+ " WHERE H_SEQ = ? AND H_EMAIL = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<hotelResDto> list = new ArrayList<hotelResDto>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getHotelList2");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, resNum);
			psmt.setString(2, email);
			System.out.println("3/6 S getHotelList2");
			System.out.println("e" + email + resNum);
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getHotelList2");
			
			while(rs.next()){
				int i = 1;
				hotelResDto dto = new hotelResDto(rs.getInt(i++), 	// seq
												rs.getInt(i++),
												rs.getString(i++), 	// id
												rs.getString(i++), 	// name
												rs.getString(i++), 	// checkin
												rs.getString(i++), 	// checkout
												rs.getInt(i++), 	// price
												rs.getInt(i++), 	// room
												rs.getString(i++), 	// location
												rs.getString(i++),	// date
												rs.getString(i++)); // email
				list.add(dto);
			}
			System.out.println("5/6 S getHotelList2");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("6/6 S getHotelList2");
		}	
		return list;
	}



}









