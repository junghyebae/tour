package bbs_CS;

import java.util.List;

import bbs.BbsDto_notice;
import paging.PagingBean;

public interface iBbsDao_cs {
	public boolean cs_write(BbsDto_cs dto);
	public void cs_readcount(int seq);
	public boolean cs_update(int seq, String title, String content, int secret, String category);
	public boolean cs_del(int seq);
	
	public List<BbsDto_cs> getlist(String id);
	public BbsDto_cs cs_detail(int seq);
	public boolean cs_answer(int seq, BbsDto_cs dto);
	
	public List<BbsDto_cs> cs_PagingList(PagingBean paging, String searchWord, String category);
	
	// 내문의내역
	public List<BbsDto_cs> getMylist(PagingBean paging, String id);

}
