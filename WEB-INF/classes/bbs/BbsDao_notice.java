package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;
import paging.PagingBean;
import paging.PagingUtil;

public class BbsDao_notice implements iBbsDao_notice{

	public BbsDao_notice() {
	}
	private static BbsDao_notice bbsDao = null;
	public static BbsDao_notice getInstance(){
		if(bbsDao == null){
			bbsDao = new BbsDao_notice();
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
	public boolean notice_write(BbsDto_notice dto) {
		
		String sql =" insert into BBS_NOTICE "
				+ " ( SEQ, ID, TITLE, CONTENT, READCOUNT, WDATE ) "
				+ " values(SEQ_NOTICE.NEXTVAL, ?, ?, ?, 0, SYSDATE) ";
		
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
	public List<BbsDto_notice> notice_list() {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, READCOUNT, WDATE "
				+ " FROM BBS_NOTICE" ;
		
		System.out.println(sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_notice> list = new ArrayList<BbsDto_notice>();
		
		try {
			
			conn = DBConn.getConnection();
			log("2/6 S notice_list");
			
			psmt = conn.prepareStatement(sql);
			log("3/6 S notice_list");
			
			rs = psmt.executeQuery();
			log("4/6 S notice_list");
			
			while(rs.next()){
				BbsDto_notice dto = new BbsDto_notice(
						rs.getInt(1), //seq
						rs.getString(2), //id
						rs.getString(3), //title
						rs.getString(4), //content
						rs.getInt(5), //readcount
						rs.getString(6)//wdate
				);
			    list.add(dto);
			   
			}
			log("5/6 S notice_list");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notice_list", e);
			
		} finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S notice_list");
		}
		return list;
	}
	
	@Override
	public BbsDto_notice notice_detail(int seq) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, READCOUNT, WDATE "
				+ " FROM BBS_NOTICE" 
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_notice detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S notic_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S notic_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S notic_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_notice(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6));
			}
			log("5/6 S notic_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notic_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S notic_detail");
		}
		
		return detaildto;
	}
	
	@Override
	public void notice_readcount(int seq) {
		String sql = " update BBS_NOTICE "
				+ " set readcount = readcount+1 "
				+ " where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt= null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S notice_readcount");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S notice_readcount");
			
			psmt.executeUpdate(); 
			log("4/6 S notice_readcount");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notice_readcount", e);
		}finally {
			DBConn.close(psmt, conn);
			log("5/6 S notice_readcount");
		}
		
	}
	
	
	
	@Override
	public boolean notice_update(int seq, String title, String content) {
		
		String sql=" UPDATE BBS_NOTICE "
				+ " SET TITLE=?, CONTENT=? "
				+ " WHERE SEQ=? " ;
		
		Connection conn = null;
	    PreparedStatement psmt= null;
		int count = 0;		
	    try {
			conn = DBConn.getConnection();
			log("2/6 S notice_update");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			log("3/6 S notice_update");
			
			count = psmt.executeUpdate(); 
			log("4/6 S notice_update");
			
			
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
	public boolean notice_del(int seq) {
		
		String sql = "DELETE FROM BBS_NOTICE "
	    		+ " WHERE SEQ=? ";
	    		
	    Connection conn = null;
	    PreparedStatement psmt = null;		
	    
	    int count = 0;
	    
	    try {
			conn = DBConn.getConnection();
			log("2/6 S notice_del");
			 
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S notice_del");
			
			count = psmt.executeUpdate();
			log("4/6 S notice_del");
			
			 
		} catch (SQLException e) {
			e.printStackTrace();
			log("4/6 S notice_del", e);
		} finally {
			DBConn.close(psmt, conn);
			log("4/6 S notice_del");
		}
	    return count>0?true:false;
	}
	
	@Override
	public List<BbsDto_notice> getBbsPagingList(PagingBean paging, String searchWord) {


		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_notice> bbslist = new ArrayList<>(); //10개씩 짤라서 리스트 리턴
		String sWord = "%" + searchWord.trim() + "%";
		
		try {
			conn = DBConn.getConnection(); 
			//autocommit(false)해줘야함.. 사실 ㅎㅎ 
			log("1/6 S getBbsPagingList");
			
			String totalSql = " SELECT COUNT(SEQ) FROM BBS_NOTICE  WHERE TITLE LIKE '" + sWord + "'" ; //글이 총 몇개 있는지 알아봄 --> totalcount 세팅 하기 위해 
			psmt = conn.prepareStatement(totalSql);
			System.out.println("dao totalsql:" + totalSql);
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
					+ " (SELECT * FROM (SELECT * FROM BBS_NOTICE WHERE TITLE LIKE '" + sWord +"' ORDER BY SEQ )"
					+ " WHERE ROWNUM <=" + paging.getStartNum() + " ORDER BY seq DESC) "
					+ " WHERE ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("paging.getStartNum():" + paging.getStartNum());
			System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
			
			psmt = conn.prepareStatement(sql);
			log("2/6 S getBbsPagingList");
			
			rs = psmt.executeQuery();
			log("3/6 S getBbsPagingList");
			
			while(rs.next()){
				int i = 1;              
				BbsDto_notice dto = new BbsDto_notice(
						rs.getInt(i++), //seq 그 다음 번호로 넘어감 
						rs.getString(i++), //id
						rs.getString(i++), //title
						rs.getString(i++), //content
						rs.getInt(i++), //wdate
						rs.getString(i++) ); //readcount
				
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
	public BbsDto_notice notice_pre_detail(int seq) {
		
		String sql = " select * from bbs_notice "
				+ " where seq = (select min(seq) from bbs_notice where seq>? ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_notice detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S notice_pre_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S notice_pre_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S notice_pre_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_notice(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6));
			}
			log("5/6 S notice_pre_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notice_pre_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S notice_pre_detail");
		}
		
		return detaildto;
	}
	@Override
	public BbsDto_notice notice_next_detail(int seq) {

		String sql = " select * from bbs_notice "
				+ " where seq = (select max(seq) from bbs_notice where seq<? ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_notice detaildto = null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S notice_next_detail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S notice_next_detail");
			
			rs = psmt.executeQuery();
			log("4/6 S notice_next_detail");
			
			while(rs.next()){
				detaildto = new BbsDto_notice(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6));
			}
			log("5/6 S notice_next_detail");
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F notice_next_detail", e);
		}finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S notice_next_detail");
		}
		
		return detaildto;
	}
	
	   

	
	
}