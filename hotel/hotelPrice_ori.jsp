<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Currency"%>

<%
int room = Integer.parseInt(request.getParameter("room"));
int price_ori = Integer.parseInt(request.getParameter("price"));

//원화 표시 얻어오는 부분 (Currency라는 java util 소속에 class부분에서 getSymbol를 통해 나라별 화폐 단위를 얻어올 수 있음)
String won = Currency.getInstance(Locale.KOREA).getSymbol();

//원화표시와 가격에 , 를 찍어주는 부분(String format에 %d를 사용할 경우 int형 데이터가 들어가야 하므로 사용 시 주의할 것 / price 부분에 String을 넣으면 Exception 발생함)
String temp_won = String.format(won+"%,d", room*price_ori);
System.out.println("temp_won: " + temp_won);

out.print(temp_won);
%>
