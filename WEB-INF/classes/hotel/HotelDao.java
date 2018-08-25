package hotel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;


public class HotelDao implements IHotelDao {
	
	private static HotelDao hoteldao = null;
	
	private HotelDao() {
		DBConn.initConnect();
	}
	
	public static HotelDao getInstance() {
		if(hoteldao == null){
			hoteldao = new HotelDao();
		}
		return hoteldao;
	}

	@Override
	public List<HotelDto> getHotelList(String location, String checkIn, String checkout) {
		
		String sql = " SELECT H_NUM, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_LOCATION, H_PRICE, H_ROOM "
				+ " FROM AIR_HOTEL "
				+ " WHERE H_LOCATION = ? AND H_CHECK_IN = ? AND H_CHECK_OUT = ? "
				+ " AND H_ROOM > 0 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<HotelDto> list = new ArrayList<HotelDto>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getHotelList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, location);
			psmt.setString(2, checkIn);
			psmt.setString(3, checkout);
			System.out.println("3/6 S getHotelList");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getHotelList");
			
			while(rs.next()){
				int i = 1;
				HotelDto dto = new HotelDto(rs.getInt(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getString(i++), 
											rs.getInt(i++), 
											rs.getInt(i++));				
				list.add(dto);
				System.out.println("5/6 S getHotelList");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S getHotelList");
		}		
		return list;
	}

	@Override
	public HotelDto getHotelDetail(int seq) {
		
		String sql = " SELECT H_NUM, H_NAME, H_CHECK_IN, H_CHECK_OUT, "
				+ " H_LOCATION, H_PRICE, H_ROOM "
				+ " FROM AIR_HOTEL "
				+ " WHERE H_NUM = ? ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		HotelDto dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getHotelDetail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S getHotelDetail");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getHotelDetail");
			
			while(rs.next()){
				int i = 1;
				dto = new HotelDto(rs.getInt(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getString(i++), 
									rs.getInt(i++), 
									rs.getInt(i++));				
			}
			
			System.out.println("5/6 S getHotelDetail");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S getHotelDetail");
		}		
		return dto;
	}

	@Override
	public boolean hotelReserved(int seq, int room) {
		
		String sql = " UPDATE AIR_HOTEL "
				+ " SET H_ROOM = H_ROOM - ? "
				+ " WHERE H_NUM = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S hotelReserved");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, room);
			psmt.setInt(2, seq);
			System.out.println("3/6 S hotelReserved");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S hotelReserved");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S hotelReserved");
		}			
		return count>0?true:false;
	}

	@Override
	public boolean hotelCanceled(int seq, int room) {
		
		String sql = " UPDATE AIR_HOTEL "
				+ " SET H_ROOM = H_ROOM + ? "
				+ " WHERE H_NUM = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S hotelCanceled");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, room);
			psmt.setInt(2, seq);
			System.out.println("3/6 S hotelCanceled");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S hotelCanceled");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S hotelCanceled");
		}			
		return count>0?true:false;
	}
	
	
	

}
