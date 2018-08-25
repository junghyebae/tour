package air;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import air.PagingUtil;
import jdbc.DBConn;

public class AirProudctDAO implements IAirProductDAO {
	
	private static AirProudctDAO airproductdao = null;
	
	private AirProudctDAO() {
		DBConn.initConnect();
	}
	
	public static AirProudctDAO getInstance() {
		
		if(airproductdao == null){
			airproductdao = new AirProudctDAO();
		}
		return airproductdao;
	}

	/**
	 * 예약 리스트 보여주기(기본)
	 */
	@Override
	public List<AirProductDTO> AirProudctList() {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<AirProductDTO> list = new ArrayList<>();
		AirProductDTO airProductdto = null;
		
		String sql = "SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, P_COUNTRY, P_READCOUNT, P_BUYCOUNT "
				+ "FROM AIR_PACKAGE";
		System.out.println("sql : " + sql);
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 AirProudctList Success!");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/6 AirProudctList Success!");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 AirProudctList Success!");
			while(rs.next()){
				airProductdto = new AirProductDTO(rs.getInt(1),
												  rs.getString(2), 
												  rs.getInt(3), 
												  rs.getString(4), 
												  rs.getString(5), 
												  rs.getString(6), 
												  rs.getInt(7), 
												  rs.getInt(8)
												  );
				System.out.println("rs.getInt(8) : " + rs.getInt(8));
				list.add(airProductdto);
				System.out.println("5/6 AirProudctList Success!");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 AirProudctList Success!");
		}
		return list;
	}
	
	/**
	 * 상품 디테일화면
	 */
	@Override
	public AirTotalInfoDTO AirProductDetail(int seq) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
