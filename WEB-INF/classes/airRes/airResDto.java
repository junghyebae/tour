package airRes;

import java.io.Serializable;
/*CREATE TABLE AIR_RESERVE (
	  1  R_NUM NUMBER(8) NOT NULL,
	  2  R_ID VARCHAR2(20) PRIMARY KEY,
	  3  R_INFO_NUM NUMBER(20) NOT NULL,
	  4  R_PACK_NAME VARCHAR2(50) NOT NULL,                 
	  5  R_ST_DATE VARCHAR2(40) NOT NULL,
	  6  R_EN_DATE VARCHAR2(40) NOT NULL,
	  7  R_PPLE_NUM_ADT NUMBER(2) NOT NULL,
	  8  R_PPLE_NUM_CHI NUMBER(2) NOT NULL,
	  9  R_PPLE_NUM_INF NUMBER(2) NOT NULL,
	  10  R_PPLE_SEAT VARCHAR2(10) NOT NULL,
	  11  R_TOTAL_PLACE NUMBER(8) NOT NULL,
	  12  R_RDATE DATE NOT NULL,
	  
	  13 r_state  int ... 
	  
	    CONSTRAINT FK_ID FOREIGN KEY(R_ID) REFERENCES AIR_MEMBER(ID),
	    CONSTRAINT FK_NUM FOREIGN KEY(R_INFO_NUM) REFERENCES AIR_INFO(A_NUM),
	    CONSTRAINT FK_NAME FOREIGN KEY(R_PACK_NAME) REFERENCES AIR_PACKAGE(P_NAME)
	);*/

public class airResDto implements Serializable {
	
	   int R_NUM ;
	   String R_ID ; 
	   int R_INFO_NUM; // 
	   String R_PACK_NAME;                 
	   String R_ST_DATE;
	   String R_EN_DATE;
       int R_PPLE_NUM_ADT; //어른
	   int R_PPLE_NUM_CHI; //아동
	   int R_PPLE_NUM_INF;  //유아
	   String R_PPLE_SEAT; // 좌석
	   int R_TOTAL_PLACE ; // 가격
	   String R_RDATE ; // 
	   int R_STATE ; //0 취소 1 대기 2 완료 
	   
	   public airResDto(int r_NUM, String r_ID, int r_INFO_NUM, String r_PACK_NAME, String r_ST_DATE, String r_EN_DATE,
			int r_PPLE_NUM_ADT, int r_PPLE_NUM_CHI, int r_PPLE_NUM_INF, String r_PPLE_SEAT, int r_TOTAL_PLACE,
			String r_RDATE, int r_STATE) {
		super();
		R_NUM = r_NUM;
		R_ID = r_ID;
		R_INFO_NUM = r_INFO_NUM;
		R_PACK_NAME = r_PACK_NAME;
		R_ST_DATE = r_ST_DATE;
		R_EN_DATE = r_EN_DATE;
		R_PPLE_NUM_ADT = r_PPLE_NUM_ADT;
		R_PPLE_NUM_CHI = r_PPLE_NUM_CHI;
		R_PPLE_NUM_INF = r_PPLE_NUM_INF;
		R_PPLE_SEAT = r_PPLE_SEAT;
		R_TOTAL_PLACE = r_TOTAL_PLACE;
		R_RDATE = r_RDATE;
		R_STATE = r_STATE;
	}

	public int getR_NUM() {
		return R_NUM;
	}

	public void setR_NUM(int r_NUM) {
		R_NUM = r_NUM;
	}

	public String getR_ID() {
		return R_ID;
	}

	public void setR_ID(String r_ID) {
		R_ID = r_ID;
	}

	public int getR_INFO_NUM() {
		return R_INFO_NUM;
	}

	public void setR_INFO_NUM(int r_INFO_NUM) {
		R_INFO_NUM = r_INFO_NUM;
	}

	public String getR_PACK_NAME() {
		return R_PACK_NAME;
	}

	public void setR_PACK_NAME(String r_PACK_NAME) {
		R_PACK_NAME = r_PACK_NAME;
	}

	public String getR_ST_DATE() {
		return R_ST_DATE;
	}

	public void setR_ST_DATE(String r_ST_DATE) {
		R_ST_DATE = r_ST_DATE;
	}

	public String getR_EN_DATE() {
		return R_EN_DATE;
	}

	public void setR_EN_DATE(String r_EN_DATE) {
		R_EN_DATE = r_EN_DATE;
	}

	public int getR_PPLE_NUM_ADT() {
		return R_PPLE_NUM_ADT;
	}

	public void setR_PPLE_NUM_ADT(int r_PPLE_NUM_ADT) {
		R_PPLE_NUM_ADT = r_PPLE_NUM_ADT;
	}

	public int getR_PPLE_NUM_CHI() {
		return R_PPLE_NUM_CHI;
	}

	public void setR_PPLE_NUM_CHI(int r_PPLE_NUM_CHI) {
		R_PPLE_NUM_CHI = r_PPLE_NUM_CHI;
	}

	public int getR_PPLE_NUM_INF() {
		return R_PPLE_NUM_INF;
	}

	public void setR_PPLE_NUM_INF(int r_PPLE_NUM_INF) {
		R_PPLE_NUM_INF = r_PPLE_NUM_INF;
	}

	public String getR_PPLE_SEAT() {
		return R_PPLE_SEAT;
	}

	public void setR_PPLE_SEAT(String r_PPLE_SEAT) {
		R_PPLE_SEAT = r_PPLE_SEAT;
	}

	public int getR_TOTAL_PLACE() {
		return R_TOTAL_PLACE;
	}

	public void setR_TOTAL_PLACE(int r_TOTAL_PLACE) {
		R_TOTAL_PLACE = r_TOTAL_PLACE;
	}

	public String getR_RDATE() {
		return R_RDATE;
	}

	public void setR_RDATE(String r_RDATE) {
		R_RDATE = r_RDATE;
	}

	public int getR_STATE() {
		return R_STATE;
	}

	public void setR_STATE(int r_STATE) {
		R_STATE = r_STATE;
	}

	
	@Override
	public String toString() {
		return "airResDto [R_NUM=" + R_NUM + ", R_ID=" + R_ID + ", R_INFO_NUM=" + R_INFO_NUM + ", R_PACK_NAME="
				+ R_PACK_NAME + ", R_ST_DATE=" + R_ST_DATE + ", R_EN_DATE=" + R_EN_DATE + ", R_PPLE_NUM_ADT="
				+ R_PPLE_NUM_ADT + ", R_PPLE_NUM_CHI=" + R_PPLE_NUM_CHI + ", R_PPLE_NUM_INF=" + R_PPLE_NUM_INF
				+ ", R_PPLE_SEAT=" + R_PPLE_SEAT + ", R_TOTAL_PLACE=" + R_TOTAL_PLACE + ", R_RDATE=" + R_RDATE
				+ ", R_STATE=" + R_STATE + "]";
	}
	   
	   
	   
	   
	   


}
