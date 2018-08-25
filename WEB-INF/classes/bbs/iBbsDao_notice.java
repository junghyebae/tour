package bbs;

import java.util.List;

import paging.PagingBean;

public interface iBbsDao_notice {
	
	public boolean notice_write(BbsDto_notice dto);
	public List<BbsDto_notice> notice_list();
	public BbsDto_notice notice_detail(int seq);
	public BbsDto_notice notice_pre_detail(int seq);
	public BbsDto_notice notice_next_detail(int seq);
	public void notice_readcount(int seq);
	public boolean notice_update(int seq, String title, String content);
	public boolean notice_del(int seq);
	
	public List<BbsDto_notice> getBbsPagingList(PagingBean paging, String search) ;
	
}
