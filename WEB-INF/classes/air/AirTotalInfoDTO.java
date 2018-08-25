package air;

import java.io.Serializable;

public class AirTotalInfoDTO implements Serializable {

	// 검색시 불러워야할 정보들
	private int T_PNUM;
	private int T_PPRICE;
	private String T_PNAME;
	private int T_ANUM;
	private String T_ANAME;
	private int T_ASEAT_ONE;
	private int T_ASEAT_TWO;
	private int T_ASEAT_THREE;
	private long T_ATIME_S;
	private long T_ATIME_E;
	private long T_APRICE;
	
	private int T_SUMPRICE;

	// 상품정보
	private String P_SCHEDULE;
	private String P_CONTENT;
	private String P_COUNTRY;
	private int P_READCOUNT; // 인기순?
	private int P_BUYCOUNT; // 구매순?

	// 비행기정보
	private String a_location_s;
	private String a_location_e;

	public AirTotalInfoDTO() {
	}
	
	public AirTotalInfoDTO(int t_PNUM, int t_PPRICE, String t_PNAME, int t_ANUM, String t_ANAME, int t_ASEAT_ONE,
			int t_ASEAT_TWO, int t_ASEAT_THREE, long t_ATIME_S, long t_ATIME_E, long t_APRICE, int t_SUMPRICE) {
		super();
		T_PNUM = t_PNUM;
		T_PPRICE = t_PPRICE;
		T_PNAME = t_PNAME;
		T_ANUM = t_ANUM;
		T_ANAME = t_ANAME;
		T_ASEAT_ONE = t_ASEAT_ONE;
		T_ASEAT_TWO = t_ASEAT_TWO;
		T_ASEAT_THREE = t_ASEAT_THREE;
		T_ATIME_S = t_ATIME_S;
		T_ATIME_E = t_ATIME_E;
		T_APRICE = t_APRICE;
		T_SUMPRICE = t_SUMPRICE;
	}

	public AirTotalInfoDTO(int t_PNUM, int t_PPRICE, String t_PNAME, int t_ANUM, String t_ANAME, int t_ASEAT_ONE,
			int t_ASEAT_TWO, int t_ASEAT_THREE, long t_ATIME_S, long t_ATIME_E, long t_APRICE) {
		super();
		T_PNUM = t_PNUM;
		T_PPRICE = t_PPRICE;
		T_PNAME = t_PNAME;
		T_ANUM = t_ANUM;
		T_ANAME = t_ANAME;
		T_ASEAT_ONE = t_ASEAT_ONE;
		T_ASEAT_TWO = t_ASEAT_TWO;
		T_ASEAT_THREE = t_ASEAT_THREE;
		T_ATIME_S = t_ATIME_S;
		T_ATIME_E = t_ATIME_E;
		T_APRICE = t_APRICE;
	}


	public int getT_SUMPRICE() {
		return T_SUMPRICE;
	}

	public void setT_SUMPRICE(int t_SUMPRICE) {
		T_SUMPRICE = t_SUMPRICE;
	}

	public int getT_PNUM() {
		return T_PNUM;
	}

	public void setT_PNUM(int t_PNUM) {
		T_PNUM = t_PNUM;
	}

	public int getT_PPRICE() {
		return T_PPRICE;
	}

	public void setT_PPRICE(int t_PPRICE) {
		T_PPRICE = t_PPRICE;
	}

	public int getT_ANUM() {
		return T_ANUM;
	}

	public void setT_ANUM(int t_ANUM) {
		T_ANUM = t_ANUM;
	}

	public String getT_PNAME() {
		return T_PNAME;
	}

	public void setT_PNAME(String t_PNAME) {
		T_PNAME = t_PNAME;
	}

	public String getT_ANAME() {
		return T_ANAME;
	}

	public void setT_ANAME(String t_ANAME) {
		T_ANAME = t_ANAME;
	}

	public int getT_ASEAT_ONE() {
		return T_ASEAT_ONE;
	}

	public void setT_ASEAT_ONE(int t_ASEAT_ONE) {
		T_ASEAT_ONE = t_ASEAT_ONE;
	}

	public int getT_ASEAT_TWO() {
		return T_ASEAT_TWO;
	}

	public void setT_ASEAT_TWO(int t_ASEAT_TWO) {
		T_ASEAT_TWO = t_ASEAT_TWO;
	}

	public int getT_ASEAT_THREE() {
		return T_ASEAT_THREE;
	}

	public void setT_ASEAT_THREE(int t_ASEAT_THREE) {
		T_ASEAT_THREE = t_ASEAT_THREE;
	}

	public long getT_ATIME_S() {
		return T_ATIME_S;
	}

	public void setT_ATIME_S(long t_ATIME_S) {
		T_ATIME_S = t_ATIME_S;
	}

	public long getT_ATIME_E() {
		return T_ATIME_E;
	}

	public void setT_ATIME_E(long t_ATIME_E) {
		T_ATIME_E = t_ATIME_E;
	}

	public long getT_APRICE() {
		return T_APRICE;
	}

	public void setT_APRICE(long t_APRICE) {
		T_APRICE = t_APRICE;
	}

	public String getP_SCHEDULE() {
		return P_SCHEDULE;
	}

	public void setP_SCHEDULE(String p_SCHEDULE) {
		P_SCHEDULE = p_SCHEDULE;
	}

	public String getP_CONTENT() {
		return P_CONTENT;
	}

	public void setP_CONTENT(String p_CONTENT) {
		P_CONTENT = p_CONTENT;
	}

	public String getP_COUNTRY() {
		return P_COUNTRY;
	}

	public void setP_COUNTRY(String p_COUNTRY) {
		P_COUNTRY = p_COUNTRY;
	}

	public int getP_READCOUNT() {
		return P_READCOUNT;
	}

	public void setP_READCOUNT(int p_READCOUNT) {
		P_READCOUNT = p_READCOUNT;
	}

	public int getP_BUYCOUNT() {
		return P_BUYCOUNT;
	}

	public void setP_BUYCOUNT(int p_BUYCOUNT) {
		P_BUYCOUNT = p_BUYCOUNT;
	}

	public String getA_location_s() {
		return a_location_s;
	}

	public void setA_location_s(String a_location_s) {
		this.a_location_s = a_location_s;
	}

	public String getA_location_e() {
		return a_location_e;
	}

	public void setA_location_e(String a_location_e) {
		this.a_location_e = a_location_e;
	}

	@Override
	public String toString() {
		return "AirTotalInfoDTO [T_PNUM=" + T_PNUM + ", T_PPRICE=" + T_PPRICE + ", T_ANUM=" + T_ANUM + ", T_PNAME="
				+ T_PNAME + ", T_ANAME=" + T_ANAME + ", T_ASEAT_ONE=" + T_ASEAT_ONE + ", T_ASEAT_TWO=" + T_ASEAT_TWO
				+ ", T_ASEAT_THREE=" + T_ASEAT_THREE + ", T_ATIME_S=" + T_ATIME_S + ", T_ATIME_E=" + T_ATIME_E
				+ ", T_APRICE=" + T_APRICE + ", P_SCHEDULE=" + P_SCHEDULE + ", P_CONTENT=" + P_CONTENT + ", P_COUNTRY="
				+ P_COUNTRY + ", P_READCOUNT=" + P_READCOUNT + ", P_BUYCOUNT=" + P_BUYCOUNT + ", a_location_s="
				+ a_location_s + ", a_location_e=" + a_location_e + "]";
	}

}
