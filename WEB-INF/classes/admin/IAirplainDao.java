package admin;

import java.util.List;

import paging.PagingBean;

public interface IAirplainDao {

	//비행기 정보 추가
	public boolean addAirplain(AirplainDto dto);
	
	public List<AirplainDto> airplainList(PagingBean paging);
	
	//검색
	public List<AirplainDto> searchAirplainList(
			String type,String test,PagingBean pagin);
	
	//삭제
	public boolean removeAirplain(int a_num);
	
	//비행기 디테일 정보
	public AirplainDto airplainDetail(int a_num);
	
	//예약취소시, 좌석수 증가
	public boolean cancelSeat(int seats,int type,int a_num);
}
