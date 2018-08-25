<%@page import="admin.MemberDao_AD"%>
<%@page import="admin.IMemberDao_AD"%>
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

IMemberDao_AD dao = MemberDao_AD.getInstance();
boolean isS = dao.delId(id);
System.out.println("삭제" + isS);
if(isS){
	%>
	<script type="text/javascript">
	alert("삭제완료");
	location.href="../main/index.jsp?showPage=admin_memberList";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제실패");
	location.href="../main/index.jsp?showPage=admin_memberList";
	</script>
	<%
}
%>


</body>
</html>