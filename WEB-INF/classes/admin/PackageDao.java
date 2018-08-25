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

public class PackageDao implements IPackageDao {

	private static PackageDao packageDao = null;
	
	private PackageDao() {
		DBConn.initConnect();
	}
	
	public static PackageDao getInstance() {
		if(packageDao == null){
			packageDao = new PackageDao();
		}
		return packageDao;
	}
	// 이상 형태를 판별하는 변수
				private boolean isS = true;
			
			// Log Method
				public void log(String msg) {
					if(isS) {
						// msg가 들어오면 클래스명과 같이 출력
						System.out.println(getClass() + ": " + msg);
					}
				}
				
			// Exception Log Method
				public void log(String msg, Exception e) {
					if(isS) {
						// msg와 e가 들어오면 익셉션과 같이 출력
						System.out.println(e + ": " + getClass() + ": " + msg);
					}
				}
				
	@Override
	public boolean addPackage(PackageDto dto) {
		
		String sql = " INSERT INTO AIR_PACKAGE "
				+ " (P_NUM, P_NAME, P_PRICE, P_SCHEDULE ,P_CONTENT ,P_COUNTRY, "
				+ " P_READCOUNT, P_BUYCOUNT, P_LIKE) "
				+ " VALUES(SEQ_P_NUM.NEXTVAL, ?, ?, ?, ?,?, 0, 0, 0) ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addPackage");		// 확인용
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getP_name()); //상품명
			psmt.setLong(2, dto.getP_price()); //상품가격
			psmt.setString(3, dto.getP_schedule()); //상품일정
			psmt.setString(4, dto.getP_name()+"으로 "+dto.getP_schedule()+"일 여행패키지"); //상품내용
			psmt.setString(5, dto.getP_country()); //country
			System.out.println("3/6 S addPackage");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addPackage");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addPackage");
		}		
		return count>0 ? true:false;
	}

	@Override
	public List<PackageDto> packageList(PagingBean paging) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PackageDto> packlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S packageList");
			
			//총 데이터의 갯수 구하기
			String totalSql = " SELECT COUNT(P_NUM) FROM AIR_PACKAGE";
			psmt= conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //글의 총갯수
			paging.setTotalCount(totalCount); //글의 총갯수넣기
			System.out.println("2/6 S packageList");
			
			paging = PagingUtil.setPasingInfo(paging);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " (SELECT * FROM (SELECT * FROM AIR_PACKAGE ORDER BY P_NUM) "
					+ " WHERE ROWNUM <="+paging.getStartNum()+" ORDER BY P_NUM DESC) "
					+ " WHERE ROWNUM <="+paging.getCountPerPage();
			System.out.println("sql ="+sql);
			System.out.println("3/6 S packageList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("4/6 S packageList");
			
			while(rs.next()){
				int i=1;
				PackageDto dto = new PackageDto(
						rs.getInt(i++), //p_num
						rs.getString(i++), //p_name
						rs.getLong(i++), //p_price
						rs.getString(i++), //p_schedule
						rs.getString(i++), //p_content
						rs.getString(i++), //p_country
						rs.getInt(i++), //p_readcount
						rs.getInt(i++), //p_buycount
						rs.getInt(i++) //p_like
				);
				packlist.add(dto);
			}
			System.out.println("5/6 S packageList");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S packageList");
		}
		
		return packlist;
	}

	@Override
	public boolean removePackage(int p_num) {
		String sql = " DELETE FROM AIR_PACKAGE "
				+ " WHERE P_NUM=?";
		Connection conn = null;
		PreparedStatement psmt = null;		
		
		int count = 0;

		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S removePackage");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, p_num);

			System.out.println("3/6 S removePackage");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S removePackage");
			
		} catch (SQLException e) {			
			System.out.println(e.getMessage());
		} finally{
			DBConn.close(psmt, conn);
			System.out.println("5/6 S removePackage");
		}
				
		return count>0?true:false;
	}
	
	public List<PackageDto> PackageList(String eLocation, String date) {
		
		/*
			private int p_num; //상품번호
			private String p_name; //상품명(도시이름+p_num+일정+"일")
			private long p_price; //상품가격
			private String p_schedule; //일정
			private String p_content; //내용
			private String p_country; //도시이름
			private int p_readcount; //조회수
			private int p_buycount; //구매수
			private int p_like; //평점 (평점 노출시 별5개만점 기준 = 평점 / 구매수 로 계산)
		 */
		
		List<PackageDto> list = new ArrayList<PackageDto>();
		
		System.out.println("PackageList의 eLocation: " + eLocation);
		
		if(eLocation.equals("") || eLocation == null) {
			list = new ArrayList<PackageDto>();
		}else {				
			
			// SELECT * FROM AIR_PACKAGE WHERE P_NAME LIKE('도쿄%') AND SUBSTR(P_SCHEDULE,1,INSTR(P_SCHEDULE,'일')-1)='4';
			
			String sql = " SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, "
					+ " P_COUNTRY, P_READCOUNT, P_BUYCOUNT, P_LIKE "
					+ " FROM AIR_PACKAGE "
					+ " WHERE P_NAME LIKE ('" + eLocation + "%') AND SUBSTR(P_SCHEDULE,1,INSTR(P_SCHEDULE,'일')-1)='" + date + "' ";
			
			System.out.println("sql: " + sql);
			
			// WHERE A_TIME_S LIKE ('20170922%') AND A_TIME_E LIKE ('20171003%');
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			log("1/6 S PackageList");
			
			try {
				conn = DBConn.getConnection();
				log("2/6 S PackageList");
				
				psmt = conn.prepareStatement(sql);
				log("3/6 S PackageList");
				
				rs = psmt.executeQuery();
				log("4/6 S PackageList");			
				
				while(rs.next()) {
					int i = 1;
					PackageDto dto = new PackageDto(
							//p_num,
							rs.getInt(i++),
							//p_name,
							rs.getString(i++),
							//p_price,
							rs.getLong(i++),
							//p_schedule,
							rs.getString(i++),
							//p_content,
							rs.getString(i++),
							//p_country,
							rs.getString(i++),
							//p_readcount,
							rs.getInt(i++),
							//p_buycount,
							rs.getInt(i++),
							//p_like
							rs.getInt(i++));
					
					list.add(dto);
				}
				log("5/6 S PackageList");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConn.close(rs, psmt, conn);
				log("6/6 S PackageList");
			}		
		}
		return list;
	}


	
