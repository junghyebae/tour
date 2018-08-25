<%@page import="airRes.airResDto"%>
<%@page import="airRes.airResDao"%>
<%@page import="airRes.iairResDao"%>
<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
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
// 예약번호 받기
int seq = Integer.parseInt(request.getParameter("seq"));

// 예약정보 dto불러오기
iairResDao dao1 = airResDao.getInstance();
airResDto dto = dao1.getAirRes(seq);
// System.out.println(dto.toString());

// 예약정보 dto에서 좌석수 구하기
int seatNum = dto.getR_PPLE_NUM_ADT() + dto.getR_PPLE_NUM_CHI() + dto.getR_PPLE_NUM_INF();

// 1. 예약테이블에서 삭제
boolean isS1 = dao1.cancelARes(seq);

// 2. 주문이 승인된 경우 회원등급 좌석수만큼 down
if(dto.getR_STATE() == 2){
	IMemberDao dao2 = MemberDao.getInstance();  
	boolean isS2 = dao2.minusGrade(dto.getR_ID(), seatNum);
// System.out.println(isS2);
}

// 3. 좌석수 ++
boolean isS3 = dao1.addAirSeat(dto.getR_INFO_NUM(), seatNum, dto.getR_PPLE_SEAT());

// System.out.println(isS1 + ";" + isS3);

if(isS1 && isS3){	
	%>
<script type="text/javascript">
alert("예약이 취소되었습니다.");
location.href="../main/index.jsp?showPage=reserveCk";
</script>
<%}else{
	%>
<script type="text/javascript">
alert("예약취소실패");
location.href="../main/index.jsp?showPage=reserveCk";
</script>
	<%}
%>

</body>
</html>












