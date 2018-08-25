package admin;

import java.util.List;

import paging.PagingBean;

public interface IMemberDao_AD {

	// 회원정보 가져오기
	public List<MemberDto_AD> getMemberList();
	public List<MemberDto_AD> getMemberListPaging(PagingBean paging);
	
	// 회원정보 수정
	public boolean updateMember(MemberDto_AD dto);
	
	// 회원삭제
	public boolean delId(String id);
	
	//아이디로 해당 정보 가져오기
	public MemberDto_AD getMember(String id);
	
	//회원 등급포인트 상승
	public boolean addGrade(int people, String id);
}
