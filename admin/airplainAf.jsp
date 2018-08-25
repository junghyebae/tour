
<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="admin.AirplainDto"%>
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
<%
//비행기 값 받아오기
String a_name = request.getParameter("a_name");
System.out.println("a_name: " + a_name);

switch (a_name){
case "1":
	a_name ="대한항공";
	System.out.println("a_name: " + a_name);
	break;
case "2":
	a_name ="아시아나항공";
	System.out.println("a_name: " + a_name);
	break;
}
//출발지 값 받아오기
String a_location_s = request.getParameter("a_location_s");
System.out.println("a_location_s: " + a_location_s);

switch (a_location_s) {
case "1": 
	a_location_s = "서울(인천/김포)";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "2": 
	a_location_s = "인천";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "3": 
	a_location_s = "김포";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "4": 
	a_location_s = "부산";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "5": 
	a_location_s = "제주";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "6": 
	a_location_s = "광주";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "7": 
	a_location_s = "대구";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "8": 
	a_location_s = "청주";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "9": 
	a_location_s = "무안";
	System.out.println("a_location_s: " + a_location_s);
	break;
case "10": 
	a_location_s = "양양";
	System.out.println("a_location_s: " + a_location_s);
	break;
};
//도착지 설정
String a_location_e[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };

//출발시간
Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
int month = (cal.get(Calendar.MONTH)+2);
int day = cal.get(Calendar.DATE);

//도착시간(월,일)
int arrivemonth = cal.get(Calendar.MONTH)+2; //현재시각기준 1달뒤 
int arriveday = cal.get(Calendar.DATE)+2; //현재시각기준 2일뒤

if(arriveday==31){
	arriveday=1;
	arrivemonth++;
}
else if(arriveday==32){
	arriveday=2;
	arrivemonth++;
}
else if(arriveday>=33){
	arriveday=3;
	arrivemonth++;
}

%>
<%!
//1->01
public String two(String msg){
	return msg.trim().length()<2 ? "0"+msg : msg.trim();
}

%>
<%
//년도,월,일 정보 합치기
String date_s = (year+"")+two(month+"")+two(day+""); //출발시간
String date_e = (year+"")+two(arrivemonth+"")+two(arriveday+"");
%>
<%
//가격
int price = Integer.parseInt(request.getParameter("price"));
//추가하기
IAirplainDao dao = AirplainDao.getInstance();
boolean isS = false;

for(int i=0; i<a_location_e.length; i++){
	//기본시간 설정
	//int resultTime_s = 1000; //10:00로 설정
	//int resultTime_e = 1100; //11:00로 설정
	
	int setmin = (i*20)%60;
	int sethour = 100*((i*20)/60);
	//시간계산하기(출발시간)
	String resultTime_s = date_s+(1000+sethour+setmin);
	String resultTime_e = date_e+(1100+sethour+setmin);
	
	AirplainDto dto = new AirplainDto(
			0,//번호
			a_name, //비행기이름
			50,50,50, //좌석1,2,3
			a_location_s, //출발지
			a_location_e[i], //도착지			
			resultTime_s,//출발시간
			resultTime_e,//도착시간
			(price*100000)+(i*3000)+((i+3)*8000)//가격
			);
	
	
	//DB에 추가하기
	isS = dao.addAirplain(dto);
	
}
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