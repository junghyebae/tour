<%@page import="java.util.ArrayList"%>
<%@page import="air.AirPlainDAO"%>
<%@page import="air.IAirPlainDAO"%>
<%@page import="air.AirPlainDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="air.PagingBean"%>
<%@page import="air.IAirProductDAO"%>
<%@page import="air.AirProudctDAO"%>
<%@page import="air.AirProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AirListSh.jsp</title>
</head>
<body>
<h5>AirListSh.jsp</h5>
<%
	// AirList.jsp 상세검색조건
	String _start_date = request.getParameter("start_date");	
	String _arrive_date = request.getParameter("arrive_date");	
	String _seat_count = request.getParameter("seat_count");	
	String _air_seat = request.getParameter("Air_seat");		
	
	String air_name = request.getParameter("air_name");		// 비행기이름
	Long start_date = Long.parseLong(_start_date);			// 출발날
	Long arrive_date = Long.parseLong(_arrive_date);		// 도착일
	String start_cnt = request.getParameter("start_cnt");	// 출발국가
	String arrive_cnt = request.getParameter("arrive_cnt");	// 도착국가
	String _seatcount[] = request.getParameterValues("seat_count"); // 몇명인지
	int seat_count = 0;												// 몇명인지
	int air_seat = Integer.parseInt(_air_seat);						// 1:일반 2:비즈니스 3:일등
	
	for(int i=0; i<_seatcount.length; i++){
		_seatcount[i] = _seatcount[i].toString();
		System.out.println("_seatcount["+ i +"] :" + _seatcount[i]);
		seat_count += Integer.parseInt(_seatcount[i]);
	}
	System.out.println("air_name : " + air_name);
	System.out.println("start_date : " + start_date);
	System.out.println("arrive_date : " + arrive_date);
	System.out.println("start_cnt : " + start_cnt);
	System.out.println("arrive_cnt : " + arrive_cnt);
	System.out.println("seat_count : " + seat_count);
	System.out.println("air_seat : " + air_seat);
%>	
<%
	IAirProductDAO dao = AirProudctDAO.getInstance();
	//비행기정보
	AirPlainDTO airinfoListdto = new AirPlainDTO();
	airinfoListdto.setA_name(air_name);
	airinfoListdto.setA_time_s(start_date);
	airinfoListdto.setA_time_e(arrive_date);
	airinfoListdto.setA_location_s(start_cnt);
	airinfoListdto.setA_location_e(arrive_cnt);
	
	if(air_seat == 1){
		airinfoListdto.setA_seat_one(seat_count);
	}else if(air_seat == 2){
		airinfoListdto.setA_seat_two(seat_count);
	}else {
		airinfoListdto.setA_seat_three(seat_count);
	}
	
//	List<AirProductDTO> list = dao.getSearchProductList(airinfoListdto, air_seat);
//	for(int i=0; i<list.size(); i++){
//		System.out.println("list: " + list.get(i).toString());
//	}
%>

<%-- 
<%
	if(list != null){
%>
	<script type="text/javascript">
		alert("정보가 없습니다.");
		location.href="AirList.jsp?findWord=''";
	</script>
<%
	}else {
%>
	<script type="text/javascript">
		alert("정보가 없습니다.");
		location.href="AirList.jsp?findWord=''";
	</script>
<%
	}
%> --%>
</body>
</html>











