package admin;

import java.io.Serializable;

public class PackageDto implements Serializable {

	private static final long serialVersionUID = -7883610405220172510L;
	
	//변수
	private int p_num; //상품번호
	private String p_name; //상품명(도시이름+p_num+일정+"일")
	private long p_price; //상품가격
	private String p_schedule; //일정
	private String p_content; //내용
	private String p_country; //도시이름
	private int p_readcount; //조회수
	private int p_buycount; //구매수
	private int p_like; //평점 (평점 노출시 별5개만점 기준 = 평점 / 구매수 로 계산)
	
	public PackageDto(int p_num, String p_name, long p_price, String p_schedule,
			String p_content, String p_country,
			int p_readcount, int p_buycount, int p_like) {
		this.p_num = p_num;
		this.p_name = p_name;
		this.p_price = p_price;
		this.p_schedule = p_schedule;
		this.p_content = p_content;
		this.p_country = p_country;
		this.p_readcount = p_readcount;
		this.p_buycount = p_buycount;
		this.p_like = p_like;
	}

	public PackageDto(String p_name, long p_price, 
			String p_schedule, String p_country) {
		this.p_name = p_name;
		this.p_price = p_price;
		this.p_schedule = p_schedule;
		this.p_country = p_country;
	}

	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public long getP_price() {
		return p_price;
	}

	public void setP_price(long p_price) {
		this.p_price = p_price;
	}

	public String getP_schedule() {
		return p_schedule;
	}

	public void setP_schedule(String p_schedule) {
		this.p_schedule = p_schedule;
	}

	public String getP_content() {
		return p_content;
	}

	public void setP_content(String p_content) {
		this.p_content = p_content;
	}

	public String getP_country() {
		return p_country;
	}

	public void setP_country(String p_country) {
		this.p_country = p_country;
	}

	public int getP_readcount() {
		return p_readcount;
	}

	public void setP_readcount(int p_readcount) {
		this.p_readcount = p_readcount;
	}

	public int getP_buycount() {
		return p_buycount;
	}

	public void setP_buycount(int p_buycount) {
		this.p_buycount = p_buycount;
	}

	public int getP_like() {
		return p_like;
	}

	public void setP_like(int p_like) {
		this.p_like = p_like;
	}
	
	
	
	
	

}
