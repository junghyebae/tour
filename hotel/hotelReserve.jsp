<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@page import="hotel.HotelDto"%>
<%@page import="hotelRes.hotelResDto"%>
<%@page import="hotelRes.hotelResDao"%>
<%@page import="hotelRes.IhotelResDao"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>hotelReserve.jsp</title>

<style type="text/css">
.table1{
   width: 365px;
    margin-top: 104px;
}
.table1 th, td{
   border-bottom: 1px solid lightgray;
   padding-bottom: 10px;
   padding-top: 10px;
}
</style>

</head>
<body>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");

int seq = Integer.parseInt(request.getParameter("seq"));
int room = Integer.parseInt(request.getParameter("room"));
int price = Integer.parseInt(request.getParameter("price"));

// System.out.println(price);

// 호텔정보 가져오기
IHotelDao dao1 = HotelDao.getInstance();
HotelDto hotel = dao1.getHotelDetail(seq);
boolean isS1;

// 예약테이블에 올리기
IhotelResDao dao2 = hotelResDao.getInstance();
int seq1 = dao2.addHotelRes(new hotelResDto(seq, mem.getId(), hotel.getName(), hotel.getCheckIn(), hotel.getCheckOut(), price, room, hotel.getLocation(), mem.getEmail()));

// memberdao 가져오기
IMemberDao dao3 = MemberDao.getInstance();
boolean isS3;

if(seq1 != 0){
   
   // 호텔 객실수 줄여주기
   isS1 = dao1.hotelReserved(seq, room);
   // 회원 등급 올리기
   isS3 = dao3.plusGrade(mem.getId(), room);

   if(isS1 && isS3){
%>
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
      <td> 예약되었습니다.   </td>
   </tr>
   <tr>
      <td align="center">
         <button type="button" onclick="location.href='../main/index.jsp'">메인으로</button>
         <button type="button" onclick="location.href='../main/index.jsp?showPage=hotel'">검색페이지로</button>
      </td>
   </tr>
</table>
<%
   }
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

