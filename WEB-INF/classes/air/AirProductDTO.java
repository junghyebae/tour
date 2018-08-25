package air;

import java.io.Serializable;

public class AirProductDTO implements Serializable {
	
	private int P_NUM;
	private String P_NAME;
	private int P_PRICE;
	private String P_SCHEDULE;
	private String P_CONTENT;
	private String P_COUNTRY;
	private int P_READCOUNT;	// 인기순?
	private int P_BUYCOUNT;		// 구매순?
	
	public AirProductDTO() {}

	public AirProductDTO(int p_NUM, String p_NAME, int p_PRICE, String p_SCHEDULE, String p_CONTENT, String p_COUNTRY) {
		super();
		P_NUM = p_NUM;
		P_NAME = p_NAME;
		P_PRICE = p_PRICE;
		P_SCHEDULE = p_SCHEDULE;
		P_CONTENT = p_CONTENT;
		P_COUNTRY = p_COUNTRY;
	}

	public AirProductDTO(int p_NUM, String p_NAME, int p_PRICE, String p_SCHEDULE, String p_CONTENT, String p_COUNTRY,
			int p_READCOUNT, int p_BUYCOUNT) {
		super();
		P_NUM = p_NUM;
		P_NAME = p_NAME;
		P_PRICE = p_PRICE;
		P_SCHEDULE = p_SCHEDULE;
		P_CONTENT = p_CONTENT;
		P_COUNTRY = p_COUNTRY;
		P_READCOUNT = p_READCOUNT;
		P_BUYCOUNT = p_BUYCOUNT;
	}
	
	public int getP_NUM() {
		return P_NUM;
	}

	public void setP_NUM(int p_NUM) {
		P_NUM = p_NUM;
	}

	public String getP_NAME() {
		return P_NAME;
	}

	public void setP_NAME(String p_NAME) {
		P_NAME = p_NAME;
	}

	public int getP_PRICE() {
		return P_PRICE;
	}

	public void setP_PRICE(int p_PRICE) {
		P_PRICE = p_PRICE;
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

	@Override
	public String toString() {
		return "AirProductDTO [P_NUM=" + P_NUM + ", P_NAME=" + P_NAME + ", P_PRICE=" + P_PRICE + ", P_SCHEDULE="
				+ P_SCHEDULE + ", P_CONTENT=" + P_CONTENT + ", P_COUNTRY=" + P_COUNTRY + ", P_READCOUNT=" + P_READCOUNT
				+ ", P_BUYCOUNT=" + P_BUYCOUNT + "]";
	}
	
}
