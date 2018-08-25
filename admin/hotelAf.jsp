<%@page import="admin.HotelDto"%>
<%@page import="admin.HotelDao"%>
<%@page import="admin.IHotelDao"%>
<%@page import="org.apache.coyote.http11.upgrade.InternalHttpUpgradeHandler"%>
<%@page import="com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
request.getParameter("utf-8");
%>
<%
//값받아오기
String h_name = request.getParameter("h_name");
String h_check_in = request.getParameter("h_check_in");
String h_check_out = request.getParameter("h_check_out");
int h_price = Integer.parseInt(request.getParameter("h_price"));
int h_room = Integer.parseInt(request.getParameter("h_room"));

String h_locationList[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };
%>
<%!
//날짜 차이구하기
public String doDiffOfDate(String sdate, String edate){

         String result = "";
         
          try {
              SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
              Date beginDate = formatter.parse(sdate);
              Date endDate = formatter.parse(edate);
               
              // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
              long diff = endDate.getTime() - beginDate.getTime();
              long diffDays = diff / (24 * 60 * 60 * 1000);       
                 System.out.println("날짜차이=" + diffDays);
              
              result = String.valueOf(diffDays);              
                 System.out.println("result:" + result);
               
          } catch (ParseException | java.text.ParseException e) {
              // e.printStackTrace();
          }
          return result;
      }
%>

<%
//날짜차이계산
int result = Integer.parseInt(doDiffOfDate(h_check_in,h_check_out));
if(result ==0){
	result = 1;
}
//db에 넣기
IHotelDao dao = HotelDao.getInstance();
boolean isS = false;
for(int i=0; i<h_locationList.length;i++){
String h_location = h_locationList[i];
HotelDto dto = new HotelDto(
		0,
		h_name,
		h_check_in,
		h_check_out,
		h_location,
		(h_price * Math.round(result*0.95))+(i*3600),
		h_room
		);
isS = dao.addHotel(dto);
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