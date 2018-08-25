<%@page import="admin.ReserveDto"%>
<%@page import="admin.ReserveDao"%>
<%@page import="admin.IReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">


</style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
%>
<%
String ttype = request.getParameter("ttype");
int typenum = Integer.parseInt(request.getParameter("typenum"));
%>
<%
IReserveDao dao = ReserveDao.getInstance();
ReserveDto dto = dao.getreserve(typenum);


if(ttype.equals("detail") && dto !=null){
	%>
	<h2  align="center">상세 정보</h2>
	<hr>
	<table border="1" align="center">
	<col width="150"><col width="250">
	<tr>
		<th>주문자</th>
		<th><%=dto.getR_id()%></th>
	</tr>
	<tr>
		<th>출발일자</th>
		<th>
		<%=dto.getR_st_date().substring(0, 4)%>/
		<%=dto.getR_st_date().substring(4, 6)%>/
		<%=dto.getR_st_date().substring(6, 8)%>/
		<%=dto.getR_st_date().substring(8, 10)%>:
		<%=dto.getR_st_date().substring(10, 12)%>
		</th>
	</tr>
	<tr>
		<th>도착일자</th>
		<th>
		<%=dto.getR_en_date().substring(0, 4)%>/
		<%=dto.getR_en_date().substring(4, 6)%>/
		<%=dto.getR_en_date().substring(6, 8)%>/
		<%=dto.getR_en_date().substring(8, 10)%>:
		<%=dto.getR_en_date().substring(10, 12)%>
		</th>
	</tr>
	<tr>
		<th>성인</th>
		<th><%=dto.getR_pple_num_adt()%>명</th>
	</tr>
	<tr>
		<th>아동</th>
		<th><%=dto.getR_pple_num_chi()%>명</th>
	</tr>
	<tr>
		<th>유아</th>
		<th><%=dto.getR_pple_num_inf()%>명</th>
	</tr>
	<tr>
		<th>좌석</th>
		<th><%=dto.getR_pple_seat()%></th>
	</tr>
	<tr>
		<th>총가격</th>
		<th><%=dto.getR_total_place()%>원</th>
	</tr>
	</table>
	<%
}
%>
</body>
</html>