package air;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;

public class AirPlainDAO implements IAirPlainDAO {

	private static AirPlainDAO airplaindao = null;
	
	private AirPlainDAO(){
		DBConn.initConnect();
	}
	
	public static AirPlainDAO getInstance() {
		
		if(airplaindao == null){
			airplaindao = new AirPlainDAO();
		}
		return airplaindao;
	}

	/**
	 * 비행기 리스트
	 */
	@Override
	public List<AirPlainDTO> getAirplainList() {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<AirPlainDTO> list = new ArrayList<>();
		AirPlainDTO airplaindto = null;
		
		String sql = "SELECT DISTINCT A_NAME FROM AIR_INFO";
		System.out.println("sql : " + sql);
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getAirplainList()");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/6 S getAirplainList()");
			
			rs = psmt.executeQuery();
			while(rs.next()){
				AirPlainDTO dto = new AirPlainDTO();
				dto.setA_name(rs.getString(1));
				
				list.add(dto);
				System.out.println("4/6 S getAirplainList()");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("5/6 S getAirplainList()");
		}
		
		return list;
	}

	/**
	 * 출발 & 도착 리스트
	 */
	@Override
	public List<AirPlainDTO> getAirplainCntList() {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<AirPlainDTO> list = new ArrayList<>();
		AirPlainDTO airplaindto = null;
		
		String sql = "SELECT DISTINCT A_LOCATION_S  FROM AIR_INFO";
		System.out.println("sql : " + sql);
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getAirplainList()");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/6 S getAirplainList()");
			
			rs = psmt.executeQuery();
			while(rs.next()){
				AirPlainDTO dto = new AirPlainDTO();
				dto.setA_location_s(rs.getString(1));
				
				list.add(dto);
				System.out.println("4/6 S getAirplainList()");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("5/6 S getAirplainList()");
		}
		
		return list;
	}
	
	
	// TODO Auto-generated method stub
	@Override
	public AirPlainDTO getAdto(int a_num) {
		
		String sql = " SELECT * FROM AIR_INFO WHERE A_NUM = ?";
		
		System.out.println("sql: " + sql);				
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		AirPlainDTO dto = null;
		
		try {
			conn = DBConn.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, a_num);
			
			rs = psmt.executeQuery();
			
			while(rs.next()){
				int i = 1;
				dto = new AirPlainDTO(
						//a_num,
						rs.getInt(i++),
						//a_name,
						rs.getString(i++),
						//a_seat_one,
						rs.getInt(i++),
						//a_seat_two,
						rs.getInt(i++),
						//a_seat_three,
						rs.getInt(i++),
						// a_location_s,
						rs.getString(i++),
						//a_location_e,
						rs.getString(i++),
						//a_time_s, 
						rs.getLong(i++),
						//a_time_e, 
						rs.getLong(i++),
						//a_price);
						rs.getLong(i++));
			}			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
		
		return dto;
	}
	
	
	
	
	
}
