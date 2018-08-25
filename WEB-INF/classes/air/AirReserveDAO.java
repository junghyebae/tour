package air;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.DBConn;

public class AirReserveDAO implements IAirReserveDAO {
	
	private static AirReserveDAO airReservedao = null;
	
	private AirReserveDAO() {
		DBConn.initConnect();
	}
	
	public static AirReserveDAO getInstance() {
		
		if(airReservedao == null){
			airReservedao = new AirReserveDAO();
		}
		return airReservedao;
	}
	
	/*
	 예약번호(시퀀스), 아이디, 비행기번호(AIR_INFO의 A_NUM 외래키), 상품명(AIR_PACKAGE의 P_NAME),
	 출발일, 귀국일, 인원수(성인), 인원수(아동), 인원수(유아), 좌석명, 총가격, 예약일
	 */
	/**
	 * 항공권 예약하기
	 */
	@Override
	public boolean AirReserve(AirReserveDTO dto) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		boolean b = false;
		String sql = "INSERT INTO AIR_RESERVE "
				   + "VALUES(SEQ_R_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,SYSDATE,1)";
		
		System.out.println("sql : " + sql);
		System.out.println("제발좀 : " + dto.toString());
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/5 S AirReserve");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getR_ID());
			psmt.setInt(2, dto.getR_INFO_NUM());
			psmt.setString(3, dto.getR_PACK_NAME());
			psmt.setString(4, dto.getR_ST_DATE());
			psmt.setString(5, dto.getR_EN_DATE());
			psmt.setInt(6, dto.getR_PPLE_NUM_ADT());
			psmt.setInt(7, dto.getR_PPLE_NUM_CHI());
			psmt.setInt(8, dto.getR_PPLE_NUM_INF());
			psmt.setString(9, dto.getR_PPLE_SEAT());
			psmt.setInt(10, dto.getR_TOTAL_PLACE());
			System.out.println("3/5 S AirReserve");
			psmt.executeQuery();
			b = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("4/5 S AirReserve");
		}
		return b;
	}
	
	/**
	 * 항공권 좌석 계산
	 */
	@Override
	public AirTotalInfoDTO seatPrice(AirPlainDTO airinfoListdto, AirProductDTO airpdtdto, String lev, int seatCount) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		// 상품리스트
		AirTotalInfoDTO airtotalInfodto = null;
		// seatLevel : 1(일반), 2(비즈니스), 3(일등)
		String SeatLevel = "";
		if(lev.equals("일반석")){
			SeatLevel = "INFO.A_SEAT_ONE";
		}else if(lev.equals("비즈니스석")){
			SeatLevel = "INFO.A_SEAT_TWO";
		}else if(lev.equals("일등석")){
			SeatLevel = "INFO.A_SEAT_THREE";
		}
		String A_TIME_S = "'%"+airinfoListdto.getA_time_s()+"%'";
		String A_TIME_E = "'%"+airinfoListdto.getA_time_e()+"%'";
		
		System.out.println("airinfoListdto.getA_location_s() : " + airinfoListdto.getA_location_s());
		System.out.println("airinfoListdto.getA_location_e() : " + airinfoListdto.getA_location_e());
		System.out.println("뭐야?");
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S seatPrice() ");
			
			String sql = "SELECT PACK.P_NUM, PACK.P_PRICE, PACK.P_NAME, INFO.A_NUM, INFO.A_NAME, INFO.A_SEAT_ONE, INFO.A_SEAT_TWO, "
					+ "	INFO.A_SEAT_THREE, INFO.A_TIME_S, INFO.A_TIME_E, INFO.A_PRICE , PACK.P_PRICE + INFO.A_PRICE AS TOTALPRICE "
			        + "FROM AIR_PACKAGE PACK, AIR_INFO INFO "
			        + "WHERE PACK.P_COUNTRY = INFO.A_LOCATION_E "
			        + " AND INFO.A_TIME_S like " + A_TIME_S.trim()
			        + " AND INFO.A_TIME_E like " + A_TIME_E.trim()
			        + " AND " + SeatLevel +" >= ? "
	        		+ "AND INFO.A_NUM = ? "
	        		+ "AND PACK.P_NAME = ?";
			
			System.out.println("SQL : " + sql);
			System.out.println("seatCount : " + seatCount);
			System.out.println("airinfoListdto.getA_num() : " + airinfoListdto.getA_num());
			System.out.println("airpdtdto.getP_NAME() : " + airpdtdto.getP_NAME());
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seatCount);
			psmt.setInt(2, airinfoListdto.getA_num());
			psmt.setString(3, airpdtdto.getP_NAME());
			
			rs = psmt.executeQuery();
			
			
			while(rs.next()){
				airtotalInfodto = new AirTotalInfoDTO(rs.getInt(1), 
													  rs.getInt(2), 
													  rs.getString(3),
													  rs.getInt(4), 
													  rs.getString(5), 
													  rs.getInt(6), 
													  rs.getInt(7), 
													  rs.getInt(8), 
													  rs.getLong(9), 
													  rs.getLong(10), 
													  rs.getLong(11),
													  rs.getInt(12));
				
				System.out.println("★ : " + airtotalInfodto.toString());
				System.out.println("3/6 S seatPrice() ");
			}
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("4/6 S seatPrice() ");
		}
		return airtotalInfodto;
	}
}



























