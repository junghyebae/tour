<%@page import="air.AirPlainDTO"%>
<%@page import="air.AirPlainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String seat = request.getParameter("seat");
	String anum = request.getParameter("anum");
	
	System.out.println("String seat = " + seat);
	System.out.println("String anum = " + anum);
	
	int a_num = Integer.parseInt(anum);
	
	AirPlainDAO dao = AirPlainDAO.getInstance();
	AirPlainDTO dto = dao.getAdto(a_num);
	
	System.out.println("dto: " + dto.toString());
	
	if(seat.equals("일등석")){
		out.println(dto.getA_seat_one());
	}else if(seat.equals("비즈니스석")){
		out.println(dto.getA_seat_two());
	}else if(seat.equals("일반석")){
		out.println(dto.getA_seat_three());
	}
%>