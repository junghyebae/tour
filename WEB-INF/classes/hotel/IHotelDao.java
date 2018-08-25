package hotel;

import java.util.List;

public interface IHotelDao {

	// 호텔 검색 리스트
	public List<HotelDto> getHotelList(String location, String checkIn, String checkout);
	
	// 호텔 디테일
	public HotelDto getHotelDetail(int seq);
	
	// 예약되었을시 객실수 줄이기
	public boolean hotelReserved(int seq, int room);
	
	// 예약취소 되었을시 객실수 줄이기
	public boolean hotelCanceled(int seq, int room);
	
}
