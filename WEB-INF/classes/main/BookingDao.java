package main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import jdbc.DBConn;

public class BookingDao implements IBookingDao {

	private static BookingDao bookingdao = null;
	
	public BookingDao() {
		DBConn.initConnect();
	}
	
	public static BookingDao getInstance() {
		if(bookingdao == null){
			bookingdao = new BookingDao();
		}
		return bookingdao;
	}
	
	// 이상 형태를 판별하는 변수
		private boolean isS = true;
	
	// Log Method
		public void log(String msg) {
			if(isS) {
				// msg가 들어오면 클래스명과 같이 출력
				System.out.println(getClass() + ": " + msg);
			}
		}
		
	// Exception Log Method
		public void log(String msg, Exception e) {
			if(isS) {
				// msg와 e가 들어오면 익셉션과 같이 출력
				System.out.println(e + ": " + getClass() + ": " + msg);
			}
		}
	
	// TODO 날짜 차이 구하는 함수
		public String doDiffOfDate(String sdate, String edate){

			String result = "";
			
		    try {
		        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		        Date beginDate = formatter.parse(sdate);
		        Date endDate = formatter.parse(edate);
		         
		        // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
		        long diff = endDate.getTime() - beginDate.getTime();
		        long diffDays = diff / (24 * 60 * 60 * 1000);		 
		        	System.out.println("날짜차이=" + diffDays);
		        
		        result = String.valueOf(diffDays);		        
		        	System.out.println("result:" + result);
		         
		    } catch (ParseException | java.text.ParseException e) {
		        // e.printStackTrace();
		    }
		    
		    return result;
		}
	
		
	// TODO airList Method
	@Override
	public List<BookingDto> airList(String sdate, String edate) {
		
		/*
			private int a_num; //비행기번호
			private String a_name; //비행기이름
			private int a_seat_one; //좌석1
			private int a_seat_two; //좌석2
			private int a_seat_three; //좌석3
			private String a_location_s; //출발지
			private String a_location_e; //도착지
			private long a_time_s; //출발시간
			private long a_time_e; //도착시간
			private int a_price; //가격
		 */
		
		List<BookingDto> list = new ArrayList<BookingDto>();
		
		System.out.println("airList의 sdate: " + sdate);
		System.out.println("airList의 edate: " + edate);
		
		if(sdate.equals("") || edate.equals("")) {
			list = new ArrayList<BookingDto>();
		}else {
			String sql = " SELECT A_NUM, A_NAME, A_SEAT_ONE, A_SEAT_TWO, A_SEAT_THREE, "
					+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE "
					+ " FROM AIR_INFO "
					+ " WHERE A_TIME_S LIKE ('" + sdate + "%') AND A_TIME_E LIKE ('" + edate + "%') ";
			
			System.out.println("sql: " + sql);
			
			// WHERE A_TIME_S LIKE ('20170922%') AND A_TIME_E LIKE ('20171003%');
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			log("1/6 S airList");
			
			try {
				conn = DBConn.getConnection();
				log("2/6 S airList");
				
				psmt = conn.prepareStatement(sql);
				log("3/6 S airList");
				
				rs = psmt.executeQuery();
				log("4/6 S airList");			
				
				while(rs.next()) {
					int i = 1;
					BookingDto dto = new BookingDto(
							//a_num
							rs.getInt(i++), 
							//a_name
							rs.getString(i++), 
							//a_seat_one
							rs.getInt(i++), 
							//a_seat_two
							rs.getInt(i++), 
							//a_seat_three
							rs.getInt(i++), 
							//a_location_s
							rs.getString(i++),
							//a_location_e
							rs.getString(i++),
							//a_time_s
							rs.getString(i++), 
							//a_time_e
							rs.getString(i++),
							//a_price
							rs.getInt(i++)
							);						
					list.add(dto);
				}
				log("5/6 S airList");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(rs, psmt, conn);
				log("6/6 S airList");
			}		
		}
		return list;
	}
	
