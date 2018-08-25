<%@page import="mem.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="admin.PackageDto"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="main.BookingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="main.BookingDao"%>
<%@page import="main.IBookingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		
		<%-- JQuery UI --%>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	  		  	
	  	
	  	<%-- Slide Show(CSS) --%>
	  	<link rel="stylesheet" href="slideshow.css">
	  	
	  	
	  	
	  	<%-- Style / CSS --%>
	  	<style type="text/css">
	  	.search_li li {
	  		position: relative;
	  		padding-bottom:0;
	  		zoom: 1; 
	  		min-height:31px; 
	  		margin-bottom: 8px;	  	
	  	}
	  	
	  	.mySlides {display:none}
		.w3-left, .w3-right, .w3-badge {cursor:pointer}
		.w3-badge {height:13px;width:13px;padding:0}
	  	
	  	#calendar {
		max-width: 600px;
		margin: 0 auto;
		}
	  	</style>
	  	
	  	<link rel="stylesheet" type="text/css" href="../SemanticUI/semantic.css">
		
		<script
		  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
		  crossorigin="anonymous"></script>
		<script src="../SemanticUI/semantic.js"></script>
	</head>

	<body>
	<%
		//로그인정보가져오기
		MemberDto dto = null;
		dto = (MemberDto)session.getAttribute("login");
		
		if(dto == null){
			dto = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
					
		}
	
		System.out.println("dto.getId: " + dto.getId());
	
	%>	

	<%
	String bbs = "bbs";
	
	/*
	String getSdate = request.getParameter("sdate");
	String getEdate = request.getParameter("edate");
	String eLocation = request.getParameter("eLocation");
	*/
	
	String getSdate = "";
	String getEdate = "";
	String eLocation = "";
	//String product = "";

	try{
		getSdate = request.getParameter("sdate");
		getEdate = request.getParameter("edate");
		
		eLocation = request.getParameter("eLocation");
		System.out.println("main상단의 서블릿 eLocation: " + eLocation);
		
		
		getSdate = getSdate.replace("-", "");
			System.out.println("getSdate: " + getSdate);			
		
		getEdate = getEdate.replace("-", "");
			System.out.println("getEdate: " + getEdate);
			
		if(getSdate.equals(getEdate)){
			%>
			<script type="text/javascript">
				alert("가는 날짜와 오는 날짜가 같습니다. 다시 선택해주세요.");
			</script>
			<%
			getSdate = "";
			getEdate = "";
		}
		
		

	}catch (NullPointerException e) {		
		getSdate = "";
		getEdate = "";
		eLocation = "";
	}
		
	%>
	<table class="ui celled table">
		<tr>
			<td rowspan="4" style="background-color: #d9d9d9; table-layout: fixed;" width="600px">  
					
					<form action="index.jsp" method="get" name="frm">
					<input type="hidden" name="showPage" value="booking">
					<table border="2">
						<tr>
							<%-- 달력 --%>
							<td>
								<p>가는날짜 선택: </p>
							</td>
							<td>
								<input type="text" name="StartDate" id="datepicker" value="<%=getSdate%>">					
							</td>
							
							<td>
								<p>오는날짜 선택: </p>
							</td>
							<td>
								<input type="text" name="EndDate" id="datepicker2" value="<%=getEdate%>">
							</td>
						</tr>
						
						<tr>
							<td>
								<%-- DB에서 가져와서 LIST로 출력 --%>
								<p>비행기 선택: </p>
							</td>
							<td colspan="3">															
								
								<select id="air_select" name="air_select">
									<%
										IBookingDao dao = BookingDao.getInstance();
										List<BookingDto> list = dao.airList(getSdate, getEdate);
											
										/*
										for(int i=0; i<list.size(); i++){
											System.out.println("list: " + list.get(i).toString());
										}
										*/
										
										%>
										<%
											if(list.size() == 0){
												%>
													<option value="x">날짜에 일치한 비행기가 없습니다.</option>												
												<%												
											}else{
												if(eLocation == null){
													%>
													<option value="x">비행기를 선택해주세요.</option>
													<%
												}else{
													%>
													<option value="<%=eLocation %>"><%=eLocation %></option>
													<%		
												}
												for(int i=0; i<list.size(); i++){
													
													
													String StimeSet = list.get(i).getA_time_s();
														StimeSet = StimeSet.substring(8);
														StimeSet = StimeSet.substring(0, 2) + ":" + StimeSet.substring(2, 4);
													
													String EtimeSet = list.get(i).getA_time_e();
														EtimeSet = EtimeSet.substring(8);
														EtimeSet = EtimeSet.substring(0, 2) + ":" + EtimeSet.substring(2, 4);
													
													String set = list.get(i).getA_location_s() + "->" + list.get(i).getA_location_e() + "(" + StimeSet + "/" + EtimeSet + ")";
													%>
													<option value="<%=set%>"><%=set%></option>
												<%
												}
											}
										%>
								</select>
								
								<%-- <input type="hidden" name="eLocation" value="<%=eLocation%> "> --%>
								
								<script type="text/javascript">
									$(document).ready(function() {
										$("#datepicker2").change(function() {
											var datepicker = $("#datepicker").val();
											var datepicker2 = $("#datepicker2").val();
											
											location.href="index.jsp?sdate=" + datepicker + "&edate=" + datepicker2;
										});
									});
								</script>
								
								<script type="text/javascript">
									var select = document.getElementById("air_select"); 						
								
									$(document).ready(function() {
										$("#air_select").change(function() {
											
											alert("상품 선택: " + select.options[select.selectedIndex].value);
											
											location.href="index.jsp?sdate=" + <%=getSdate%> + "&edate=" + <%=getEdate%> + "&eLocation=" + select.options[select.selectedIndex].value;
										});
									});
								</script>
							</td>
						</tr>
						
						<tr>
							<td>
								<p>상품 선택: </p>
							</td>
							<td colspan="3">
								<select id="product_select" name="product_select">
									<%
										System.out.println("product_select의 log_eLocation: " + eLocation);
										if(eLocation == null)
										{
											System.out.println("product_select의 log_eLocation은 NULL");
											eLocation = "";
											%>
											<option value="x">먼저 날짜를 통해서 비행기를 선택해주세요!</option>
											<%
										}else{
											IPackageDao PackDao = PackageDao.getInstance();
											
											/*
											int idx = eLocation.indexOf(">");
											eLocation = eLocation.substring(idx+1);
											*/
											
											if(!eLocation.equals("")){
												int idx = eLocation.indexOf(">");
												eLocation = eLocation.substring(idx+1);
												idx = eLocation.indexOf("(");
												eLocation = eLocation.substring(0, idx);
											}										
											
											System.out.println("상품선택의 eLocation.substring Result: " + eLocation); 
											
											
											String setDate = dao.doDiffOfDate(getSdate, getEdate);
																					
											List<PackageDto> PackList = PackDao.PackageList(eLocation, setDate);	
											%>
											<option value="x">상품을 선택해주세요.</option>												
											<%
											for(int i=0; i<PackList.size(); i++){
											%>
												<option value="<%=PackList.get(i).getP_name()%>"><%=PackList.get(i).getP_name()%></option>
											<%
											}
										}
									%>							
								</select>
							</td>
						</tr>
						
						<tr>
							<td>
								<p>인원 선택: </p>
							</td>
							<td>
								<p>성인 / 만12세이상</p>
								<div>
									<ul>							
										<li class="width_33p">
										<select id="adt" name="adt" class="selbox10 jq_main_air_sel">
											<option value="1">성인1명</option>
											<option value="2">성인2명</option>
											<option value="3">성인3명</option>
											<option value="4">성인4명</option>
											<option value="5">성인5명</option>
											<option value="6">성인6명</option>
											<option value="7">성인7명</option>
											<option value="8">성인8명</option>
											<option value="9">성인9명</option>
										</select>
										</li>
									</ul>
								</div>						
							</td>
							<td>
								<p>아동 / 만12세미만</p>
								<div>
									<ul>							
										<li class="width_33p">
										<select id="chi" name="chi" class="selbox10  jq_main_air_sel">
											<option value="0">아동0명</option>
											<option value="1">아동1명</option>
											<option value="2">아동2명</option>
											<option value="3">아동3명</option>
											<option value="4">아동4명</option>
											<option value="5">아동5명</option>
											<option value="6">아동6명</option>
											<option value="7">아동7명</option>
											<option value="8">아동8명</option>
											<option value="9">아동9명</option>
										</select>
										</li>
									</ul>
								</div>			
							</td>
							<td>
								<p>유아 / 24개월미만 </p>
								<div>
									<ul>
										<li class="width_33p">
										<select id="inf" name="inf" class="selbox10  jq_main_air_sel">
											<option value="0">유아0명</option>
											<option value="1">유아1명</option>
											<option value="2">유아2명</option>
											<option value="3">유아3명</option>
											<option value="4">유아4명</option>
											<option value="5">유아5명</option>
											<option value="6">유아6명</option>
											<option value="7">유아7명</option>
											<option value="8">유아8명</option>
											<option value="9">유아9명</option></select>
										</li>							
									</ul>
								</div>			
							</td>
						</tr>

						<tr>
							<td>
								<p>좌석 선택: </p>
							</td>
							<td>
								<select name="seat_select" id="seat_select">
									<option>일반석</option>
									<option>일등석</option>
									<option>비즈니스석</option>
								</select>
							</td>
							<td>
								<p>총가격: </p>
							</td>
							<td>
								<input type="text"  id="total_price" readonly="readonly">
								
								<script type="text/javascript">
									$(document).ready(function() {
										$("[name='product_select']").change(function() {
											
											var pd_select = document.getElementById("product_select");
											
											//alert("상품 선택: " + pd_select.options[pd_select.selectedIndex].value);

										
											$.ajax({
												type:"GET",
												data:{
													"Sdate":$("[name='StartDate']").val(),
													"Edate":$("[name='EndDate']").val(), 
													"eLocation":$("[name='air_select']").val(),
													"product":$("[name='product_select']").val()
												},
												url:"../booking/main_booking_price.jsp",
												success:function(data){
													$("#total_price").val(data);
												},
												error:function(xhr, status, error){
													$("#total_price").val("통신실패");
												}
											}); // ajax end
										}); //change End 
										
										$("[name='adt']").change(function() {
											var adt_num = document.getElementById("adt");
											
											//alert("성인 인원: " + adt_num.options[adt_num.selectedIndex].value);
											
											$.ajax({
												type:"GET",
												data:{
													"Sdate":$("[name='StartDate']").val(),
													"Edate":$("[name='EndDate']").val(), 
													"eLocation":$("[name='air_select']").val(),
													"product":$("[name='product_select']").val(),
													"adt_num":$("[name='adt']").val()
												},
												url:"../booking/main_booking_price.jsp",
												success:function(data){
													$("#total_price").val(data);
												},
												error:function(xhr, status, error){
													$("#total_price").val("통신실패");
												}
											}); // ajax end
										}); // change end
										
										$("[name='chi']").change(function() {
											var chi_num = document.getElementById("chi");
											
											//alert("아동 인원: " + chi_num.options[chi_num.selectedIndex].value);
											
											$.ajax({
												type:"GET",
												data:{
													"Sdate":$("[name='StartDate']").val(),
													"Edate":$("[name='EndDate']").val(), 
													"eLocation":$("[name='air_select']").val(),
													"product":$("[name='product_select']").val(),
													"adt_num":$("[name='adt']").val(),
													"chi_num":$("[name='chi']").val()
												},
												url:"../booking/main_booking_price.jsp",
												success:function(data){
													$("#total_price").val(data);
												},
												error:function(xhr, status, error){
													$("#total_price").val("통신실패");
												}
											}); // ajax end
										}); // change end
										
										
										$("[name='inf']").change(function() {
											var inf_num = document.getElementById("inf");
											
											//alert("유아 인원: " + inf_num.options[inf_num.selectedIndex].value);
											
											$.ajax({
												type:"GET",
												data:{
													"Sdate":$("[name='StartDate']").val(),
													"Edate":$("[name='EndDate']").val(), 
													"eLocation":$("[name='air_select']").val(),
													"product":$("[name='product_select']").val(),
													"adt_num":$("[name='adt']").val(),
													"chi_num":$("[name='chi']").val(),
													"inf_num":$("[name='inf']").val()
												},
												url:"../booking/main_booking_price.jsp",
												success:function(data){
													$("#total_price").val(data);
												},
												error:function(xhr, status, error){
													$("#total_price").val("통신실패");
												}
											}); // ajax end
										}); // change end
										
										
										$("[name='seat_select']").change(function() {
											var seat = document.getElementById("seat_select");
											
											//alert("선택 좌석: " + seat.options[seat.selectedIndex].value);
											
											$.ajax({
												type:"GET",
												data:{
													"Sdate":$("[name='StartDate']").val(),
													"Edate":$("[name='EndDate']").val(), 
													"eLocation":$("[name='air_select']").val(),
													"product":$("[name='product_select']").val(),
													"adt_num":$("[name='adt']").val(),
													"chi_num":$("[name='chi']").val(),
													"inf_num":$("[name='inf']").val(),
													"seat":$("[name='seat_select']").val()
												},
												url:"../booking/main_booking_price.jsp",
												success:function(data){
													$("#total_price").val(data);
												},
												error:function(xhr, status, error){
													$("#total_price").val("통신실패");
												}
											}); // ajax end
										}); // change end
										
									});
								</script>
							</td>
						</tr>
					</table>
					</form>
					
					<%
						if(dto.getId().equals("")){
							%>
							<button id="notloginBtn" class="ui button">로그인을 먼저 해주세요.</button>
							
							<script type="text/javascript">
								$(document).ready(function() {
									$("#notloginBtn").click(function() {
										location.href="index.jsp?";
										alert("로그인을 해주세요.");								
									});
								});
							</script>
							<%
						}else{
							%>
							<button id="resBtn" class="ui button">예약</button>
							
							<script type="text/javascript">
								$(document).ready(function() {
									$("#resBtn").click(function() {
										$("[name='frm']").submit();
									});
								});
							</script>
							<%
						}								
					%>
					&nbsp;&nbsp;&nbsp;
					<!-- 지윤 링크 부분 -->
					<input type="button" class="ui button" onclick="location.href='../main/index.jsp?showPage=shSimpleAirList'" value="상세예약">
					&nbsp;&nbsp;&nbsp;
					<!-- 주희 호텔 링크부분 -->
					<input type="button" class="ui button" onclick="location.href='../main/index.jsp?showPage=hotel'" value="호텔예약">
					&nbsp;&nbsp;&nbsp;
					<button class="ui button" onclick="location.href='../main/index.jsp?showPage=calendar'">비행 일정 상세보기</button>							
			</td>
		
					
			
			<td rowspan="2" style="background-color: aqua;">
				<div align="center">
	            	<jsp:include page="main_calendar.jsp"/>
	           	</div>
			</td>
			
			<td style="background-color: yellow" align="center">
	            <div align="center">
	            	<jsp:include page="reserve_rank.jsp"/>
	           	</div>
            </td>
		</tr>
		
		
		<tr>
			<td style="background-color: green">
				<div>최근본상품</div>
			</td>
		</tr>
		
		
		<tr>			
			<td rowspan="2" style="background-color: pink">
				<div>검색순위</div>
			</td>

			<td rowspan="2" style="background-color: brown" width="300" height="300">
				<div>지금뜨는여행</div>
				
				<%--  --%>
				<div class="slideshow-container">
				  <div class="mySlides fade">
				    <div class="numbertext">1 / 3</div>
				    <img src="../image/now/now_vancouver.jpg" style="width:100%">
				  </div>
				
				  <div class="mySlides fade">
				    <div class="numbertext">2 / 3</div>
				    <img src="../image/now/now_tokyo.jpg" style="width:100%">
				  </div>
				
				  <div class="mySlides fade">
				    <div class="numbertext">3 / 3</div>
				    <img src="../image/now/now_vancouver.jpg" style="width:100%">
				  </div>
				
				  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				  <a class="next" onclick="plusSlides(1)">&#10095;</a>
				</div>
				
				<script>
					var slideIndex = 1;
					showSlides(slideIndex);
	
					function plusSlides(n) {
					  showSlides(slideIndex += n);
					}
	
					function currentSlide(n) {
					  showSlides(slideIndex = n);
					}
	
					function showSlides(n) {
					  var i;
					  var slides = document.getElementsByClassName("mySlides");
					  var dots = document.getElementsByClassName("dot");
					  if (n > slides.length) {slideIndex = 1} 
					  if (n < 1) {slideIndex = slides.length}
					  for (i = 0; i < slides.length; i++) {
					      slides[i].style.display = "none"; 
					  }
					  for (i = 0; i < dots.length; i++) {
					      dots[i].className = dots[i].className.replace(" active", "");
					  }
					  slides[slideIndex-1].style.display = "block"; 
					  dots[slideIndex-1].className += " active";
					}
				</script>
			</td>
		</tr>
		
		
		<tr>
		</tr>
	</table>
	
		<script>
		  	$.datepicker.setDefaults({
		  		duration: 'normal',
		        dateFormat: 'yy-mm-dd',
		        prevText: '이전 달',
		        nextText: '다음 달',
		        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        showMonthAfterYear: true,
		        yearSuffix: '년',
		        minDate: 0
		    });
		  	
		  	$( function() {
		    	$('#datepicker').datepicker();
		    	$('#datepicker2').datepicker();
		  	} );
	  	</script>
	
	</body>
</html>