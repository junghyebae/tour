package bbs_QNA;

import java.io.Serializable;

/*	CREATE TABLE BBS_QNA(
SEQ NUMBER(10) PRIMARY KEY,
ID VARCHAR2(20) NOT NULL,
TITLE VARCHAR2(200) NOT NULL,
CONTENT VARCHAR2(4000) NOT NULL,
READCOUNT NUMBER(10) NOT NULL,
	    
CONSTRAINT FK_BBSQNA_ID FOREIGN KEY(ID) REFERENCES AIR_MEMBER(ID)
);
CREATE SEQUENCE SEQ_QNA
START WITH 1 INCREMENT BY 1 ;

alter table BBS_QNA
add QGROUP NUMBER(10) NOT NULL;
*/
public class BbsDto_QNA implements Serializable{
	private int seq;
	private String id;
	private String title;
	private String content;
	private int readcount;
	private int qgroup;
	public BbsDto_QNA(int seq, String id, String title, String content, int readcount, int qgroup) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.qgroup = qgroup;
	}
	public BbsDto_QNA(String id, String title, String content, int qgroup) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.qgroup = qgroup;
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
	public int getQgroup() {
		return qgroup;
	}
	public void setQgroup(int qgroup) {
		this.qgroup = qgroup;
	}
	@Override
	public String toString() {
		return "BbsDto_QNA [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", readcount="
				+ readcount + ", qgroup=" + qgroup + "]";
	}
	
	

	
	
	
	
	

}