	// TODO reserveAnumList Method (예약당시 A_NUM을 구하기 위한 Method)
		@Override
		public BookingDto reserveAnumList(String sLo, String eLo, String sTi, String eTi) {
			
			String sql = " SELECT A_NUM, A_NAME, A_SEAT_ONE, A_SEAT_TWO, A_SEAT_THREE, "
					+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE "
					+ " FROM AIR_INFO "
					+ " WHERE A_LOCATION_S = ? AND A_LOCATION_E = ? AND A_TIME_S = ? AND A_TIME_E = ? ";
			
			System.out.println("sql: " + sql);
			
			// WHERE A_TIME_S LIKE ('20170922%') AND A_TIME_E LIKE ('20171003%');
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			BookingDto dto = null;
			
			log("1/6 S reserveAnumList");
			
			try {
				conn = DBConn.getConnection();
				log("2/6 S reserveAnumList");
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, sLo);
				psmt.setString(2, eLo);
				psmt.setString(3, sTi);
				psmt.setString(4, eTi);
				log("3/6 S reserveAnumList");
				
				rs = psmt.executeQuery();
				log("4/6 S reserveAnumList");			
				
				while(rs.next()) {
					int i = 1;
					dto = new BookingDto(
							//a_num
							rs.getInt(i++), 
							//a_name
							rs.getString(i++), 
							//a_seat_one
							rs.getInt(i++), 
							//a_seat_two
							rs.getInt(i++), 
							//a_seat_three
							rs.getInt(i++), 
							//a_location_s
							rs.getString(i++),
							//a_location_e
							rs.getString(i++),
							//a_time_s
							rs.getString(i++), 
							//a_time_e
							rs.getString(i++),
							//a_price
							rs.getInt(i++)
							);						
				}
				log("5/6 S reserveAnumList");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(rs, psmt, conn);
				log("6/6 S reserveAnumList");
			}		
			
