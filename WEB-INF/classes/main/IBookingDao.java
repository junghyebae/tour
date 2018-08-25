package main;

import java.util.List;

public interface IBookingDao {
	
	public List<BookingDto> airList(String sdate, String edate);
	
	// 날짜 차이 구하는 함수
	public String doDiffOfDate(String sdate, String edate);
	
	// a_num을 구하기 위한 Method
	public BookingDto reserveAnumList(String sLo, String eLo, String sTi, String eTi);
	
	// 예약 Method
	public boolean mainBooking(String R_ID, int R_INFO_NUM, String R_PACK_NAME, String R_ST_DATE, String R_EN_DATE, 
			     int R_PPLE_NUM_ADT, int R_PPLE_NUM_CHI, int R_PPLE_NUM_INF, String R_PPLE_SEAT, int R_TOTAL_PLACE);
	
	
	// 비행기 가격을 가져오는 Method
	public BookingDto getAirPrice(String time_s, String time_e, String sLocation, String eLocation);
	
	// 비행기 좌석수 감소 Method
	public void decrementSeat(int seats, String type, int a_num);
	
	// 상품 선택 시 조회수 증가 Method
	public boolean readcountIncrement(String p_name);
	
	// Calendar에 뿌려줄 List 호출 Method
	public List<BookingDto> getAirList();
	
}
