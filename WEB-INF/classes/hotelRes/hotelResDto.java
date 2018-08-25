package hotelRes;

public class hotelResDto {
	
/*
CREATE TABLE AIR_HOTEL_RESERVE(
    H_SEQ NUMBER(10) PRIMARY KEY,
    H_NUM NUMBER(10) NOT NULL,
    H_ID VARCHAR2(20) NOT NULL,
    H_NAME VARCHAR2(20) NOT NULL,
    H_CHECK_IN VARCHAR2(20) NOT NULL,
    H_CHECK_OUT VARCHAR2(20) NOT NULL,
    H_PRICE NUMBER(10) NOT NULL,
    H_ROOM NUMBER(10) NOT NULL,
    H_LOCATION VARCHAR2(20) NOT NULL,
    H_WDATE DATE,
    H_EMAIL VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_ID_ FOREIGN KEY(H_ID) REFERENCES AIR_MEMBER(ID),
    CONSTRAINT FK_H_NUM FOREIGN KEY(H_NUM) REFERENCES AIR_HOTEL(H_NUM)
);

CREATE SEQUENCE SEQ_AIR_HOTEL_RES
START WITH 1 INCREMENT BY 1;

DROP TABLE AIR_HOTEL_RESERVE
CASCADE CONSTRAINT;

DROP SEQUENCE SEQ_AIR_HOTEL_RES;
*/
	
	private int seq;
	private int num;
	private String id;
	private String name;
	private String checkIn;
	private String checkOut;
	private int price;
	private int room;
	private String location;
	private String wdate;
	private String email;
	
	public hotelResDto() {
		
	}

	

	public hotelResDto(int num, String id, String name, String checkIn, String checkOut, int price, int room,
			String location, String email) {
		super();
		this.num = num;
		this.id = id;
		this.name = name;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.price = price;
		this.room = room;
		this.location = location;
		this.email = email;
	}



	public hotelResDto(int seq, int num, String id, String name, String checkIn, String checkOut, int price, int room,
			String location, String wdate, String email) {
		super();
		this.seq = seq;
		this.num = num;
		this.id = id;
		this.name = name;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.price = price;
		this.room = room;
		this.location = location;
		this.wdate = wdate;
		this.email = email;
	}



	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getRoom() {
		return room;
	}

	public void setRoom(int room) {
		this.room = room;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}



	@Override
	public String toString() {
		return "hotelResDto [seq=" + seq + ", num=" + num + ", id=" + id + ", name=" + name + ", checkIn=" + checkIn
				+ ", checkOut=" + checkOut + ", price=" + price + ", room=" + room + ", location=" + location
				+ ", wdate=" + wdate + ", email=" + email + "]";
	}



	
	
}
