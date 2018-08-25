package admin;


import java.util.List;

import paging.PagingBean;

public interface IReserveDao {

	//리스트불러오기
	public List<ReserveDto> reserveList(PagingBean paging);
	
	//예약 디테일
	public ReserveDto getreserve(int r_num);
	
	//상태 업데이트
	public boolean updateState(ReserveDto dto,int state);
	
	//데이터 삭제
	public boolean deleteReserve(int r_num);
	
	
}
