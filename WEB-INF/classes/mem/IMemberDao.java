package mem;

public interface IMemberDao {

	// 회원가입
	public boolean addMember(MemberDto dto);
	
	// 아이디 중복체크
	public boolean checkId(String id);
	
	// 이메일 중복체크
	public boolean checkEmail(String email);	

	// getGrade
	public int getGrade(String id);
	
	// 로그인
	public MemberDto login(String id, String pwd);
	
	// 회원탈퇴
	public boolean delId(String id);
	
	// id찾기
	public String findId(String email, String phone);
	
	// pwd찾기
	public String findPwd(String id, String email);
	
	// 내정보 수정
	public boolean updateMember(String id, MemberDto dto);
	
	// 회원등급올리기
	public boolean plusGrade(String id, int num);
	
	// 회원등급내리기
	public boolean minusGrade(String id, int num);
	
}