// TODO Method / reservePackList 
	@Override
	public PackageDto reservePackList(String p_name) {
		
		String sql = " SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, "
				+ " P_COUNTRY, P_READCOUNT, P_BUYCOUNT, P_LIKE "
				+ " FROM AIR_PACKAGE "
				+ " WHERE P_NAME = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PackageDto dto = null;
		
		log("1/6 S reservePackList");
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S reservePackList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, p_name);
			log("3/6 S reservePackList");
			
			rs = psmt.executeQuery();
			log("4/6 S reservePackList");			
			
			while(rs.next()) {
				int i = 1;
				dto = new PackageDto(
						//p_num,
						rs.getInt(i++),
						//p_name,
						rs.getString(i++),
						//p_price,
						rs.getLong(i++),
						//p_schedule,
						rs.getString(i++),
						//p_content,
						rs.getString(i++),
						//p_country,
						rs.getString(i++),
						//p_readcount,
						rs.getInt(i++),
						//p_buycount,
						rs.getInt(i++),
						//p_like
						rs.getInt(i++));
			}
			log("5/6 S reservePackList");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S reservePackList");
		}		
		
		return dto;
	}

	@Override
	public boolean addBuycount(String p_name) {
		
		String sql = " UPDATE AIR_PACKAGE SET P_BUYCOUNT = P_BUYCOUNT+1 "
				+ " WHERE P_NAME =? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count =0;
		
		try {
			conn = DBConn.getConnection();
			System.out.println("2/6 S addBuycount");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, p_name);
			System.out.println("3/6 S addBuycount");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 S addBuycount");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
			System.out.println("5/6 S addBuycount");
		}		
		
		return count>0?true:false;
	}

	@Override
	public List<PackageDto> rankList() {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PackageDto> packlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S rankList");
			
			
			String sql = " SELECT * FROM ( SELECT * FROM AIR_PACKAGE ORDER BY P_BUYCOUNT DESC) WHERE ROWNUM<=5";

			System.out.println("2/6 S rankList");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("4/6 S rankList");
			
			while(rs.next()){
				int i=1;
				PackageDto dto = new PackageDto(
						rs.getInt(i++), //p_num
						rs.getString(i++), //p_name
						rs.getLong(i++), //p_price
						rs.getString(i++), //p_schedule
						rs.getString(i++), //p_content
						rs.getString(i++), //p_country
						rs.getInt(i++), //p_readcount
						rs.getInt(i++), //p_buycount
						rs.getInt(i++) //p_like
				);
				packlist.add(dto);
			}
			System.out.println("5/6 S rankList");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S rankList");
		}
		
		return packlist;
	}

	@Override
	public List<PackageDto> rankreadCount() {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PackageDto> packlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S rankreadCount");
			
			String sql =" SELECT * FROM ( SELECT * FROM AIR_PACKAGE ORDER BY P_READCOUNT DESC) WHERE ROWNUM<=5 ";
			System.out.println("2/6 S rankreadCount");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("4/6 S rankreadCount");
			
			while(rs.next()){
				int i=1;
				PackageDto dto = new PackageDto(
						rs.getInt(i++), //p_num
						rs.getString(i++), //p_name
						rs.getLong(i++), //p_price
						rs.getString(i++), //p_schedule
						rs.getString(i++), //p_content
						rs.getString(i++), //p_country
						rs.getInt(i++), //p_readcount
						rs.getInt(i++), //p_buycount
						rs.getInt(i++) //p_like
				);
				packlist.add(dto);
				
			}
			System.out.println("5/6 S rankreadCount");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S rankreadCount");
		}
		
		return packlist;
	}

	@Override
	public List<PackageDto> likeRank() {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PackageDto> packlist = new ArrayList<>();
		
		try {
			conn = DBConn.getConnection();
			System.out.println("1/6 S likeRank");
			
			
			String sql = " SELECT * FROM ( SELECT * FROM AIR_PACKAGE ORDER BY P_LIKE DESC) WHERE ROWNUM<=5";

			System.out.println("2/6 S likeRank");
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("4/6 S likeRank");
			
			while(rs.next()){
				int i=1;
				PackageDto dto = new PackageDto(
						rs.getInt(i++), //p_num
						rs.getString(i++), //p_name
						rs.getLong(i++), //p_price
						rs.getString(i++), //p_schedule
						rs.getString(i++), //p_content
						rs.getString(i++), //p_country
						rs.getInt(i++), //p_readcount
						rs.getInt(i++), //p_buycount
						rs.getInt(i++) //p_like
				);
				packlist.add(dto);
			}
			System.out.println("5/6 S likeRank");
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBConn.close(rs, psmt, conn);
			System.out.println("6/6 S likeRank");
		}
		
		return packlist;
	}

	@Override
	public PackageDto getPackage(int p_num) {
		String sql = " SELECT P_NUM, P_NAME, P_PRICE, P_SCHEDULE, P_CONTENT, "
				+ " P_COUNTRY, P_READCOUNT, P_BUYCOUNT, P_LIKE "
				+ " FROM AIR_PACKAGE "
				+ " WHERE P_NUM = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PackageDto dto = null;
		
		log("1/6 S getPackage");
		
		try {
			conn = DBConn.getConnection();
			log("2/6 S getPackage");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, p_num);
			log("3/6 S getPackage");
			
			rs = psmt.executeQuery();
			log("4/6 S getPackage");			
			
			while(rs.next()) {
				int i = 1;
				dto = new PackageDto(
						//p_num,
						rs.getInt(i++),
						//p_name,
						rs.getString(i++),
						//p_price,
						rs.getLong(i++),
						//p_schedule,
						rs.getString(i++),
						//p_content,
						rs.getString(i++),
						//p_country,
						rs.getString(i++),
						//p_readcount,
						rs.getInt(i++),
						//p_buycount,
						rs.getInt(i++),
						//p_like
						rs.getInt(i++));
			}
			log("5/6 S getPackage");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
			log("6/6 S getPackage");
		}		
		
		return dto;
	}

	public boolean readcountIncrement(int p_num) {
		String sql = " UPDATE AIR_PACKAGE SET P_READCOUNT = P_READCOUNT+1 "
	            + " WHERE P_NUM =? ";
	      
	      Connection conn = null;
	      PreparedStatement psmt = null;
	      
	      int count = 0;
	      
	      try {
	         conn = DBConn.getConnection();
	         System.out.println("2/6 S addBuycount");
	         
	         psmt = conn.prepareStatement(sql);
	         psmt.setInt(1, p_num);
	         System.out.println("3/6 S addBuycount");
	         
	         count = psmt.executeUpdate();
	         System.out.println("4/6 S addBuycount");
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         DBConn.close(psmt, conn);
	         System.out.println("5/6 S addBuycount");
	      }      
	      return count>0?true:false;
	}
}
