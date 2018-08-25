<%@page import="admin.AirplainDto"%>
<%@page import="java.util.List"%>
<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
<%@page import="paging.PagingBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<h1 align="center">비행기 정보 리스트</h1>

<%
request.setCharacterEncoding("utf-8");
%>

<!-- 페이징 -->
<%
PagingBean paging = new PagingBean(); //페이징dto
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}
else{
	int currentPage = Integer.parseInt(
			request.getParameter("nowPage"));
	paging.setNowPage(currentPage);
}
%>
<%
//리스트가져오기
IAirplainDao dao = AirplainDao.getInstance();
List<AirplainDto> airlist = dao.airplainList(paging);
%>
<%
//검색
%>
<!-- 테이블 생성 -->
<div align="center">
<form action="index.jsp">
<table border="1" cellpadding="8px">
<col width="70"><col width="150"><col width="120">
<col width="120"><col width="120"><col width="150">
<col width="150"><col width="200"><col width="200">
<col width="200"><col width="50">
<!-- header -->
<thead>
	<tr>
		<th>번호</th> 
		<th>비행기종류</th> 
		<th>남은좌석수1</th>
		<th>남은좌석수2</th> 
		<th>남은좌석수3</th> 
		<th>출발지</th>
		<th>도착지</th> 
		<th>출발시간</th>
		<th>도착시간</th>
		<th>가격</th> 
		<th>삭제 </th>
	</tr>
</thead>
<!-- ▽ △ -->
<tbody>
<%
System.out.println("airlist.size() ="+airlist.size());
if(airlist ==null || airlist.size()==0){
	%>
	<tr>
		<td colspan="9" align="center"> 데이터가 없습니다. </td>
	</tr>
	<%
}
//데이터가 존재
for(int i=0; i<airlist.size(); i++){
	AirplainDto dto = airlist.get(i);
	%>
	<!-- 테이블 열생성 -->
	<tr>
		<!-- 1.번호 -->
		<%
		//번호정보
		if(request.getParameter("nowPage")==null){
			int nowPage = 1;
			%>
			<td><%=(i+1)+((nowPage-1)*10)%>번</td>
			<%
		}
		else{
			int nowPage = Integer.parseInt(request.getParameter("nowPage"));
			%>
			<td><%=(i+1)+((nowPage-1)*10)%>번</td>
			<%
		}
		%>
		<!-- 2.비행기종류 -->
		<td><%=dto.getA_name()%></td>
		<!-- 3.남은좌석수1 -->
		<td><%=dto.getA_seat_one()%>석</td>
		<!-- 4.남은좌석수2 -->
		<td><%=dto.getA_seat_two()%>석</td>
		<!-- 5.남은좌석수3 -->
		<td><%=dto.getA_seat_three()%>석</td>
		<!-- 6.출발지 -->
		<td><%=dto.getA_location_s()%></td>
		<!-- 7.출발지 -->
		<td><%=dto.getA_location_e()%></td>
		<!-- 8.출발시간 -->
		<td>
		<%=dto.getA_time_s().substring(0, 4)%>/
		<%=dto.getA_time_s().substring(4, 6)%>/
		<%=dto.getA_time_s().substring(6, 8)%>/
		<%=dto.getA_time_s().substring(8, 10)%>:
		<%=dto.getA_time_s().substring(10, 12)%>
		</td>
		<!-- 9.도착시간 -->
		<td>
		<%=dto.getA_time_e().substring(0, 4)%>/
		<%=dto.getA_time_e().substring(4, 6)%>/
		<%=dto.getA_time_e().substring(6, 8)%>/
		<%=dto.getA_time_e().substring(8, 10)%>:
		<%=dto.getA_time_e().substring(10, 12)%>
		</td>
		<!-- 10.가격 -->
		<td><%=dto.getA_price()%></td>
		<!-- 11.삭제버튼 -->
		<td>			
			<input type="hidden" name="showPage" value="removeAirplain">
			<input type="hidden" name="a_num" value="<%=dto.getA_num()%>">
			<input type="submit" value="삭제">
		</td>
	</tr>
	
	<%
}
%>
</tbody>
</table>
</form>
</div>

<!-- paging Include -->
<div align="center">
<jsp:include page="paging.jsp">
	<jsp:param value="index.jsp" name="actionPath"/>
	<jsp:param value="airplain" name="listType"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>



</body>
</html>










