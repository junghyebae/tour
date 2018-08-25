<%@page import="admin.HotelDto"%>
<%@page import="admin.HotelDao"%>
<%@page import="admin.IHotelDao"%>
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
<!-- 값받아오기 -->
<%
String h_name = request.getParameter("h_name");
String h_check_in = request.getParameter("h_check_in");
String h_check_out = request.getParameter("h_check_out");
int location = Integer.parseInt(request.getParameter("h_location"));
int h_price = Integer.parseInt(request.getParameter("h_price"));
int h_room = Integer.parseInt(request.getParameter("h_room"));
//System.out.println("h_name="+h_name);
//System.out.println("h_check_in="+h_check_in);
//System.out.println("h_check_out="+h_check_out);
//System.out.println("h_location="+h_location);
//System.out.println(h_price);
//System.out.println(h_room);
String h_locationList[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };
String h_location = h_locationList[location];
System.out.println("h_location="+h_location);
%>

<!-- DB처리 -->
<%
IHotelDao dao = HotelDao.getInstance();
HotelDto dto = new HotelDto(
		0,//number
		h_name,
		h_check_in,
		h_check_out,
		h_location,
		h_price,
		h_room
		);
boolean isS = dao.addHotel(dto);

if(isS){
	%>
	<script type="text/javascript">
	alert("추가 성공!");
	location.href ="index.jsp?showPage=admin";
	</script>
	<%
}
else{
	%>
	<script type="text/javascript">
	alert("추가 실패...");
	location.href ="index.jsp?showPage=admin";
	</script>
	<%
}
%>
</body>
</html>