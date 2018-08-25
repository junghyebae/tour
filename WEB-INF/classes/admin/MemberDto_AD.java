package admin;

import java.io.Serializable;

public class MemberDto_AD implements Serializable {
	
/*	-- 회원 정보 테이블
CREATE TABLE AIR_MEMBER(
    ID VARCHAR2(20) PRIMARY KEY,
    PWD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(20) UNIQUE,
    BIRTH VARCHAR2(20) NOT NULL,
    GRADE NUMBER(10) NOT NULL,
    AUTH NUMBER(2) NOT NULL,
    DEL NUMBER(2) NOT NULL,
    M_NUM NUMBER(20) NOT NULL,
    CONSTRAINT CHK_AUTH CHECK(AUTH >= 0 AND AUTH < 2),
    CONSTRAINT CHK_DEL CHECK(DEL >= 0 AND DEL < 2)
);
-- 가입순서 시퀀스
CREATE SEQUENCE SEQ_M_NUM
START WITH 1 INCREMENT BY 1;
*/
	
	private String id;
	private String pwd;
	private String name;
	private String phone;
	private String email;
	private String birth;
	private int grade;
	private int auth;
	private int del;
	private int seq;
	
	
	public MemberDto_AD(String id, String pwd, String name, String phone, String email, String birth, int grade, int auth,
			int del, int seq) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.birth = birth;
		this.grade = grade;
		this.auth = auth;
		this.del = del;
		this.seq = seq;
	}


	public MemberDto_AD(String id, String pwd, String name, String phone, String email, String birth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.birth = birth;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getBirth() {
		return birth;
	}


	public void setBirth(String birth) {
		this.birth = birth;
	}


	public int getGrade() {
		return grade;
	}


	public void setGrade(int grade) {
		this.grade = grade;
	}


	public int getAuth() {
		return auth;
	}


	public void setAuth(int auth) {
		this.auth = auth;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	@Override
	public String toString() {
		return "mem [id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", birth=" + birth + ", grade=" + grade + ", auth=" + auth + ", del=" + del + "]";
	}
}
