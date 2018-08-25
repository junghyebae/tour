package bbs_CS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import paging.PagingBean;
import paging.PagingUtil;

import jdbc.DBConn;

public class BbsDao_cs implements iBbsDao_cs {
	
	public BbsDao_cs() {
	}
	private static BbsDao_cs bbsDao = null;
	public static BbsDao_cs getInstance(){
		if(bbsDao == null){
			bbsDao = new BbsDao_cs();
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
	public boolean cs_write(BbsDto_cs dto) {
		
		String sql =" insert into BBS_CS "
				+ " ( seq, ID ,TITLE , CONTENT , WDATE, "
				+ "   REF, STEP, DEPTH, PARENT, DEL, "
				+ "   READCOUNT, PROCESS, CATEGORY, SECRET, parent_id )"
				+ " values(SEQ_CS.NEXTVAL, ?, ?, ?, SYSDATE, "
				+ " (SELECT NVL(MAX(REF), 0) +1 FROM BBS_CS) , 0, 0, 0, 0,"
				+ " 0, 0, ?, ?,?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S cs_write");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getID());
			psmt.setString(2, dto.getTITLE());
			psmt.setString(3, dto.getCONTENT());
			psmt.setString(4, dto.getCATEGORY());
			psmt.setInt(5, dto.getSECRET());
			psmt.setString(6, dto.getParent_id());
			
			count = psmt.executeUpdate();
			log("4/6 S cs_write");
			
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			log("F cs_write", e);
		} finally {
			DBConn.close(psmt, conn);
			log("5/6 S cs_write");
		}
		return count>0?true:false ;
	}
	
	@Override
	public void cs_readcount(int seq) {
		String sql = " update BBS_CS "
				+ " set readcount = readcount+1 "
				+ " where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt= null;
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S cs_readcount");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S cs_readcount");
			
			psmt.executeUpdate(); 
			log("4/6 S cs_readcount");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F cs_readcount", e);
		}finally {
			DBConn.close(psmt, conn);
			log("5/6 S cs_readcount");
		}
		
	}

	@Override
	public boolean cs_update(int seq, String title, String content, int secret, String category) {
		
		String sql=" UPDATE BBS_CS "
				+ " SET TITLE=?, CONTENT=?, SECRET=?, CATEGORY=?, WDATE=SYSDATE "
				+ " WHERE SEQ=? " ;
	
		Connection conn = null;
	    PreparedStatement psmt= null;
		int count = 0;		
	    try {
			conn = DBConn.getConnection();
			log("2/6 S cs_update");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, secret);
			psmt.setString(4, category);
			psmt.setInt(5, seq);
			log("3/6 S cs_update");
			
			count = psmt.executeUpdate(); 
			log("4/6 S cs_update");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F cs_update", e);
		}finally {
			DBConn.close(psmt, conn);
			log("5/6 S cs_update");
		}
		return count>0?true:false;
	}
	
	@Override
	public boolean cs_del(int seq) {
		
		String sql=" UPDATE BBS_CS "
				+ " SET del = 1 "
				+ " WHERE SEQ=? " ;
		
		Connection conn = null;
	    PreparedStatement psmt= null;
		int count = 0;		
	    try {
			conn = DBConn.getConnection();
			log("2/6 S cs_del");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S cs_del");
			
			count = psmt.executeUpdate(); 
			log("4/6 S cs_del");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			log("F cs_del", e);
		}finally {
			DBConn.close(psmt, conn);
			log("5/6 S cs_del");
		}
		return count>0?true:false;
	}
	
	@Override
	public BbsDto_cs cs_detail(int seq) {
		String sql =" SELECT * "
				+ " FROM BBS_CS"
				+ " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto_cs dto = null;
		
		try{
			
		conn = DBConn.getConnection();
		log("2/6 S cs_detail");
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, seq);
		log("3/6 S cs_detail");
		
		rs = psmt.executeQuery();
		log("4/6 S cs_detail");
		
		while(rs.next()){
			dto = new BbsDto_cs(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getInt(6),
					rs.getInt(7),
					rs.getInt(8),
				    rs.getInt(9),
				    rs.getInt(10),
				    rs.getInt(11),
				    rs.getString(12),
				    rs.getString(13),
				    rs.getInt(14),
				    rs.getString(15));
//					1    2    3      4         5    6     7     8        9     10    11       12         13        14
//					seq, iD, tITLE, cONTENT, wDATE, rEF, sTEP, dEPTH, pARENT, dEL, rEADCOUNT, pROCESS, cATEGORY, sECRET)   
		} log("5/6 cs_detail");
		}catch (SQLException e) {
			e.printStackTrace();
			log("F cs_detail", e);
			
		} finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S cs_detail");
		}
		return dto;
	}
	
	
	@Override
	public boolean cs_answer(int seq, BbsDto_cs dto) {
		
		//1.질문 글 답변중 -> 답변완료 
		String sql = " update bbs_cs "
				+ " set process='1' "
				+ " where seq=? " ;
		
		//2..update
		String sql1 = "UPDATE BBS_CS "
				+ " SET STEP=STEP+1, PROCESS='1' " //process답변완료(1)로 변경
				+ " WHERE REF=(SELECT REF FROM BBS_CS WHERE SEQ=? ) "
				+ " AND STEP > ( SELECT STEP FROM BBS_CS WHERE SEQ=? ) ";
		
		
		//3. insert
		String sql2 = " INSERT INTO BBS_CS "
					+" (seq, "
					+" ID ,TITLE , CONTENT , WDATE, "
					+" REF,STEP,DEPTH, "
					+" PARENT, DEL, "
					+" READCOUNT, PROCESS, CATEGORY, SECRET,parent_id) "
					+" values(SEQ_CS.NEXTVAL, "
					+" ?, ?, ?, SYSDATE, "
					+" (SELECT REF FROM BBS_CS WHERE SEQ=?), "
					+" (SELECT STEP FROM BBS_CS WHERE SEQ=?)+1, " 
					+" (SELECT DEPTH FROM BBS_cs WHERE SEQ=?)+1, "
					+"?, 0, "
					+" 0, '1', ?, ?,?) " ;
		
		Connection conn = null;
		PreparedStatement psmt=null;
		
		int count = 0;
		
		try{
			conn = DBConn.getConnection();
			conn.setAutoCommit(false);
			log("1/6 S answer");
			//1. 본문 처리 
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("2/6 S answer");
			
			count = psmt.executeUpdate();
			log("4/6 S answer");
			
			psmt.clearParameters();
			
			//2.update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			log("2/6 S answer");
			
			count = psmt.executeUpdate();
			log("3/6 S answer");
			
			psmt.clearParameters();
			
			//3.insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, dto.getID()); 
			psmt.setString(2, dto.getTITLE());
			psmt.setString(3, dto.getCONTENT());
			psmt.setInt(4, seq); //ref
			psmt.setInt(5, seq); //step
			psmt.setInt(6, seq); //depth 
			psmt.setInt(7, seq); //parent
			psmt.setString(8, dto.getCATEGORY());
			psmt.setInt(9, dto.getSECRET());
			psmt.setString(10, dto.getParent_id());
			log("4/6 S answer");
			
			count = psmt.executeUpdate();
			
			conn.commit();
			log("5/6 S answer");
			
		}catch (SQLException e) {
			try {
				conn.rollback(); 
			} catch (SQLException e1) {
				log("F answer rollback SQLException", e);
				e1.printStackTrace();
			} 
			log("F answer SQLException", e);
		
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConn.close(psmt, conn);
			log("6/6 S answer");
		}
		return count>0?true:false;
	}
	@Override
	public List<BbsDto_cs> cs_PagingList(PagingBean paging, String searchWord, String category) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_cs> bbslist = new ArrayList<>(); //10개씩 짤라서 리스트 리턴
		String sWord = "%" + searchWord.trim() + "%";
		String scategory = "%" + category.trim() + "%";
		try {
			conn = DBConn.getConnection(); 
			log("1/6 S getBbsPagingList");
			//SELECT * FROM BBS_CS  WHERE TITLE LIKE '%%' and category like '%1%'
			String totalSql = " SELECT COUNT(SEQ) FROM BBS_CS  WHERE TITLE LIKE '"+sWord+"' and category like '" +scategory +"' "; //글이 총 몇개 있는지 알아봄 --> totalcount 세팅 하기 위해 
			psmt = conn.prepareStatement(totalSql);
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
					+ " (SELECT * FROM (SELECT * FROM BBS_CS WHERE TITLE LIKE '" + sWord  + "' and category like '"+scategory+"'  ORDER BY REF ASC, STEP DESC) "
					+ " WHERE ROWNUM <=" + paging.getStartNum() +" ORDER BY REF DESC, STEP ASC) "
					+ " WHERE ROWNUM <=" + paging.getCountPerPage();
			
			System.out.println("paging.getStartNum():" + paging.getStartNum());
			System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
			
			psmt = conn.prepareStatement(sql);
			log("2/6 S getBbsPagingList");
			
			rs = psmt.executeQuery();
			log("3/6 S getBbsPagingList");
			
			while(rs.next()){
				BbsDto_cs dto = new BbsDto_cs(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getInt(7),
						rs.getInt(8),
					    rs.getInt(9),
					    rs.getInt(10),
					    rs.getInt(11),
					    rs.getString(12),
					    rs.getString(13),
					    rs.getInt(14),
					    rs.getString(15));
				
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
	
	//내가 문의 한 내역 
	@Override
	public List<BbsDto_cs> getlist(String id) {
		
		String sql = " SELECT * "
				+ " FROM BBS_CS "
				+ " where id=?"
				+ " order by ref desc, step asc ";
		
		System.out.println(sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto_cs> list = new ArrayList<BbsDto_cs>();
		
		try {
			
			conn = DBConn.getConnection();
			log("2/6 S getlist");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			log("3/6 S getlist");
			
			rs = psmt.executeQuery();
			log("4/6 S getlist");
			
			while(rs.next()){
				BbsDto_cs dto = new BbsDto_cs(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getInt(7),
						rs.getInt(8),
					    rs.getInt(9),
					    rs.getInt(10),
					    rs.getInt(11),
					    rs.getString(12),
					    rs.getString(13),
					    rs.getInt(14),
					    rs.getString(15));
						
//						1    2    3      4         5    6     7     8        9     10    11       12         13        14
//						seq, iD, tITLE, cONTENT, wDATE, rEF, sTEP, dEPTH, pARENT, dEL, rEADCOUNT, pROCESS, cATEGORY, sECRET)
						
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
		public List<BbsDto_cs> getMylist(PagingBean paging, String id) {

			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<BbsDto_cs> bbslist = new ArrayList<>(); //10개씩 짤라서 리스트 리턴
			try {
				conn = DBConn.getConnection(); 
				log("1/6 S getMylist");
				
				String totalSql = " SELECT COUNT(SEQ) FROM BBS_CS WHERE ID = ?";
				psmt = conn.prepareStatement(totalSql);
				psmt.setString(1, id);
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
						+ " (SELECT * FROM (SELECT * FROM BBS_CS WHERE ID = ? ORDER BY SEQ ASC ) "
						+ " WHERE ROWNUM <=" + paging.getStartNum() +" ORDER BY SEQ DESC) "
						+ " WHERE ROWNUM <=" + paging.getCountPerPage();
				
				System.out.println("paging.getStartNum():" + paging.getStartNum());
				System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, id);
				log("2/6 S getMylist");
				
				rs = psmt.executeQuery();
				log("3/6 S getMylist");
				
				while(rs.next()){
					BbsDto_cs dto = new BbsDto_cs(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getString(4),
							rs.getString(5),
							rs.getInt(6),
							rs.getInt(7),
							rs.getInt(8),
						    rs.getInt(9),
						    rs.getInt(10),
						    rs.getInt(11),
						    rs.getString(12),
						    rs.getString(13),
						    rs.getInt(14),
						    rs.getString(15));
					
					bbslist.add(dto);
				}
				log("4/6 S getMylist");
			
			} catch (SQLException e) {
				e.printStackTrace();
				log("F getMylist", e);
			}finally {
				DBConn.close(rs, psmt, conn);
				log("5/6 S getMylist");
			}
			
			return bbslist;
		}


	
	
	
	

}

