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
String sa_num = request.getParameter("a_num");
System.out.println("sa_num = "+sa_num);
int a_num = Integer.parseInt(sa_num);

IAirplainDao dao = AirplainDao.getInstance();

boolean isS = dao.removeAirplain(a_num);
if(isS){
	%>
	<script type="text/javascript">
	alert("삭제성공!");
	location.href = "index.jsp?showPage=admin_airplainList";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제실패..");
	location.href = "index.jsp?showPage=admin_airplainList";
	</script>
	<%
}

%>
</body>
</html>