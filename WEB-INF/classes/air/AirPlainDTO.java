package air;

import java.io.Serializable;

public class AirPlainDTO implements Serializable {
	
	private int a_num;
	private String a_name;
	private int a_seat_one;
	private int a_seat_two;
	private int a_seat_three;
	private String a_location_s;
	private String a_location_e;
	private long a_time_s;
	private long a_time_e;
	private long a_price;
	
	public AirPlainDTO() {}
	
	public AirPlainDTO(int a_num, String a_name, int a_seat_one, int a_seat_two, int a_seat_three, String a_location_s,
			String a_location_e, long a_time_s, long a_time_e, long a_price) {
		super();
		this.a_num = a_num;
		this.a_name = a_name;
		this.a_seat_one = a_seat_one;
		this.a_seat_two = a_seat_two;
		this.a_seat_three = a_seat_three;
		this.a_location_s = a_location_s;
		this.a_location_e = a_location_e;
		this.a_time_s = a_time_s;
		this.a_time_e = a_time_e;
		this.a_price = a_price;
	}

	public int getA_num() {
		return a_num;
	}

	public void setA_num(int a_num) {
		this.a_num = a_num;
	}

	public String getA_name() {
		return a_name;
	}

	public void setA_name(String a_name) {
		this.a_name = a_name;
	}

	public int getA_seat_one() {
		return a_seat_one;
	}

	public void setA_seat_one(int a_seat_one) {
		this.a_seat_one = a_seat_one;
	}

	public int getA_seat_two() {
		return a_seat_two;
	}

	public void setA_seat_two(int a_seat_two) {
		this.a_seat_two = a_seat_two;
	}

	public int getA_seat_three() {
		return a_seat_three;
	}

	public void setA_seat_three(int a_seat_three) {
		this.a_seat_three = a_seat_three;
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

	public long getA_time_s() {
		return a_time_s;
	}

	public void setA_time_s(long a_time_s) {
		this.a_time_s = a_time_s;
	}

	public long getA_time_e() {
		return a_time_e;
	}

	public void setA_time_e(long a_time_e) {
		this.a_time_e = a_time_e;
	}

	public long getA_price() {
		return a_price;
	}

	public void setA_price(long a_price) {
		this.a_price = a_price;
	}

	@Override
	public String toString() {
		return "AirPlaneInfo [a_num=" + a_num + ", a_name=" + a_name + ", a_seat_one=" + a_seat_one + ", a_seat_two="
				+ a_seat_two + ", a_seat_three=" + a_seat_three + ", a_location_s=" + a_location_s + ", a_location_e="
				+ a_location_e + ", a_time_s=" + a_time_s + ", a_time_e=" + a_time_e + ", a_price=" + a_price + "]";
	}
	
}
