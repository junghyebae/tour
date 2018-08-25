<%@page import="java.util.Locale"%>
<%@page import="java.util.Currency"%>
<%@page import="mem.MemberDto"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.PackageDto"%>
<%@page import="admin.IPackageDao"%>
<%@page import="main.BookingDto"%>
<%@page import="main.BookingDao"%>
<%@page import="main.IBookingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
--%>
<%@ page import="java.*" %>    

<%

//로그인정보가져오기
MemberDto dto = null;
dto = (MemberDto)session.getAttribute("login");

if(dto == null){
	dto = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
			
}

String sDate = request.getParameter("Sdate");
String eDate = request.getParameter("Edate");
String eLocation = request.getParameter("eLocation");
String product = request.getParameter("product");

IBookingDao dao = BookingDao.getInstance();
dao.readcountIncrement(product);

String adt = request.getParameter("adt_num");
String chi = request.getParameter("chi_num");
String inf = request.getParameter("inf_num");

String seat_select = request.getParameter("seat");
System.out.println("seat_select: " + seat_select);

if(seat_select == null){
	seat_select = "일반석";
}

System.out.println("adt: " + adt);
System.out.println("chi: " + chi);
System.out.println("inf: " + inf);

if(adt == null){
	adt = "1";
}

if(chi == null){
	chi = "0";
}


if(inf == null){
	inf = "0";
}

System.out.println("adt: " + adt);
System.out.println("chi: " + chi);
System.out.println("inf: " + inf);


// eLocation: 서울(인천/김포)->싱가포르(11:00/11:00)
// 도착지 도시 구하기
String select_location = "";
int idx = eLocation.indexOf(">");

String temp_select = eLocation.substring(idx+1);
// ex) temp_select: 방콕(10:00/10:00)

idx = temp_select.indexOf("(");
select_location = temp_select.substring(0, idx);
// ex) select_location: 방콕


// 출발지 구하기
int sLoIdx = eLocation.indexOf("-");
eLocation = eLocation.substring(0, sLoIdx);


// 비행기 가격 얻어오는 부분
IBookingDao bdao = BookingDao.getInstance();
BookingDto bdto = bdao.getAirPrice(sDate, eDate, eLocation, select_location);


// 상품 가격 얻어오는 부분
IPackageDao pdao = PackageDao.getInstance();
PackageDto pdto = pdao.reservePackList(product);

//기존의 bdto의 A_price 부분의 값을 저장하는 변수
int temp_a_price = bdto.getA_price();

System.out.println("temp_a_price: " + temp_a_price);

// 좌석 등급에 따른 가격 조정 부분 
if(seat_select.equals("일등석")){
	bdto.setA_price(bdto.getA_price() + (int)(bdto.getA_price() * 0.5));
	System.out.println("일등석 가격(원래가격: " + temp_a_price + "): " + bdto.getA_price());
}else if(seat_select.equals("비즈니스석")){
	bdto.setA_price(bdto.getA_price() + (int)(bdto.getA_price() * 0.2));
	System.out.println("비즈니스 가격(원래가격: " + temp_a_price + "): " + bdto.getA_price());
}

System.out.println("좌석등급이 지정된 bdto.getA_price(): " + bdto.getA_price());

//인원에 따른 분류 변수 
int adt_num = Integer.parseInt(adt);
int chi_num = Integer.parseInt(chi);
int inf_num = Integer.parseInt(inf);


//인원의 나이에 따른 할인 적용 부분 (adt = 성인은 할인X)
int adt_price = (bdto.getA_price() + (int)pdto.getP_price()) * adt_num;

int chi_price = (bdto.getA_price() + (int)pdto.getP_price()) * chi_num;
	// chi_price = Integer.parseInt(String.valueOf(chi_price * 0.8)); / 이 방법은 NumberFormatException 발생
	chi_price = (int)(chi_price * 0.8);

int inf_price = (bdto.getA_price() + (int)pdto.getP_price()) * inf_num;
	//inf_price = Integer.parseInt(String.valueOf(inf_price * 0.5)); / 이 방법은 NumberFormatException 발생
	inf_price = (int)(inf_price * 0.5);

int price = adt_price + chi_price + inf_price;

//% 계산을 위한 변수
double temp_calc = 0;

System.out.println("dto.getGrade: " + dto.getGrade());

if(dto.getGrade() > 0 && dto.getGrade() <= 10){
	temp_calc = price * 0.05;
	price = price - (int)temp_calc;
}else if(dto.getGrade() > 10 && dto.getGrade() <= 20){
	temp_calc = price * 0.1;	
	price = price - (int)(temp_calc);
}else if(dto.getGrade() > 20 && dto.getGrade() <= 30){
	temp_calc = price * 0.15;	
	price = price - (int)(temp_calc);
}else if(dto.getGrade() > 30 && dto.getGrade() <= 40){
	temp_calc = price * 0.20;	
	price = price - (int)(temp_calc);
}else if(dto.getGrade() > 40 && dto.getGrade() <= 50){
	temp_calc = price * 0.25;	
	price = price - (int)(temp_calc);
}else if(dto.getGrade() > 51){
	temp_calc = price * 0.25;
	price = price - (int)(temp_calc);
}

// 원화 표시 얻어오는 부분 (Currency라는 java util 소속에 class부분에서 getSymbol를 통해 나라별 화폐 단위를 얻어올 수 있음)
String won = Currency.getInstance(Locale.KOREA).getSymbol();

// 원화표시와 가격에 , 를 찍어주는 부분(String format에 %d를 사용할 경우 int형 데이터가 들어가야 하므로 사용 시 주의할 것 / price 부분에 String을 넣으면 Exception 발생함)
String temp_won = String.format(won+"%,d", price);
System.out.println("temp_won: " + temp_won);

// 데이터를 넘겨주는 부분
out.print(temp_won);
%>