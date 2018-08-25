package hotelRes;

import java.util.List;

public interface IhotelResDao {

	// 예약추가
//	public boolean addHotelRes(hotelResDto dto);
	
	// 비회원 예약추가 하면서 예약번호 보여주기
	public int addHotelRes(hotelResDto dto);
	
	// 회원 예약목록
	public List<hotelResDto> getHotelList(String id);
	
	// 비회원 예약목록
	public List<hotelResDto> getHotelList2(int resNum, String email);
	
	// 예약취소
	public boolean cancelHotel(int seq);
	
}
