<%@page import="admin.HotelDto"%>
<%@page import="java.util.List"%>
<%@page import="admin.HotelDao"%>
<%@page import="admin.IHotelDao"%>
<%@page import="paging.PagingBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center" >호텔 정보 리스트</h1>

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
//리스트 가져오기
IHotelDao dao = HotelDao.getInstance();
List<HotelDto> holist = dao.hotelList(paging);
%>
<!-- 테이블생성 -->
<div align="center">
<form action="index.jsp">
<table border="1" cellpadding="8px">
<col width="50"><col width="200"><col width="150"><col width="150">
<col width="150"><col width="200"><col width="50"><col width="50">
<thead>
	<tr>
		<th>번호</th>
		<th>호텔이름</th>
		<th>체크인</th>
		<th>체크아웃</th>
		<th>지역</th>
		<th>가격</th>
		<th>남은룸수</th>
		<th>삭제</th>
	</tr>
</thead>
<tbody>
<%
if(holist ==null || holist.size()==0){
	%>
	<tr>
		<td colspan="8" align="center"> 데이터가 없습니다.</td>
	</tr>
	<%
}
for(int i=0; i<holist.size();i++){
	HotelDto dto = holist.get(i);
	%>
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
		<!-- 2.호텔이름 -->
		<td><%=dto.getName()%></td>
		<!-- 3.체크인 -->
		<td><%=dto.getCheckIn()%></td>
		<!-- 4.체크아웃 -->
		<td><%=dto.getCheckOut()%></td>
		<!-- 5.지역 -->
		<td><%=dto.getLocation()%></td>
		<!-- 6.가격 -->
		<td><%=dto.getPrice()%>원</td>
		<!-- 7.남은룸수 -->
		<td><%=dto.getRoom()%></td>
		<!-- 8.삭제 -->
		<td>
			<input type="hidden" name="showPage" value="removeHotel">
			<input type="hidden" name="h_num" value="<%=dto.gethNum()%>">
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
	<jsp:param value="hotel" name="listType"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>
</body>
</html>