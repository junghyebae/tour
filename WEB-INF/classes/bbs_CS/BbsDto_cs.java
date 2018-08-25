package bbs_CS;

import java.io.Serializable;

/* 
SEQ NUMBER(10) PRIMARY KEY,
ID VARCHAR2(20) NOT NULL,
TITLE VARCHAR2(200) NOT NULL,
CONTENT VARCHAR2(4000) NOT NULL,
WDATE DATE NOT NULL,
REF NUMBER(8) NOT NULL,
STEP NUMBER(8) NOT NULL,
DEPTH NUMBER(8) NOT NULL,
PARENT NUMBER(8) NOT NULL,
DEL NUMBER(1) NOT NULL,
READCOUNT NUMBER(10) NOT NULL,
PROCESS VARCHAR2(100) NOT NULL,
CATEGORY VARCHAR2(100) NOT NULL,
SECRET NUMBER(10),    
CONSTRAINT FK_BBSCS_ID FOREIGN KEY(ID) REFERENCES AIR_MEMBER(ID)

CREATE SEQUENCE SEQ_CS
START WITH 1 INCREMENT BY 1 


alter table bbs_cs
add  
parent_id varchar2(30)
*/
public class BbsDto_cs implements Serializable {
	
	int seq;
	
	String ID;
	String TITLE;
	String CONTENT;
	String WDATE;
	int REF;
	int STEP;
	int DEPTH;
	int PARENT;
	int DEL;
	int READCOUNT;
	String PROCESS;
	String CATEGORY;
	int SECRET;
	String parent_id;
	
	
	public BbsDto_cs(int seq, String iD, String tITLE, String cONTENT, String wDATE, int rEF, int sTEP, int dEPTH,
			int pARENT, int dEL, int rEADCOUNT, String pROCESS, String cATEGORY, int sECRET, String parent_id) {
		super();
		this.seq = seq;
		ID = iD;
		TITLE = tITLE;
		CONTENT = cONTENT;
		WDATE = wDATE;
		REF = rEF;
		STEP = sTEP;
		DEPTH = dEPTH;
		PARENT = pARENT;
		DEL = dEL;
		READCOUNT = rEADCOUNT;
		PROCESS = pROCESS;
		CATEGORY = cATEGORY;
		SECRET = sECRET;
		this.parent_id = parent_id;
	}


	public BbsDto_cs(String iD, String tITLE, String cONTENT, String pROCESS, String cATEGORY, int sECRET,
			String parent_id) {
		super();
		ID = iD;
		TITLE = tITLE;
		CONTENT = cONTENT;
		PROCESS = pROCESS;
		CATEGORY = cATEGORY;
		SECRET = sECRET;
		this.parent_id = parent_id;
	}
	


	public int getSeq() {
		return seq;
	}



	public void setSeq(int seq) {
		this.seq = seq;
	}



	public String getID() {
		return ID;
	}



	public void setID(String iD) {
		ID = iD;
	}



	public String getTITLE() {
		return TITLE;
	}



	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}



	public String getCONTENT() {
		return CONTENT;
	}



	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}



	public String getWDATE() {
		return WDATE;
	}



	public void setWDATE(String wDATE) {
		WDATE = wDATE;
	}



	public int getREF() {
		return REF;
	}



	public void setREF(int rEF) {
		REF = rEF;
	}



	public int getSTEP() {
		return STEP;
	}



	public void setSTEP(int sTEP) {
		STEP = sTEP;
	}



	public int getDEPTH() {
		return DEPTH;
	}



	public void setDEPTH(int dEPTH) {
		DEPTH = dEPTH;
	}



	public int getPARENT() {
		return PARENT;
	}



	public void setPARENT(int pARENT) {
		PARENT = pARENT;
	}



	public int getDEL() {
		return DEL;
	}



	public void setDEL(int dEL) {
		DEL = dEL;
	}



	public int getREADCOUNT() {
		return READCOUNT;
	}



	public void setREADCOUNT(int rEADCOUNT) {
		READCOUNT = rEADCOUNT;
	}



	public String getPROCESS() {
		return PROCESS;
	}



	public void setPROCESS(String pROCESS) {
		PROCESS = pROCESS;
	}



	public String getCATEGORY() {
		return CATEGORY;
	}



	public void setCATEGORY(String cATEGORY) {
		CATEGORY = cATEGORY;
	}



	public int getSECRET() {
		return SECRET;
	}



	public void setSECRET(int sECRET) {
		SECRET = sECRET;
	}



	public String getParent_id() {
		return parent_id;
	}



	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}



	@Override
	public String toString() {
		return "BbsDto_cs [seq=" + seq + ", ID=" + ID + ", TITLE=" + TITLE + ", CONTENT=" + CONTENT + ", WDATE=" + WDATE
				+ ", REF=" + REF + ", STEP=" + STEP + ", DEPTH=" + DEPTH + ", PARENT=" + PARENT + ", DEL=" + DEL
				+ ", READCOUNT=" + READCOUNT + ", PROCESS=" + PROCESS + ", CATEGORY=" + CATEGORY + ", SECRET=" + SECRET
				+ ", parent_id=" + parent_id + "]";
	}
	

	
}
