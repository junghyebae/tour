package admin;

import java.io.Serializable;

public class ReserveDto implements Serializable {

	private static final long serialVersionUID = 4817360615760073185L;
	
	private int r_num;
	private String r_id;
	private int r_info_num;
	private String r_pack_name;
	private String r_st_date;
	private String r_en_date;
	private int r_pple_num_adt;
	private int r_pple_num_chi;
	private int r_pple_num_inf;
	private String r_pple_seat;
	private int r_total_place;
	private String r_rdate;
	private int r_state;
	
	

	public ReserveDto(int r_num, String r_id, int r_info_num, String r_pack_name, String r_st_date, String r_en_date,
			int r_pple_num_adt, int r_pple_num_chi, int r_pple_num_inf, String r_pple_seat, int r_total_place,
			String r_rdate, int r_state) {

		this.r_num = r_num;
		this.r_id = r_id;
		this.r_info_num = r_info_num;
		this.r_pack_name = r_pack_name;
		this.r_st_date = r_st_date;
		this.r_en_date = r_en_date;
		this.r_pple_num_adt = r_pple_num_adt;
		this.r_pple_num_chi = r_pple_num_chi;
		this.r_pple_num_inf = r_pple_num_inf;
		this.r_pple_seat = r_pple_seat;
		this.r_total_place = r_total_place;
		this.r_rdate = r_rdate;
		this.r_state = r_state;
	}

	public int getR_state() {
		return r_state;
	}

	public void setR_state(int r_state) {
		this.r_state = r_state;
	}

	public int getR_num() {
		return r_num;
	}

	public void setR_num(int r_num) {
		this.r_num = r_num;
	}

	public String getR_id() {
		return r_id;
	}

	public void setR_id(String r_id) {
		this.r_id = r_id;
	}

	public int getR_info_num() {
		return r_info_num;
	}

	public void setR_info_num(int r_info_num) {
		this.r_info_num = r_info_num;
	}

	public String getR_pack_name() {
		return r_pack_name;
	}

	public void setR_pack_name(String r_pack_name) {
		this.r_pack_name = r_pack_name;
	}

	public String getR_st_date() {
		return r_st_date;
	}

	public void setR_st_date(String r_st_date) {
		this.r_st_date = r_st_date;
	}

	public String getR_en_date() {
		return r_en_date;
	}

	public void setR_en_date(String r_en_date) {
		this.r_en_date = r_en_date;
	}

	public int getR_pple_num_adt() {
		return r_pple_num_adt;
	}

	public void setR_pple_num_adt(int r_pple_num_adt) {
		this.r_pple_num_adt = r_pple_num_adt;
	}

	public int getR_pple_num_chi() {
		return r_pple_num_chi;
	}

	public void setR_pple_num_chi(int r_pple_num_chi) {
		this.r_pple_num_chi = r_pple_num_chi;
	}

	public int getR_pple_num_inf() {
		return r_pple_num_inf;
	}

	public void setR_pple_num_inf(int r_pple_num_inf) {
		this.r_pple_num_inf = r_pple_num_inf;
	}

	public String getR_pple_seat() {
		return r_pple_seat;
	}

	public void setR_pple_seat(String r_pple_seat) {
		this.r_pple_seat = r_pple_seat;
	}

	public int getR_total_place() {
		return r_total_place;
	}

	public void setR_total_place(int r_total_place) {
		this.r_total_place = r_total_place;
	}

	public String getR_rdate() {
		return r_rdate;
	}

	public void setR_rdate(String r_rdate) {
		this.r_rdate = r_rdate;
	}

	@Override
	public String toString() {
		return "ReserveDto [r_num=" + r_num + ", r_id=" + r_id + ", r_info_num=" + r_info_num + ", r_pack_name="
				+ r_pack_name + ", r_st_date=" + r_st_date + ", r_en_date=" + r_en_date + ", r_pple_num_adt="
				+ r_pple_num_adt + ", r_pple_num_chi=" + r_pple_num_chi + ", r_pple_num_inf=" + r_pple_num_inf
				+ ", r_pple_seat=" + r_pple_seat + ", r_total_place=" + r_total_place + ", r_rdate=" + r_rdate
				+ ", r_state=" + r_state + "]";
	}

	
	
	
	

}
