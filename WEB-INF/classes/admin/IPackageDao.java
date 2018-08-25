package admin;

import java.util.List;

import paging.PagingBean;

public interface IPackageDao {

	//관리자 모드 (상품)
	public boolean addPackage(PackageDto dto);
	
	public List<PackageDto> packageList(PagingBean paging);
	
	public boolean removePackage(int p_num);
	
	//예약 부분 (패키지)
	public List<PackageDto> PackageList(String eLocation, String date);
	
	//패키지명으로 상세정보가져오기
	public PackageDto reservePackList(String p_name);
	
	//상품구매수 증가
	public boolean addBuycount(String p_name);

	//상품인기순위 리스트가져오기
	public List<PackageDto> rankList();
	
	//조회수 순위 리스트가져오기
	public List<PackageDto> rankreadCount();
	
	//좋아요 순위 리스트가져오기
	public List<PackageDto> likeRank();
	
	//p_num으로 상세정보가져오기
	public PackageDto getPackage(int p_num);
	
	//조회수 증가
	public boolean readcountIncrement(int p_num);
	
}
