<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@page import="mem.MemberDto"%>
<%@page import="hotelRes.hotelResDao"%>
<%@page import="hotelRes.IhotelResDao"%>
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
int seq = Integer.parseInt(request.getParameter("seq"));		// 예약 seq
int Hnum = Integer.parseInt(request.getParameter("Hnum"));		// hotel seq
int room = Integer.parseInt(request.getParameter("room"));		// 객실수

//예약최소할경우
//1. 예약테이블에서 삭제
IhotelResDao dao1 = hotelResDao.getInstance();
boolean isS1 = dao1.cancelHotel(seq);

if(isS1){		// 예약테이블에서 삭제되었을 경우에 아래 메소드 실행	
//2. 호텔테이블 room +
IHotelDao dao2 = HotelDao.getInstance();
boolean isS2 = dao2.hotelCanceled(Hnum, room);

if(isS2){
	%>
<script type="text/javascript">
alert("예약이 취소되었습니다.");
location.href="../main/index.jsp";
</script>
	<%}
}else{
	%>
<script type="text/javascript">
alert("예약취소실패");
location.href="../main/index.jsp";
</script>
	<%}
%>

</body>
</html>

</body>
</html>