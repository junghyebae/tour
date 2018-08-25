<%@page import="mem.MemberDto"%>
<%@page import="air.AirPlainDTO"%>
<%@page import="air.AirTotalInfoDTO"%>
<%@page import="air.AirReserveDAO"%>
<%@page import="air.IAirReserveDAO"%>
<%@page import="air.AirReserveDTO"%>
<%@page	import="air.AirProductDTO"%>
<%@page	import="air.AirProudctDAO"%>
<%@page	import="air.IAirProductDAO"%>
<%@	page	language="java"	contentType="text/html;	charset=UTF-8"
				pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
	MemberDto mem = null;
	mem = (MemberDto)ologin;
	
	if(mem == null){
		mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
	}
	
	System.out.println("등급 : " + mem.getGrade());
	/*	
		아이디			:	name	=	id
		비행기번호		:	name	=	a_num
		비행기명		:	name	=	a_name
		상품명			:	name	=	p_name
		출발일			:	name	=	a_time_s
		귀국일			:	name	=	a_time_e
		좌석명			:	name	=	Air_seat
		인원수(성인)	:	name	=	Air_seatCntAdt
		인원수(아동)	:	name	=	Air_seatCntChi
		인원수(유아)	:	name	=	Air_seatCntInf
		총가격			:	name	=	finalPrice
	*/
	/*  private	int R_NUM;
		
		private	String R_ID; 
		private	int R_INFO_NUM; 
		
		private	String R_PACK_NAME;
		
		private	String R_ST_DATE; 
		private	String R_EN_DATE; 
		
		private	int R_PPLE_NUM_ADT; 
		private	int R_PPLE_NUM_CHI; 
		private	int R_PPLE_NUM_INF; 
		private	String R_PPLE_SEAT; 
		private	int R_TOTAL_PLACE; 
		private	String R_RDATE; 
		private	int R_STATE;
	*/
	//String R_ID = request.getParameter("id"); // 아이디
		
	String R_INFO_NUM_  = request.getParameter("a_num"); // 비행기번호
	int R_INFO_NUM = Integer.parseInt(R_INFO_NUM_);
	
	//String R_PACK_NAME = request.getParameter("a_name"); // 비행기이름
	//String R_PACK_NAME = request.getParameter("p_name");
	
	String R_ST_DATE_ = request.getParameter("a_time_s");
	long R_ST_DATE = Long.parseLong(R_ST_DATE_); 
	
	String R_EN_DATE_ = request.getParameter("a_time_e");
	long R_EN_DATE = Long.parseLong(R_EN_DATE_);
	
	// 상품명
	String Pack_pname = request.getParameter("Pack_pname");
	
	
	String R_PPLE_NUM_ADT_ = request.getParameter("Air_seatCntAdt");
	int R_PPLE_NUM_ADT = Integer.parseInt(R_PPLE_NUM_ADT_);
	
	String R_PPLE_NUM_CHI_ = request.getParameter("Air_seatCntChi");
	int R_PPLE_NUM_CHI = Integer.parseInt(R_PPLE_NUM_CHI_);
	
	String R_PPLE_NUM_INF_ = request.getParameter("Air_seatCntInf");
	int R_PPLE_NUM_INF = Integer.parseInt(R_PPLE_NUM_INF_);
	
	String R_PPLE_SEAT = request.getParameter("Air_seat");
	String R_TOTAL_PLACE_ = "";
	
	// 모든정보에대한)
	AirTotalInfoDTO airinfoListdto = new AirTotalInfoDTO();
	
	
	// 상품정보
	AirProductDTO pdtdto = new AirProductDTO();
	pdtdto.setP_NAME(Pack_pname);
	
	// 항공정보
	AirPlainDTO airdto = new AirPlainDTO();
	airdto.setA_num(R_INFO_NUM);
	airdto.setA_time_s(R_ST_DATE);
	airdto.setA_time_e(R_EN_DATE);
	
	// 어른, 아동, 유아 좌석 합한 값
	int R_PPLE_NUM_SUM = R_PPLE_NUM_ADT + R_PPLE_NUM_CHI + R_PPLE_NUM_INF;
	
	System.out.println("AirReservAf.jsp의 R_PPLE_NUM_SUM: " + R_PPLE_NUM_SUM);
	
	// 합계구하는 dao 호출
	IAirReserveDAO dao = AirReserveDAO.getInstance();
	airinfoListdto = dao.seatPrice(airdto, pdtdto, R_PPLE_SEAT, R_PPLE_NUM_SUM);
	
	System.out.println("AirReservAf.jsp의 airinfoListdto: " + airinfoListdto.toString());
	
	int sum = airinfoListdto.getT_SUMPRICE(); 
	
	if(R_PPLE_SEAT.equals("일등석")){
		System.out.println("AirReservAf.jsp의 R_PPLE_SEAT: " + R_PPLE_SEAT);
		sum = sum + (int)(sum * 0.5);
		System.out.println("AirReservAf.jsp의 sum: " + sum);
	}else if(R_PPLE_SEAT.equals("비즈니스석")){
		System.out.println("AirReservAf.jsp의 R_PPLE_SEAT: " + R_PPLE_SEAT);
		sum = sum + (int)(sum * 0.2);
		System.out.println("AirReservAf.jsp의 sum: " + sum);
	}else{
		System.out.println("AirReservAf.jsp의 R_PPLE_SEAT: " + R_PPLE_SEAT);
		sum = sum + 0;
		System.out.println("AirReservAf.jsp의 sum: " + sum);
	}
	
	
	// 나이별
	
	// 인원에 따른 분류 변수 
	int adt_num = R_PPLE_NUM_ADT;
	int chi_num = R_PPLE_NUM_CHI;
	int inf_num = R_PPLE_NUM_INF;
	
	int total_num = adt_num + chi_num + inf_num;
	
	// 인원의 나이에 따른 할인 적용 부분 (adt = 성인은 할인X)
	int adt_price = sum * adt_num;
	
	int chi_price = sum * chi_num;
		chi_price = (int)(chi_price * 0.8);
		// chi_price = Integer.parseInt(String.valueOf(chi_price * 0.8)); / 이 방법은 NumberFormatException 발생
	
	int inf_price = sum * inf_num;
		inf_price = (int)(inf_price * 0.5);
		//inf_price = Integer.parseInt(String.valueOf(inf_price * 0.5)); / 이 방법은 NumberFormatException 발생
	
	// 총가격변수
	int total_price = adt_price + chi_price + inf_price;
	
	// login한 user의 등급을 가져오는 부분 
	int user_grade = mem.getGrade();
	System.out.println("등급이오 : " + mem.getGrade());
	
	// % 계산을 위한 변수
	double temp_calc = 0;
	
	// 회원등급에 따른 total_price 조정 부분
	/*
	0~10 : 브론즈
	11~20: 실버
	21~30: 골드
	30~40 : 플레티넘
	31~50 : 다이아몬드
	*/
	if(user_grade > 0 && user_grade <= 10){
		temp_calc = total_price * 0.05;
	//total_price = total_price - Integer.parseInt(String.valueOf(temp_calc)); / 이 방법은 NumberFormatException 발생
		total_price = total_price - (int)(temp_calc);
	}else if(user_grade > 10 && user_grade <= 20){
		temp_calc = total_price * 0.1;
		
		total_price = total_price - (int)(temp_calc);
	}else if(user_grade > 20 && user_grade <= 30){
		temp_calc = total_price * 0.15;
		
		total_price = total_price - (int)(temp_calc);
	}else if(user_grade > 30 && user_grade <= 40){
		temp_calc = total_price * 0.20;
		
		total_price = total_price - (int)(temp_calc);
	}else if(user_grade > 40 && user_grade <= 50){
		temp_calc = total_price * 0.25;
		
		total_price = total_price - (int)(temp_calc);
	}else if(user_grade > 51){
		temp_calc = total_price * 0.5;
		
		total_price = total_price - (int)(temp_calc);
	}
	
	out.println(total_price);
%>	