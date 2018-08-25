package airRes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBConn;
import main.BookingDto;

public class airResDao implements iairResDao {
	
	private static airResDao airResDao = null;
	public airResDao() {
		DBConn.initConnect();
	}
	public static airResDao getInstance(){
		if(airResDao == null){
			airResDao = new airResDao();
		}
		return airResDao;
	}
	
	@Override
	public List<airResDto> getAirResList(String id) {
		
		String sql = " select * from AIR_RESERVE where R_ID=? " ;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<airResDto> list = new ArrayList<airResDto>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getAirlist");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("3/6 S getAirlist");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getAirlist");
			
			while(rs.next()){
				 
		    airResDto dto = new airResDto(
		    		rs.getInt(1),
		    		rs.getString(2), 
		    		rs.getInt(3), 
		    		rs.getString(4),
		    		rs.getString(5),
		    		rs.getString(6),
		    		rs.getInt(7),
		    		rs.getInt(8),
		    		rs.getInt(9),
		    		rs.getString(10),
		    		rs.getInt(11),
		    		rs.getString(12),
		    		rs.getInt(13) );
				
		    list.add(dto);
			}
			System.out.println("5/6 S getAirlist");
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("6/6 S getAirlist");
		}	
		return list;
	}
	@Override
	public airResDto getAirRes(int seq) {
		
		String sql = " SELECT * FROM AIR_RESERVE "
				+ " WHERE R_NUM = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		airResDto dto = null;
				
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S getAirRes");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S getAirRes");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 S getAirlist");
			
			
			while(rs.next()){				 
				dto = new airResDto(
		    		rs.getInt(1),
		    		rs.getString(2), 
		    		rs.getInt(3), 
		    		rs.getString(4),
		    		rs.getString(5),
		    		rs.getString(6),
		    		rs.getInt(7),
		    		rs.getInt(8),
		    		rs.getInt(9),
		    		rs.getString(10),
		    		rs.getInt(11),
		    		rs.getString(12),
		    		rs.getInt(13) );
				System.out.println("5/6 S getAirRes");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S getAirRes");
		}		
		return dto;
	}
	
	@Override
	public boolean cancelARes(int seq) {
		
		String sql = " DELETE FROM AIR_RESERVE WHERE R_NUM = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S cancelARes");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3/6 S cancelARes");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S cancelARes");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S cancelARes");
		}		
		return count>0?true:false;
	}
	
	@Override
	public boolean addAirSeat(int seq, int num, String seat) {
		
		 String sql="";
         
         //일등석
         if(seat.equals("일등석")){
         sql = " UPDATE AIR_INFO SET A_SEAT_ONE = A_SEAT_ONE + " + num
               + " WHERE A_NUM= " + seq;
         }
         //비즈니스석
         if(seat.equals("비즈니스석")){
         sql = " UPDATE AIR_INFO SET A_SEAT_TWO = A_SEAT_TWO - " + num
               + " WHERE A_NUM= " + seq;
         }
         //일반석
         if(seat.equals("일반석")){
         sql = " UPDATE AIR_INFO SET A_SEAT_THREE = A_SEAT_THREE + " + num
               + " WHERE A_NUM=" + seq;
         }
         
         Connection conn = null;
         PreparedStatement psmt = null;
         
         int count = 0;

         try {
            conn = DBConn.getConnection();
            System.out.println("2/6 S addAirSeat");
            
            psmt = conn.prepareStatement(sql);

            System.out.println("3/6 S addAirSeat");
            
            count = psmt.executeUpdate();
            System.out.println("4/6 S addAirSeat");
            
         } catch (SQLException e) {
            e.printStackTrace();
         } finally {
            DBConn.close(psmt, conn);
            System.out.println("5/6 S addAirSeat");
         }      
         return count>0?true:false;
	}
	
	

}
