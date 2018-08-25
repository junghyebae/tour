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




public class AirplainDao implements IAirplainDao {

	private static AirplainDao airplainDao = null;
	
	private AirplainDao() {
		DBConn.initConnect();
	}
	
	public static AirplainDao getInstance() {
		if(airplainDao == null){
			airplainDao = new AirplainDao();
		}
		return airplainDao;
	}
	
	@Override
	public boolean addAirplain(AirplainDto dto) {
		
		String sql = " INSERT INTO AIR_INFO "
				+ " (A_NUM, A_NAME, A_SEAT_ONE, A_SEAT_TWO ,A_SEAT_THREE , "
				+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE ) "
				+ " VALUES(SEQ_A_NUM.NEXTVAL, ?, ?, ?, ?, ?, ?, ? , ?, ?) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addAirplain");		// 확인용
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getA_name()); //비행기이름
			psmt.setInt(2, dto.getA_seat_one()); //좌석1
			psmt.setInt(3, dto.getA_seat_two()); //좌석2
			psmt.setInt(4, dto.getA_seat_three()); //좌석3
			psmt.setString(5, dto.getA_location_s()); //출발지
			psmt.setString(6, dto.getA_location_e()); //도착위치
			psmt.setString(7, dto.getA_time_s()); //출발시간
			psmt.setString(8, dto.getA_time_e()); //도착시간
			psmt.setInt(9, dto.getA_price()); //가격
			System.out.println("3/6 S addAirplain");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addAirplain");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addAirplain");
		}		
		return count>0 ? true:false;
		
		
	}

	//리스트불러오기(검색아님)
	public List<AirplainDto> airplainList(PagingBean paging) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<AirplainDto> airlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S airplainList");
			
			//총 데이터의 갯수 구하기
			String totalSql = " SELECT COUNT(A_NUM) FROM AIR_INFO";
			psmt= conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //글의 총갯수
			paging.setTotalCount(totalCount); //글의 총갯수넣기
			System.out.println("2/6 S airplainList");
			
			paging = PagingUtil.setPasingInfo(paging);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_INFO ORDER BY A_NUM) "
					+ " WHERE ROWNUM <="+paging.getStartNum()+" ORDER BY A_NUM DESC) "
					+ " WHERE ROWNUM <="+paging.getCountPerPage();
			System.out.println("sql ="+sql);
			System.out.println("3/6 S airplainList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("4/6 S airplainList");
			
			while(rs.next()){
				int i=1;
				AirplainDto dto = new AirplainDto(
						rs.getInt(i++),//a_num 
						rs.getString(i++), //a_name
						rs.getInt(i++), //a_seat_one 
						rs.getInt(i++), //a_seat_two
						rs.getInt(i++), //a_seat_three 
						rs.getString(i++),//a_location_s 
						rs.getString(i++), //a_location_e 
						rs.getString(i++), //a_time_s
						rs.getString(i++), //a_time_e
						rs.getInt(i++) //a_price
						);
				airlist.add(dto);
			}
			System.out.println("5/6 S airplainList");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S airplainList");
		}
		
		return airlist;
	}

	@Override
	public List<AirplainDto> searchAirplainList(String type, String test, PagingBean paging) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<AirplainDto> airlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S searchAirplainList");
			
			//총 데이터의 갯수 구하기
			String totalSql = " SELECT COUNT(A_NUM) FROM AIR_INFO";
			psmt= conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //글의 총갯수
			paging.setTotalCount(totalCount); //글의 총갯수넣기
			System.out.println("2/6 S airplainList");
			
			paging = PagingUtil.setPasingInfo(paging);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_INFO ORDER BY A_NUM) "
					+ " WHERE ROWNUM <="+paging.getStartNum()+" ORDER BY A_NUM DESC) "
					+ " WHERE ROWNUM <="+paging.getCountPerPage();
			System.out.println("sql ="+sql);
			System.out.println("3/6 S airplainList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("4/6 S airplainList");
			
			while(rs.next()){
				int i=1;
				AirplainDto dto = new AirplainDto(
						rs.getInt(i++),//a_num 
						rs.getString(i++), //a_name
						rs.getInt(i++), //a_seat_one 
						rs.getInt(i++), //a_seat_two
						rs.getInt(i++), //a_seat_three 
						rs.getString(i++),//a_location_s 
						rs.getString(i++), //a_location_e 
						rs.getString(i++), //a_time_s
						rs.getString(i++), //a_time_e
						rs.getInt(i++) //a_price
						);
				airlist.add(dto);
			}
			System.out.println("5/6 S airplainList");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S airplainList");
		}
		
		return airlist;
		
	}

	@Override
	public boolean removeAirplain(int a_num) {
		String sql = " DELETE FROM AIR_INFO "
				+ " WHERE A_NUM=?";
		Connection conn = null;
		PreparedStatement psmt = null;		
		
		int count = 0;

		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S removeAirplain");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, a_num);

			System.out.println("3/6 S removeAirplain");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S removeAirplain");
			
		} catch (SQLException e) {			
			System.out.println(e.getMessage());
		} finally{
			DBConn.close(psmt, conn);
			System.out.println("5/6 S removeAirplain");
		}
				
		return count>0?true:false;

	}

	@Override
	public AirplainDto airplainDetail(int a_num) {
		
		String sql = " SELECT A_NUM, A_NAME,A_SEAT_ONE,A_SEAT_TWO,A_SEAT_THREE, "
				+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE "
				+ " FROM AIR_INFO " 
				+ " WHERE A_NUM=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		AirplainDto dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S airplainDetail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, a_num);
			System.out.println("3/6 S airplainDetail");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S airplainDetail");
			
			while(rs.next()){
				int i = 1;
				dto = new AirplainDto(
						rs.getInt(i++),	
						rs.getString(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getInt(i++)
						);				
			}
			System.out.println("5/6 S airplainDetail");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S airplainDetail");
		}
		
		return dto;
	}

	@Override
	public boolean cancelSeat(int seats, int type, int a_num) {
		
		String sql="";
		
		//일등석
		if(type==1){
		sql = " UPDATE AIR_INFO SET A_SEAT_ONE = A_SEAT_ONE+"+seats
				+ " WHERE A_NUM="+a_num;
		}
		//비즈니스석
		if(type==2){
		sql = " UPDATE AIR_INFO SET A_SEAT_TWO = A_SEAT_TWO+"+seats
				+ " WHERE A_NUM="+a_num;
		}
		//일반석
		if(type==3){
		sql = " UPDATE AIR_INFO SET A_SEAT_THREE = A_SEAT_THREE+"+seats
				+ " WHERE A_NUM="+a_num;
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count =0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S cancelSeat");
			
			psmt = conn.prepareStatement(sql);

			System.out.println("3/6 S cancelSeat");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S cancelSeat");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S cancelSeat");
		}		
		
		return count>0?true:false;
	}

}
