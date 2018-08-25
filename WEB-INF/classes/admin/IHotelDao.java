package admin;

import java.util.List;

import paging.PagingBean;

public interface IHotelDao {
	public boolean addHotel(HotelDto dto);
	
	public List<HotelDto> hotelList(PagingBean paging);
	
	public boolean removeHotel(int h_num);
	
	public HotelDto getHotel(int h_num);
}
