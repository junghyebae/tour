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

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

IMemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.login(id, pwd);

if(dto != null && !dto.getId().equals("") && dto.getDel() == 0){
	session.setAttribute("login", dto);		// session에 login한 정보저장
	session.setMaxInactiveInterval(30 * 60);
	%>
		<script type="text/javascript">
		alert("안녕하세요 <%=id %>님");
		location.href = "../main/index.jsp";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		alert("아이디나 패스워드를 확인하세요");
		location.href = "../main/index.jsp?showPage=login";
		</script>
	<%
}	
%>

</body>
</html>