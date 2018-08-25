package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;
import paging.PagingBean;
import paging.PagingUtil;

public class ReserveDao implements IReserveDao {

	private static ReserveDao reserveDao = null;
	
	private ReserveDao() {
		DBConn.initConnect();
	}
	
	public static ReserveDao getInstance() {
		if(reserveDao == null){
			reserveDao = new ReserveDao();
		}
		return reserveDao;
	}

	@Override
	public List<ReserveDto> reserveList(PagingBean paging) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReserveDto> relist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S reserveList");
			
			//데이터갯수 구하기
			String totalSql = " SELECT COUNT(R_NUM) FROM AIR_RESERVE";
			psmt= conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //글의 총갯수
			paging.setTotalCount(totalCount); //글의 총갯수넣기
			System.out.println("2/6 S reserveList");
			
			paging = PagingUtil.setPasingInfo(paging);
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_RESERVE ORDER BY R_RDATE) "
					+ " WHERE ROWNUM <="+paging.getStartNum()+" ORDER BY R_RDATE DESC) "
					+ " WHERE ROWNUM <="+paging.getCountPerPage();
			
			System.out.println("3/6 S reserveList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("4/6 S reserveList");
			
			while(rs.next()){
				int i=1;
				ReserveDto dto = new ReserveDto(
						rs.getInt(i++),//r_num
						rs.getString(i++),//r_id
						rs.getInt(i++), //r_info_num
						rs.getString(i++), //r_pack_name
						rs.getString(i++), //r_st_date
						rs.getString(i++), //r_en_date
						rs.getInt(i++), //r_pple_num_adt
						rs.getInt(i++), //r_pple_num_chi
						rs.getInt(i++), //r_pple_num_inf
						rs.getString(i++), //r_pple_seat
						rs.getInt(i++), //r_total_place
						rs.getString(i++), //r_rdate
						rs.getInt(i++) //r_state
						);
				relist.add(dto);
			}
			System.out.println("5/6 S reserveList");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S reserveList");
		}
		
		return relist;
	}

	@Override
	public ReserveDto getreserve(int r_num) {
		String sql = " SELECT R_NUM, R_ID, R_INFO_NUM,R_PACK_NAME, "
				+ " R_ST_DATE, R_EN_DATE, R_PPLE_NUM_ADT, R_PPLE_NUM_CHI, "
				+ " R_PPLE_NUM_INF,R_PPLE_SEAT, R_TOTAL_PLACE, R_RDATE, R_STATE "
				+ " FROM AIR_RESERVE " 
				+ " WHERE R_NUM=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ReserveDto dto = null;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getreserve");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, r_num);
			System.out.println("3/6 S getreserve");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getreserve");
			
			while(rs.next()){
				int i = 1;
				dto = new ReserveDto(
						rs.getInt(i++), //r_num
						rs.getString(i++), //r_id
						rs.getInt(i++), //R_INFO_NUM
						rs.getString(i++), //R_PACK_NAME
						rs.getString(i++), //R_ST_DATE
						rs.getString(i++), //R_EN_DATE
						rs.getInt(i++), //R_PPLE_NUM_ADT
						rs.getInt(i++), //R_PPLE_NUM_CHI
						rs.getInt(i++), //R_PPLE_NUM_INF
						rs.getString(i++), //R_TOTAL_PLACE
						rs.getInt(i++), //R_PPLE_SEAT
						rs.getString(i++),//R_RDATE
						rs.getInt(i++) //R_STATE
						);				
			}
			System.out.println("5/6 S airplainDetail");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S airplainDetail");
		}
		
		return dto;
	}

	@Override
	public boolean updateState(ReserveDto dto, int state) {
		
		String sql = " UPDATE AIR_RESERVE SET R_STATE = "+state+
				 " WHERE R_NUM = "+dto.getR_num();
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S updateState");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("3/6 S updateState");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S updateState");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S updateState");
		}		
		return count>0?true:false;
	}

	@Override
	public boolean deleteReserve(int r_num) {
		
		String sql = " DELETE FROM AIR_RESERVE WHERE R_NUM=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S updateState");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, r_num);
			System.out.println("3/6 S updateState");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S updateState");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S updateState");
		}		
		return count>0?true:false;
	}

	
	
	
}
