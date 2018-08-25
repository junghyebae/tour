package paging;

//페이지 계산해줄 부분
public class PagingUtil {
	public static PagingBean setPasingInfo(PagingBean paging){
		//setter를 이용해서 값을 넣기
		paging.setCountPerPage(10);
		paging.setBlockCount(10);
		
		paging.setStartNum(paging.getTotalCount()-
				(paging.getNowPage()-1)*paging.getCountPerPage());
		/*
		 * 올린 글의 총 갯수 : 12개 
		 * 1페이지일경우 : (getTotalCount)-0*10 = 12
		 * 21 1*10 11
		 * 
		 * 2페이지일경우 : 12 - (2-1)*10 = 2
		 * 
		 * 
		 */
		System.out.println(paging.getTotalCount()-
				(paging.getNowPage()-1)*paging.getCountPerPage());
		System.out.println("paging.getCountPerPage() = "+ paging.getCountPerPage());
		System.out.println(paging.getCountPerPage());
		System.out.println(paging.getNowPage());
		System.out.println(paging.getTotalCount());
		
		return paging;
		
	}
}