			return dto;
		}
		
		
	// TODO mainBooking Method(메인 화면의 예약 정보가 들어가는 메소드)
		@Override
		public boolean mainBooking(String R_ID, int R_INFO_NUM, String R_PACK_NAME, String R_ST_DATE, String R_EN_DATE,
				int R_PPLE_NUM_ADT, int R_PPLE_NUM_CHI, int R_PPLE_NUM_INF, String R_PPLE_SEAT, int R_TOTAL_PLACE) {
			
			String sql = " INSERT INTO AIR_RESERVE(R_NUM, R_ID, R_INFO_NUM, R_PACK_NAME, R_ST_DATE, R_EN_DATE, R_PPLE_NUM_ADT, "
					   + " R_PPLE_NUM_CHI, R_PPLE_NUM_INF, R_PPLE_SEAT, R_TOTAL_PLACE, R_RDATE, R_STATE) "
					   + " VALUES(SEQ_R_NUM.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, 1) ";
			
			System.out.println("sql: " + sql);
			System.out.println("R_PPLE_SEAT: " + R_PPLE_SEAT);
			
			int count = 0;
			Connection conn = null;
			PreparedStatement psmt = null;
			
			try {
				conn = DBConn.getConnection();
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, R_ID);
				psmt.setInt(2, R_INFO_NUM);
				psmt.setString(3, R_PACK_NAME);
				psmt.setString(4, R_ST_DATE);
				psmt.setString(5, R_EN_DATE);
				psmt.setInt(6, R_PPLE_NUM_ADT);
				psmt.setInt(7, R_PPLE_NUM_CHI);
				psmt.setInt(8, R_PPLE_NUM_INF);
				psmt.setString(9, R_PPLE_SEAT);
				psmt.setInt(10, R_TOTAL_PLACE);
				
				count = psmt.executeUpdate();				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(psmt, conn);
			}
			return count>0?true:false;
		}

		
	// TODO getAirPrice Method(비행기 가격을 얻어오는 부분)
		@Override
		public BookingDto getAirPrice(String time_s, String time_e, String sLocation, String eLocation) {
			
			String sql = " SELECT A_NUM, A_NAME, A_SEAT_ONE, A_SEAT_TWO, A_SEAT_THREE, "
					+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE "
					+ " FROM AIR_INFO "
					+ " WHERE A_TIME_S LIKE ('" + time_s + "%') AND A_TIME_E LIKE ('" + time_e + "%') "
					+ " AND A_LOCATION_S = ? AND A_LOCATION_E = ? ";
			
			System.out.println("sql: " + sql);
			
			// WHERE A_TIME_S LIKE ('20170922%') AND A_TIME_E LIKE ('20171003%');
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			BookingDto dto = null;
			
			try {
				conn = DBConn.getConnection();
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, sLocation);
				psmt.setString(2, eLocation);
				
				rs = psmt.executeQuery();
				
				while(rs.next()) {
					int i = 1;
					dto = new BookingDto(
							//a_num
							rs.getInt(i++), 
							//a_name
							rs.getString(i++), 
							//a_seat_one
							rs.getInt(i++), 
							//a_seat_two
							rs.getInt(i++), 
							//a_seat_three
							rs.getInt(i++), 
							//a_location_s
							rs.getString(i++),
							//a_location_e
							rs.getString(i++),
							//a_time_s
							rs.getString(i++), 
							//a_time_e
							rs.getString(i++),
							//a_price
							rs.getInt(i++)
							);						
				}
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(rs, psmt, conn);
			}			
			return dto; 
		}
		
		// TODO Auto-generated method stub
		@Override
		public void decrementSeat(int seats, String type, int a_num) {
			 
			  String sql="";
		      
		      //일등석
		      if(type.equals("일등석")){
		      sql = " UPDATE AIR_INFO SET A_SEAT_ONE = A_SEAT_ONE - " + seats
		            + " WHERE A_NUM= " + a_num;
		      }
		      //비즈니스석
		      if(type.equals("비즈니스석")){
		      sql = " UPDATE AIR_INFO SET A_SEAT_TWO = A_SEAT_TWO - " + seats
		            + " WHERE A_NUM= " + a_num;
		      }
		      //일반석
		      if(type.equals("일반석")){
		      sql = " UPDATE AIR_INFO SET A_SEAT_THREE = A_SEAT_THREE - " + seats
		            + " WHERE A_NUM=" + a_num;
		      }
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;

		      try {
		         conn = DBConn.getConnection();
		         System.out.println("2/6 S cancelSeat");
		         
		         psmt = conn.prepareStatement(sql);

		         System.out.println("3/6 S cancelSeat");
		         
		         psmt.executeUpdate();
		         System.out.println("4/6 S cancelSeat");
		         
		      } catch (SQLException e) {
		         e.printStackTrace();
		      } finally {
		         DBConn.close(psmt, conn);
		         System.out.println("5/6 S cancelSeat");
		      }      
		}

		
	// TODO readcountIncrement
		@Override
		public boolean readcountIncrement(String p_name) {
			String sql = " UPDATE AIR_PACKAGE SET P_READCOUNT = P_READCOUNT+1 "
		            + " WHERE P_NAME =? ";
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;
		      
		      int count = 0;
		      
		      try {
		         conn = DBConn.getConnection();
		         System.out.println("2/6 S addBuycount");
		         
		         psmt = conn.prepareStatement(sql);
		         psmt.setString(1, p_name);
		         System.out.println("3/6 S addBuycount");
		         
		         count = psmt.executeUpdate();
		         System.out.println("4/6 S addBuycount");
		         
		      } catch (SQLException e) {
		         e.printStackTrace();
		      } finally {
		         DBConn.close(psmt, conn);
		         System.out.println("5/6 S addBuycount");
		      }      
		      return count>0?true:false;
		}

		
		
	// TODO getAirList Method (Calendar에 뿌려줄 Air List Method)		
		@Override
		public List<BookingDto> getAirList() {
			
			List<BookingDto> list = new ArrayList<BookingDto>();

			String sql = " SELECT A_NUM, A_NAME, A_SEAT_ONE, A_SEAT_TWO, A_SEAT_THREE, "
					+ " A_LOCATION_S, A_LOCATION_E, A_TIME_S, A_TIME_E, A_PRICE "
					+ " FROM AIR_INFO ";
			
			System.out.println("sql: " + sql);

			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			log("1/6 S getAirList");
			
			try {
				conn = DBConn.getConnection();
				log("2/6 S getAirList");
				
				psmt = conn.prepareStatement(sql);
				log("3/6 S getAirList");
				
				rs = psmt.executeQuery();
				log("4/6 S getAirList");			
				
				while(rs.next()) {
					int i = 1;
					BookingDto dto = new BookingDto(
							//a_num
							rs.getInt(i++), 
							//a_name
							rs.getString(i++), 
							//a_seat_one
							rs.getInt(i++), 
							//a_seat_two
							rs.getInt(i++), 
							//a_seat_three
							rs.getInt(i++), 
							//a_location_s
							rs.getString(i++),
							//a_location_e
							rs.getString(i++),
							//a_time_s
							rs.getString(i++), 
							//a_time_e
							rs.getString(i++),
							//a_price
							rs.getInt(i++)
							);						
					list.add(dto);
				}
				log("5/6 S getAirList");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(rs, psmt, conn);
				log("6/6 S getAirList");
			}		
			return list;
		}

	
	
}
