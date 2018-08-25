package bbs_QNA;

import java.util.List;

import paging.PagingBean;


public interface iBbsDao_QNA {
	
	public boolean q_write(BbsDto_QNA dto) ;
	public List<BbsDto_QNA> getlist(String choice, String findNum);
	public BbsDto_QNA q_detail(int seq);
	public BbsDto_QNA q_next_detail(int seq);
	public BbsDto_QNA q_pre_detail(int seq);
	public boolean q_update(int seq, String title, String content, int qgroup);
	public boolean q_del(int seq);
	public List<BbsDto_QNA> p_PagingList(PagingBean paging, String searchWord, String choice);
}
