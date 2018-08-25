package air;

import java.util.List;


public interface IAirPlainDAO {
	
	// 비행기 리스트
	public List<AirPlainDTO> getAirplainList();
	
	// 출발 & 도착 리스트
	public List<AirPlainDTO> getAirplainCntList();
	
	// anum을 통한 비행기정보 호출 Method
	public AirPlainDTO getAdto(int a_num);
}
