package airRes;

import java.util.List;

public interface iairResDao {
	
	//아이디 별 예약 리스트 뿌리기 
	List<airResDto> getAirResList(String id);
	
	// 예약정보 가져오기
	public airResDto getAirRes(int seq);
	
	// 예약취소하기
	public boolean cancelARes(int seq);
	
	// 좌석수 늘려주기
	public boolean addAirSeat(int seq, int num, String seat);

}
