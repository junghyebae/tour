<%@page import="admin.MemberDto_AD"%>
<%@page import="admin.MemberDao_AD"%>
<%@page import="admin.IMemberDao_AD"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>updateMem.jsp</title>
</head>
<body>

<%
int num = Integer.parseInt(request.getParameter("num"));
String id = request.getParameter("id" + num);
String pwd = request.getParameter("pwd" + num);
String name = request.getParameter("name" + num);
String phone = request.getParameter("phone" + num);
String email = request.getParameter("email" + num);
String birth = request.getParameter("birth" + num);
int grade = Integer.parseInt(request.getParameter("grade" + num));

System.out.println(id+ pwd + name + phone+email+birth+grade );

IMemberDao_AD dao = MemberDao_AD.getInstance();
boolean isS = dao.updateMember(new MemberDto_AD(id, pwd, name, phone, email, birth, grade, 0, 0, 0));
System.out.println(isS);
if(isS){
	%>
	<script type="text/javascript">
	alert("수정완료");
	location.href="../main/index.jsp?showPage=admin_memberList";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("수정실패");
	location.href="../main/index.jsp?showPage=admin_memberList";
	</script>
	<%
}
%>

</body>
</html>