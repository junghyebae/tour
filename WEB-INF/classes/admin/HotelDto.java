package admin;

import java.io.Serializable;

public class HotelDto implements Serializable{
	
/*
INSERT INTO AIR_HOTEL
VALUES(SEQ_AIR_HOTEL.NEXTVAL, '테스트1 호텔', '2017-08-24', '2017-08-25', '도쿄', 120970, 7);

CREATE TABLE AIR_HOTEL(
    H_NUM NUMBER(20) PRIMARY KEY,
    H_NAME VARCHAR2(50) NOT NULL,
    H_CHECK_IN VARCHAR2(20) NOT NULL,
    H_CHECK_OUT VARCHAR2(20) NOT NULL,
    H_LOCATION VARCHAR2(20) NOT NULL,
    H_PRICE NUMBER(10) NOT NULL,
    H_ROOM NUMBER(10) NOT NULL
);

CREATE SEQUENCE SEQ_AIR_HOTEL
START WITH 1 INCREMENT BY 1;

DROP TABLE AIR_HOTEL
CASCADE CONSTRAINT;

DROP SEQUENCE SEQ_AIR_HOTEL;
*/
	private static final long serialVersionUID = 5022039608667326072L;
	private int hNum;
	private String name;
	private String checkIn;
	private String CheckOut;
	private String location;
	private long price;
	private int room;
	
	
	public HotelDto(int hNum, String name, String checkIn, String checkOut, String location, long price, int room) {
		this.hNum = hNum;
		this.name = name;
		this.checkIn = checkIn;
		CheckOut = checkOut;
		this.location = location;
		this.price = price;
		this.room = room;
	}


	public int gethNum() {
		return hNum;
	}


	public void sethNum(int hNum) {
		this.hNum = hNum;
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
		return CheckOut;
	}


	public void setCheckOut(String checkOut) {
		CheckOut = checkOut;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public long getPrice() {
		return price;
	}


	public void setPrice(long price) {
		this.price = price;
	}


	public int getRoom() {
		return room;
	}


	public void setRoom(int room) {
		this.room = room;
	}


	@Override
	public String toString() {
		return "HotelDto [hNum=" + hNum + ", name=" + name + ", checkIn=" + 
	checkIn + ", CheckOut=" + CheckOut
				+ ", location=" + location + ", price=" + price + ", room=" + room + "]";
	}
	

}