//		AirProductDTO airProductdto = null;
		AirTotalInfoDTO airtotalinfodto = null;
		
		/*String sql = "SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, P_COUNTRY, P_READCOUNT, P_BUYCOUNT "
				+ "FROM AIR_PACKAGE "
				+ "WHERE P_NUM = ?";*/
		
		String sql = "SELECT "
				+ "PACK.P_NUM, "
				+ "PACK.P_PRICE, "
				+ "PACK.P_NAME, "
				+ "INFO.A_NUM, "
				+ "INFO.A_NAME, "
				+ "INFO.A_SEAT_ONE, "
				+ "INFO.A_SEAT_TWO, "
				+ "INFO.A_SEAT_THREE, "
				+ "INFO.A_TIME_S, "
				+ "INFO.A_TIME_E, "
				+ "INFO.A_PRICE "
				+ "FROM AIR_PACKAGE PACK, AIR_INFO INFO "
				+ "WHERE PACK.P_COUNTRY = INFO.A_LOCATION_E "
				+ "AND PACK.P_NUM = ?";
		System.out.println("sql : " + sql);
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S AirProductDetail");
			psmt = conn.prepareStatement(sql);
			System.out.println("seq : " + seq);
			psmt.setInt(1, seq);
			System.out.println("3/6 S AirProductDetail");
			
			rs = psmt.executeQuery();
			while(rs.next()){
				airtotalinfodto = new AirTotalInfoDTO(rs.getInt(1), 
													  rs.getInt(2), 
													  rs.getString(3), 
													  rs.getInt(4), 
													  rs.getString(5), 
													  rs.getInt(6), 
													  rs.getInt(7), 
													  rs.getInt(8), 
													  rs.getLong(9), 
													  rs.getLong(10), 
													  rs.getLong(11));
				System.out.println("이것이 무엇이냐 " + airtotalinfodto.toString());
				System.out.println("4/6 S AirProductDetail");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("5/6 S AirProductDetail");
		}
		return airtotalinfodto;
	}

	/**
	 * 페이징처리
	 */
	@Override
	public List<AirProductDTO> getAirProductPagingList(PagingBean paging, String searchWord) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		AirProductDTO airProductdto = null;
		
		List<AirProductDTO> airProudctlist = new ArrayList<>();
		
		// 검색어
		String sWord = "%" + searchWord.trim() + "%";
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S getBbsPagingList");
			// SELECT COUNT(P_NUM) FROM AIR_PACKAGE WHERE P_CONTENT LIKE '%밍%';
			String totalSql = " SELECT COUNT(P_NUM) FROM AIR_PACKAGE WHERE P_CONTENT LIKE '" + sWord + "'";
			psmt = conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1);	// row의 총 갯수
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPagingInfo(paging);
			psmt.close();
			rs.close();			
			String sql = "SELECT * FROM (SELECT * FROM (SELECT * FROM AIR_PACKAGE WHERE P_CONTENT LIKE '" 
						+ sWord 
						+ "' ORDER BY P_NUM) "
						+ " WHERE ROWNUM <=" + paging.getStartNum() + " ORDER BY P_NUM DESC) "
						+ " WHERE ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("paging.getStartNum():" + paging.getStartNum());
			System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 S getBbsPagingList");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 S getBbsPagingList");
			
			while(rs.next()){
				airProductdto = new AirProductDTO(rs.getInt(1),
												  rs.getString(2), 
												  rs.getInt(3), 
												  rs.getString(4), 
												  rs.getString(5), 
												  rs.getString(6), 
												  rs.getInt(7), 
												  rs.getInt(8)
												  );
				System.out.println("4/6 S AirProductDetail");
				airProudctlist.add(airProductdto);
			}
			System.out.println("4/6 S getBbsPagingList");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("5/6 S getBbsPagingList");
		}		
		
		return airProudctlist;
	}
	
	/**
	 * 항공권 리스트 상세검색하기
	 */
	@Override
	public List<AirProductDTO> getSearchProductList(AirPlainDTO airinfoListdto, int seatLevel, PagingBean paging) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		// 상품리스트
		AirProductDTO airtotalInfodto = null;
		// 비행기정보리스트
		List<AirProductDTO> pro_list = new ArrayList<>();
		
		System.out.println("airinfoListdto.getA_location_s() : " + airinfoListdto.getA_location_s());
		System.out.println("airinfoListdto.getA_location_e() : " + airinfoListdto.getA_location_e());
		System.out.println("airinfoListdto.getA_seat_one()   : " + seatLevel);
		
		// seatLevel : 1(일반), 2(비즈니스), 3(일등)
		String SeatLevel = "";
		if(seatLevel == 1){
			SeatLevel = "INFO.A_SEAT_ONE";
		}else if(seatLevel == 2){
			SeatLevel = "INFO.A_SEAT_TWO";
		}else if(seatLevel == 3){
			SeatLevel = "INFO.A_SEAT_THREE";
		}
		String A_TIME_S = "'%"+airinfoListdto.getA_time_s()+"%'";
		String A_TIME_E = "'%"+airinfoListdto.getA_time_e()+"%'";
		
		String totalSql = "SELECT COUNT (PACK.P_NUM) "
				+ "FROM AIR_PACKAGE PACK, AIR_INFO INFO "
				+ "WHERE PACK.P_COUNTRY = INFO.A_LOCATION_E "
				+ "AND INFO.A_LOCATION_S = ? "
				+ "AND INFO.A_LOCATION_E = ? "
				+ "AND INFO.A_TIME_S like " + A_TIME_S.trim()
				+ " AND INFO.A_TIME_E like " + A_TIME_E.trim()
				+ " AND " + SeatLevel +" >= ? ";
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getSearchProductList() ");
			
			psmt = conn.prepareStatement(totalSql);
			psmt.setString(1, airinfoListdto.getA_location_s());
			psmt.setString(2, airinfoListdto.getA_location_e());
			psmt.setInt(3, airinfoListdto.getA_seat_one());
			rs = psmt.executeQuery();
			System.out.println("3/6 S getSearchProductList() ");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1);	// row의 총 갯수
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPagingInfo(paging);
			
			psmt.close();
			rs.close();	
			
			String sql = "SELECT * FROM (SELECT PACK.P_NUM, PACK.P_NAME, PACK.P_PRICE, PACK.P_SCHEDULE, PACK.P_CONTENT, PACK.P_COUNTRY, PACK.P_READCOUNT, PACK.P_BUYCOUNT "
								         + "FROM AIR_PACKAGE PACK, AIR_INFO INFO "
								        + "WHERE PACK.P_COUNTRY = INFO.A_LOCATION_E "
							        	  + "AND INFO.A_LOCATION_S = ? "
								          + "AND INFO.A_LOCATION_E = ? "
								          + "AND INFO.A_TIME_S like " + A_TIME_S.trim()
								         + " AND INFO.A_TIME_E like " + A_TIME_E.trim()
								         + " AND " + SeatLevel +" >= ?) "
								+ "WHERE ROWNUM <=" + paging.getStartNum() 
								+ " AND ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("sql : " + sql);
			System.out.println("4/6 S getSearchProductList() ");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, airinfoListdto.getA_location_s());
			psmt.setString(2, airinfoListdto.getA_location_e());
			psmt.setInt(3, airinfoListdto.getA_seat_one());
			System.out.println("5/6 S getSearchProductList() ");
			
			rs = psmt.executeQuery();
			System.out.println("6/6 S getSearchProductList() ");
			
			while(rs.next()){
				airtotalInfodto = new AirProductDTO(rs.getInt(1),
												  rs.getString(2), 
												  rs.getInt(3), 
												  rs.getString(4), 
												  rs.getString(5), 
												  rs.getString(6), 
												  rs.getInt(7), 
												  rs.getInt(8)
												  );
							pro_list.add(airtotalInfodto);
				pro_list.add(airtotalInfodto);
				System.out.println("7/6 S getSearchProductList()");				
			}		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
		return pro_list;
	}
	
	
	/** 
	 * 항공권 리스트 간단검색
	 */
	@Override
	public List<AirProductDTO> getSearchList(AirProductDTO dto) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		AirProductDTO airProductdto = null;
		List<AirProductDTO> pro_list = new ArrayList<>();
		
		String sql = "SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, P_COUNTRY, P_READCOUNT, P_BUYCOUNT "
				+ "FROM AIR_PACKAGE "
				+ "WHERE P_NAME LIKE '?'";
		System.out.println("sql : " + sql);
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getSearchList()");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getP_NAME());
			System.out.println("3/6 S getSearchList()");
			
			while(rs.next()){
				airProductdto = new AirProductDTO(rs.getInt(1),
												  rs.getString(2), 
												  rs.getInt(3), 
												  rs.getString(4), 
												  rs.getString(5), 
												  rs.getString(6), 
												  rs.getInt(7), 
												  rs.getInt(8)
												  );
				pro_list.add(airProductdto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
		return pro_list;
	}
	
	
	
	
	
}













