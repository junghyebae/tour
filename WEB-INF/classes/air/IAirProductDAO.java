package air;

import java.util.List;


public interface IAirProductDAO {
	
	// 항공권 리스트 뿌려주기
	public List<AirProductDTO> AirProudctList();
	
	// 디테일 화면 보여주기
	public AirTotalInfoDTO AirProductDetail(int seq);

	// 페이징 처리
	public List<AirProductDTO> getAirProductPagingList(PagingBean paging, String searchWord);
	
	// 항공권 리스트 상세검색하기
	public List<AirProductDTO> getSearchProductList(AirPlainDTO airinfoListdto, int seatLevel, PagingBean paging);
	
	// 항공권 리스트 간단검색
	public List<AirProductDTO> getSearchList(AirProductDTO dto);
	
}
