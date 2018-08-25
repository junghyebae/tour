<%@page import="air.AirReserveDAO"%>
<%@page import="air.IAirReserveDAO"%>
<%@page import="air.AirReserveDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AirReservfinal.jsp</title>
</head>
<body>
<%
		
		// int R_NUM;         : 시퀀스
		String R_ID = request.getParameter("id");    
		int R_INFO_NUM = Integer.parseInt(request.getParameter("a_num"));
		String R_PACK_NAME = request.getParameter("p_name");
		String R_ST_DATE = request.getParameter("a_time_s");  
		String R_EN_DATE = request.getParameter("a_time_e");  
		int R_PPLE_NUM_ADT = Integer.parseInt(request.getParameter("Air_seatCntAdt"));
		int R_PPLE_NUM_CHI = Integer.parseInt(request.getParameter("Air_seatCntChi"));
		int R_PPLE_NUM_INF = Integer.parseInt(request.getParameter("Air_seatCntInf"));
		String R_PPLE_SEAT = request.getParameter("Air_seat");
		int R_TOTAL_PLACE = Integer.parseInt(request.getParameter("finalPrice")); 
		// String R_RDATE  
		// int R_STATE;
		
		AirReserveDTO dto = new AirReserveDTO();
		dto = new AirReserveDTO(R_ID, R_INFO_NUM, R_PACK_NAME, R_ST_DATE, R_EN_DATE, R_PPLE_NUM_ADT, R_PPLE_NUM_CHI, R_PPLE_NUM_INF, R_PPLE_SEAT, R_TOTAL_PLACE);
		
		IAirReserveDAO redao = AirReserveDAO.getInstance();
		boolean b = redao.AirReserve(dto);
		
		if(b == true){
%>
	<script type="text/javascript">
		alert("예약이 완료되었습니다.");
		location.href="../main/index.jsp?showPage=shSimpleAirList";
	</script>
<%
		}else{
%>
	<script type="text/javascript">
		alert("예약이 실패되었습니다.");
		location.href="../main/index.jsp?showPage=AirReserv";
	</script>
<%
		}
%>

</body>
</html>