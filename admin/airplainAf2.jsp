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
<%!
//1->01 함수
public String two(String msg){
	return msg.trim().length()<2 ? "0"+msg : msg.trim();
}
%>
<%
//값 받아오기//
//a_name
String a_name= request.getParameter("a_name");
if(a_name.equals("1")){
	a_name = "대한항공";
}
else{
	a_name = "아시아나항공";
}
//좌석수
int a_seat_one = Integer.parseInt(request.getParameter("a_seat_one"));
int a_seat_two = Integer.parseInt(request.getParameter("a_seat_two"));
int a_seat_three = Integer.parseInt(request.getParameter("a_seat_three"));

//출발지역
int location_s = Integer.parseInt(request.getParameter("a_location_s"));
String a_location_sList[] = {"서울(인천/김포)","인천","김포","부산",
		"제주","광주","대구","청주","무안","양양"};
String a_location_s = a_location_sList[location_s-1];

//도착지역
int location_e = Integer.parseInt(request.getParameter("a_location_e"));
String a_location_eList[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };
String a_location_e = a_location_eList[location_e];

//출발시간
String a_time_s1 = request.getParameter("a_time_s1").replace("-", "");
String a_time_s2 = two(request.getParameter("a_time_s2"));//시
String a_time_s3 = two(request.getParameter("a_time_s3"));//분
String a_time_s = a_time_s1+a_time_s2+a_time_s3;
System.out.println("a_time_s ="+a_time_s);

//도착시간
String a_time_e1 = request.getParameter("a_time_e1").replace("-", "");
String a_time_e2 = two(request.getParameter("a_time_e2"));//시
String a_time_e3 = two(request.getParameter("a_time_e3"));//분
String a_time_e = a_time_e1+a_time_e2+a_time_e3;
System.out.println("a_time_e ="+a_time_e);

//가격
int a_price = Integer.parseInt(request.getParameter("a_price"));
%>

<%
IAirplainDao dao = AirplainDao.getInstance();
AirplainDto dto = new AirplainDto(
		0,//번호
		a_name, //비행기이름
		a_seat_one,a_seat_two,a_seat_three, //좌석1,2,3
		a_location_s, //출발지
		a_location_e, //도착지			
		a_time_s,//출발시간
		a_time_e,//도착시간
		a_price//가격
		);
boolean isS = dao.addAirplain(dto);

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










