<%@page import="hotelRes.hotelResDto"%>
<%@page import="hotelRes.hotelResDao"%>
<%@page import="hotelRes.IhotelResDao"%>
<%@page import="hotel.HotelDto"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
.table1 td, th{
	width: 365px;
    margin-top: 104px;
    border-bottom: 1px solid lightgray;
	padding-bottom: 10px;	
}
.div1{
	padding-top: 98px;
}
</style>

</head>
<body>

<%
int seq = Integer.parseInt(request.getParameter("seq"));
int room = Integer.parseInt(request.getParameter("room"));
int price = Integer.parseInt(request.getParameter("price"));
String email = request.getParameter("email");
String email_addr = request.getParameter("email_addr");

// 호텔 정보 가져오기
IHotelDao dao1 = HotelDao.getInstance();
HotelDto hotel = dao1.getHotelDetail(seq);

// 예약테이블에 올리기
IhotelResDao dao2 = hotelResDao.getInstance(); 
//boolean isS1 = dao2.addHotelRes(new hotelResDto(seq, "NonMember", hotel.getName(), hotel.getCheckIn(), hotel.getCheckOut(), price, room, hotel.getLocation(), email));
int seq1 = dao2.addHotelRes(new hotelResDto(seq, "NonMember", hotel.getName(), hotel.getCheckIn(), hotel.getCheckOut(), price, room, hotel.getLocation(), email+email_addr));

// 호텔 객실수 줄이기
boolean isS2 = dao1.hotelReserved(seq, room);

System.out.println(isS2);

if(isS2 && seq1 != 0){
%>
<div class="div1">
<table align="center" class="table1">
	<tr>
		<td align="center" style="height: 60px;"><font size="5"><b><%=hotel.getName() %></b></font></td>
	</tr>
	<tr>
		<td> <b>체크인/아웃:</b> <%=hotel.getCheckIn() + " ~ " + hotel.getCheckOut() %> </td>
	</tr>
	<tr>
		<td> <b>객실수:</b> <%=room %>개</td>
	</tr>
	<tr>
		<td> <b>가격:</b> <p id="price" style="display: inline;"></p>원</td>
	</tr>
	<tr>
		<td> <b>예약번호:</b> <%=seq1 %> </td>
	</tr>
	<tr>
		<td>예약되었습니다.</td>
	</tr>
	<tr>
		<td align="center">
			<button type="button" onclick="location.href='../main/index.jsp'">메인으로</button>
			<button type="button" onclick="location.href='../main/index.jsp?showPage=hotel'">검색페이지로</button>
		</td>
	</tr>
</table>
<%
}else{ 
%>
<table frame="border" align="center">
<tr>
	<td>
		예약실패
	</td>
</tr>
<tr>
	<td>
		<button type="button" onclick="location.href='../main/index.jsp'">메인으로</button>
		<button type="button" onclick="location.href='../main/index.jsp?showPage=hotel'">검색페이지로</button>
	</td>
</tr>
</table>
<%} %>
</div>


<script type="text/javascript">
// price
$("#price").text(numberWithCommas(<%out.print(price); %>));
//콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

</body>
</html>