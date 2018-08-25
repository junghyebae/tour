package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;
import paging.PagingBean;
import paging.PagingUtil;

public class HotelDao implements IHotelDao {

	private static HotelDao hotelDao = null;
	
	private HotelDao() {
		DBConn.initConnect();
	}
	
	public static HotelDao getInstance() {
		if(hotelDao == null){
			hotelDao = new HotelDao();
		}
		return hotelDao;
	}
	
	//단일추가
	public boolean addHotel(HotelDto dto) {
		
		String sql = " INSERT INTO AIR_HOTEL "
				+ " (H_NUM, H_NAME, H_CHECK_IN, H_CHECK_OUT, H_LOCATION, "
				+ " H_PRICE, H_ROOM ) "
				+ " VALUES(SEQ_AIR_HOTEL.NEXTVAL, ?, ?, ?, ?, ?, ?) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addHotel");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getName()); //호텔명
			psmt.setString(2, dto.getCheckIn()); //체크인
			psmt.setString(3, dto.getCheckOut()); //체크아웃
			psmt.setString(4, dto.getLocation()); //장소
			psmt.setLong(5, dto.getPrice()); //가격
			psmt.setInt(6, dto.getRoom()); //최대 방수

			System.out.println("3/6 S addHotel");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addHotel");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addHotel");
		}		
		return count>0 ? true:false;
		
		
	}

	@Override
	public List<HotelDto> hotelList(PagingBean paging) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<HotelDto> holist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S hotelList");
			
			//총 데이터의 갯수 구하기
			String totalSql = " SELECT COUNT(H_NUM) FROM AIR_HOTEL";
			psmt= conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //글의 총갯수
			paging.setTotalCount(totalCount); //글의 총갯수넣기
			System.out.println("2/6 S hotelList");
			
			paging = PagingUtil.setPasingInfo(paging);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_HOTEL ORDER BY H_NUM) "
					+ " WHERE ROWNUM <="+paging.getStartNum()+" ORDER BY H_NUM DESC) "
					+ " WHERE ROWNUM <="+paging.getCountPerPage();
			System.out.println("sql ="+sql);
			System.out.println("3/6 S hotelList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("4/6 S hotelList");
			
			while(rs.next()){
				int i=1;
				HotelDto dto = new HotelDto(
						rs.getInt(i++),//h_num
						rs.getString(i++), //h_name
						rs.getString(i++), //h_check_in
						rs.getString(i++), //h_check_out
						rs.getString(i++), //h_location
						rs.getLong(i++), //h_price
						rs.getInt(i++) //h_room
						);
				holist.add(dto);
			}
			System.out.println("5/6 S hotelList");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S hotelList");
		}
		
		return holist;
	}
	
	public boolean removeHotel(int h_num) {
		String sql = " DELETE FROM AIR_HOTEL "
				+ " WHERE H_NUM=?";
		Connection conn = null;
		PreparedStatement psmt = null;		
		
		int count = 0;

		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S removeHotel");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, h_num);

			System.out.println("3/6 S removeHotel");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S removeHotel");
			
		} catch (SQLException e) {			
			System.out.println(e.getMessage());
		} finally{
			DBConn.close(psmt, conn);
			System.out.println("5/6 S removeHotel");
		}
				
		return count>0?true:false;
	}

	@Override
	public HotelDto getHotel(int h_num) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		HotelDto dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S getHotel");
			
			String sql = " SELECT H_NUM, H_NAME,H_CHECK_IN,H_CHECK_OUT, H_LOCATION,"
					+ " H_PRICE,H_ROOM "
					+ " FROM AIR_HOTEL "
					+ " WHERE H_NUM =?";
			System.out.println("3/6 S getHotel");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, h_num);
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getHotel");
			
			while(rs.next()){
				int i=1;
				dto = new HotelDto(
						rs.getInt(i++),//h_num
						rs.getString(i++), //h_name
						rs.getString(i++), //h_check_in
						rs.getString(i++), //h_check_out
						rs.getString(i++), //h_location
						rs.getLong(i++), //h_price
						rs.getInt(i++) //h_room
						);
			}
			System.out.println("5/6 S getHotel");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S getHotel");
		}
		
		return dto;
	}
}
