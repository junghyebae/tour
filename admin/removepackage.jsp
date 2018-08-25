<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
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
%>
<%
//값받아오기
String sp_num = request.getParameter("p_num");
System.out.println("sp_num = "+sp_num);
int p_num = Integer.parseInt(sp_num);

IPackageDao dao = PackageDao.getInstance();

boolean isS = dao.removePackage(p_num);
if(isS){
	%>
	<script type="text/javascript">
	alert("삭제성공!");
	location.href = "index.jsp?showPage=admin_packageList";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제실패..");
	location.href = "index.jsp?showPage=admin_packageList";
	</script>
	<%
}

%>
</body>
</html>