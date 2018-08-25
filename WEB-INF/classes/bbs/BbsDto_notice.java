package bbs;

import java.io.Serializable;

/*
 CREATE TABLE BBS_NOTICE(
	    SEQ NUMBER(10) PRIMARY KEY,
	    ID VARCHAR2(20) NOT NULL,
	    TITLE VARCHAR2(200) NOT NULL,
	    CONTENT VARCHAR2(4000) NOT NULL,
	    READCOUNT NUMBER(10) NOT NULL,
	    
	    CONSTRAINT FK_BBSNOTICE_ID FOREIGN KEY(ID) REFERENCES AIR_MEMBER(ID)
);
alter table BBS_NOTICE
add  WDATE DATE NOT NULL 

CREATE SEQUENCE SEQ_NOTICE
START WITH 1 INCREMENT BY 1 ;;

*/


public class BbsDto_notice implements Serializable {

	private int seq;
	private String id;
	private String title;
	private String content;
	private int readcount;
	private String wdate;

	
	public BbsDto_notice() {}
	
	

	public BbsDto_notice(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
	}



	public BbsDto_notice(int seq, String id, String title, String content, int readcount, String wdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.wdate = wdate;
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



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public int getReadcount() {
		return readcount;
	}



	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}



	public String getWdate() {
		return wdate;
	}



	public void setWdate(String wdate) {
		this.wdate = wdate;
	}



	@Override
	public String toString() {
		return "BbsDto_notice [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", readcount="
				+ readcount + ", wdate=" + wdate + "]";
	}



	
	
	
}
