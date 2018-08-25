<%@page import="mem.MemberDto"%>
<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%!
public String two(String str){
	return str.trim().length()<2?"0"+str:str.trim();
}
%>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String name = request.getParameter("name");
String phone1 = request.getParameter("phone1");
String phone2 = request.getParameter("phone2");
String phone3 = request.getParameter("phone3");
String email = request.getParameter("email");
String email_ad = request.getParameter("email_ad");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String birth = year + "/" + two(month) + "/" + two(day);

IMemberDao dao = MemberDao.getInstance(); 
boolean isS = dao.updateMember(id, new MemberDto(id, pwd, name, phone1 + "-" + phone2 + "-" + phone3, email+"@"+email_ad, birth));
if(isS){	// DB에 잘 들어갔을 때
	
	// 수정된 정보 session에 다시 저장
	MemberDto dto = dao.login(id, pwd);
	session.setAttribute("login", dto);
	session.setMaxInactiveInterval(30 * 60);
	
	%>
	<script type="text/javascript">
	alert("수정이 완료되었습니다.");
	location.href = '../main/index.jsp?showPage=mypage_';
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("수정에 실패했습니다.");
	location.href = '../main/index.jsp?showPage=mypageUpdate';
	</script>
	<%
}
%>

</body>
</html>