<%@page import="admin.HotelDao"%>
<%@page import="admin.IHotelDao"%>
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
String sh_num = request.getParameter("h_num");
System.out.println("sh_num = "+sh_num);
int h_num = Integer.parseInt(sh_num);

IHotelDao dao = HotelDao.getInstance();

boolean isS = dao.removeHotel(h_num);
if(isS){
	%>
	<script type="text/javascript">
	alert("삭제성공!");
	location.href = "index.jsp?showPage=admin_hotelList";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제실패..");
	location.href = "index.jsp?showPage=admin_hotelList";
	</script>
	<%
}

%>
</body>
</html>