package bbs_QNA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bbs.BbsDto_notice;
import paging.PagingBean;
import paging.PagingUtil;
import bbs_CS.BbsDto_cs;
import jdbc.DBConn;

public class BbsDao_QNA implements iBbsDao_QNA {
	
   public BbsDao_QNA() {
}
	private static BbsDao_QNA bbsDao = null;
	
	public static BbsDao_QNA getInstance(){
		if(bbsDao == null){
			bbsDao = new BbsDao_QNA();
		}
		return bbsDao;
	}
	
	private boolean isS=true;
	public void log(String msg){
		if(isS){
			System.out.println(getClass() + " : " + msg);
		}
	}
	public void log(String msg, Exception e) {
		if(isS){ 
			System.out.println(msg +" : " + getClass() +"  e : " + e); 
		}
	}
	
	@Override
	public boolean q_write(BbsDto_QNA dto) {
		
		String sql =" insert into  BBS_QNA "
				+ " ( SEQ, ID, TITLE, CONTENT, READCOUNT, QGROUP ) "
				+ " values(SEQ_QNA.NEXTVAL, ?, ?, ?, 0,?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S notice_write");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setInt(4, dto.getQgroup());
			
			count = psmt.executeUpdate();
			log("4/6 S notice_write");
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			log("F notice_write", e);
		} finally {
			DBConn.close(psmt, conn);
			log("5/6 S notice_write");
		}
		return count>0?true:false ;
	}
	@Override
	public List<BbsDto_QNA> getlist(String choice, String findNum) {
		String sWord = "%" + findNum.trim() + "%";
	    System.out.println(sWord);
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, READCOUNT, QGROUP "
				+ " FROM BBS_QNA "
				+ " WHERE QGROUP= ? " 
				+ " order by seq desc ";
		
		System.out.println(sql);
		int choice1 = Integer.parseInt(choice);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_QNA> list = new ArrayList<BbsDto_QNA>();
		
		try {
			
			conn = DBConn.getConnection();
			log("2/6 S getlist");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, choice1);
			log("3/6 S getlist");
			
			rs = psmt.executeQuery();
			log("4/6 S getlist");
			
			while(rs.next()){
				BbsDto_QNA dto = new BbsDto_QNA(
						rs.getInt(1), //seq
						rs.getString(2), //id
						rs.getString(3), //title
						rs.getString(4), //content
						rs.getInt(5), //readcount
						rs.getInt(6) 
						
				);
			    list.add(dto);
			   
			}
			log("5/6 S getlist");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F getlist", e);
			
		} finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S getlist");
		}
		return list;
	}
	@Override
	public BbsDto_QNA q_detail(int seq) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, READCOUNT, QGROUP"
				+ " FROM BBS_QNA" 
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_QNA detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S q_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S q_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S q_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_QNA(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getInt(6));
			}
			log("5/6 S q_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F q_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S q_detail");
		}
		
		return detaildto;
	}
	
	@Override
	public boolean q_update(int seq, String title, String content, int qgroup) {
		
		String sql=" UPDATE BBS_QNA "
				+ " SET TITLE=?, CONTENT=?, QGROUP=? "
				+ " WHERE SEQ=? " ;
		
		Connection conn = null;
	    PreparedStatement psmt= null;
		int count = 0;		
	    try {
			conn = DBConn.getConnection();
			log("2/6 S q_update");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, qgroup);
			psmt.setInt(4, seq);
			log("3/6 S q_update");
			
			count = psmt.executeUpdate(); 
			log("4/6 S q_update");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notice_update", e);
		}finally {
			DBConn.close(psmt, conn);
			log("5/6 S notice_update");
		}
		return count>0?true:false;
	}
	
	@Override
	public boolean q_del(int seq) {
		
		String sql = "DELETE FROM BBS_QNA "
	    		+ " WHERE SEQ=? ";
	    		
	    Connection conn = null;
	    PreparedStatement psmt = null;		
	    
	    int count = 0;
	    
	    try {
			conn = DBConn.getConnection();
			log("2/6 S q_del");
			 
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S q_del");
			
			count = psmt.executeUpdate();
			log("4/6 S q_del");
			
			 
		} catch (SQLException e) {
			e.printStackTrace();
			log("4/6 S q_del", e);
		} finally {
			DBConn.close(psmt, conn);
			log("4/6 S notice_del");
		}
	    return count>0?true:false;
	}
	
	@Override
	public List<BbsDto_QNA> p_PagingList(PagingBean paging, String searchWord, String qgroup) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_QNA> bbslist = new ArrayList<>(); //10개씩 짤라서 리스트 리턴
		String sWord = "%" + searchWord.trim() + "%";
		int qgroup1 = Integer.parseInt(qgroup);
		try {
			conn = DBConn.getConnection(); 
			//autocommit(false)해줘야함.. 사실 ㅎㅎ 
			log("1/6 S getBbsPagingList");
			
			String totalSql = " SELECT COUNT(SEQ) FROM BBS_QNA WHERE TITLE LIKE '" + sWord + "' "
					+ " AND QGROUP= ? "; //글이 총 몇개 있는지 알아봄 --> totalcount 세팅 하기 위해 

			psmt = conn.prepareStatement(totalSql);
			psmt.setInt(1, qgroup1);
			
			rs = psmt.executeQuery(); 
			
			int totalCount = 0;
			rs.next();   //1개 값 얻어올때 while 사용 x 
			totalCount = rs.getInt(1);  //row의 총 갯수 
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPasingInfo(paging);
			
			psmt.close();
			rs.close();
			
			
			// ROWNUM : DB에서 Slice 
			String sql = " SELECT * FROM"
					+ " (SELECT * FROM (SELECT * FROM BBS_QNA WHERE TITLE LIKE '" + sWord +"' "
							+ " AND QGROUP=?  ORDER BY SEQ )"
					+ " WHERE ROWNUM <=" + paging.getStartNum() +" ORDER BY seq DESC) "
					+ " WHERE ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("paging.getStartNum():" + paging.getStartNum());
			System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, qgroup1);
			log("2/6 S getBbsPagingList");
			
			rs = psmt.executeQuery();
			log("3/6 S getBbsPagingList");
			
			while(rs.next()){
				BbsDto_QNA dto = new BbsDto_QNA(
						rs.getInt(1), //seq
						rs.getString(2), //id
						rs.getString(3), //title
						rs.getString(4), //content
						rs.getInt(5), //readcount
						rs.getInt(6) );
				bbslist.add(dto);
			}
			log("4/6 S getBbsPagingList");
		
		} catch (SQLException e) {
			log("F getBbsPagingList", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("5/6 S getBbsPagingList");
		}
		
		return bbslist;
	}
	
	
	@Override
	public BbsDto_QNA q_next_detail(int seq) {
		
		String sql = " select * from BBS_QNA "
				+ " where seq = (select max(seq) from BBS_QNA where seq<? ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_QNA detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S q_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S q_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S q_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_QNA(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getInt(6));
			}
			log("5/6 S q_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F q_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S q_detail");
		}
		
		return detaildto;
	}
	
	@Override
	public BbsDto_QNA q_pre_detail(int seq) {
		
		String sql = " select * from BBS_QNA "
				+ " where seq = (select min(seq) from BBS_QNA where seq>? ) ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_QNA detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S q_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S q_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S q_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_QNA(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getInt(6));
			}
			log("5/6 S q_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F q_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S q_detail");
		}
		
		return detaildto;
	}
	
	
	
	
	
	

}
