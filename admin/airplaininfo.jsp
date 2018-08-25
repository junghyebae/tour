<%@page import="admin.AirplainDto"%>
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
request.setCharacterEncoding("utf-8");
%>
<!-- 비행기정보 가져오기 -->
<%
if(request.getParameter("t1").equals("airplain")){
	%>
	<h2 align="center">비행기 상세 정보</h2>
	<%
	int a_num = Integer.parseInt(request.getParameter("t2"));
	IAirplainDao airDao = AirplainDao.getInstance();
	AirplainDto airDto = airDao.airplainDetail(a_num);
	%>
	<hr>
	<table border="1" align="center">
	<col width="150"><col width="200">
	<!-- 비행기번호 -->
	<tr>
		<th>비행기번호</th> 
		<th><%=airDto.getA_num()%></th>
	</tr>
	<!-- 종류 -->
	<tr>
		<th>비행기종류</th> 
		<th><%=airDto.getA_name()%></th>
	</tr>
	<!-- 남은좌석(one/two/three) -->
	<tr>
		<th>남은좌석</th> 
		<th>
		<%=airDto.getA_seat_one()%>/<%=airDto.getA_seat_two()%>/<%=airDto.getA_seat_three()%>
		</th>
	</tr>
	<!-- 출발지 -->
	<tr>
		<th>출발지</th> 
		<th><%=airDto.getA_location_s()%></th>
	</tr>
	<!-- 도착지 -->
	<tr>
		<th>도착지</th> 
		<th><%=airDto.getA_location_e()%></th>
	</tr>
	<!-- 출발시간 -->
	<tr>
		<th>출발시간</th>  
		<th>
		<%=airDto.getA_time_s().substring(0, 4)%>/
		<%=airDto.getA_time_s().substring(4, 6)%>/
		<%=airDto.getA_time_s().substring(6, 8)%>/
		<%=airDto.getA_time_s().substring(8, 10)%>:
		<%=airDto.getA_time_s().substring(10, 12)%>
		</th>
	</tr>
	<!-- 도착시간 -->
	<tr>
		<th>도착시간</th>
		<th>
		<%=airDto.getA_time_e().substring(0, 4)%>/
		<%=airDto.getA_time_e().substring(4, 6)%>/
		<%=airDto.getA_time_e().substring(6, 8)%>/
		<%=airDto.getA_time_e().substring(8, 10)%>:
		<%=airDto.getA_time_e().substring(10, 12)%>
		</th>
	</tr>
	<!-- 가격 -->
	<tr>
		
		<th>가격</th>
		<th><%=airDto.getA_price()%>원</th>
	</tr>
	</table>
	<hr>
	<%

}
%>
</body>
</html>