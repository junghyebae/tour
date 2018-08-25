<%@page import="java.util.Calendar"%>
<%@page import="mem.MemberDto"%>
<%@page import="hotel.HotelDto"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>hotelDetail.jsp</title>

<style type="text/css">
.table1{
	height: 594px;
    width: 893px;
    margin-top: 18px;
}
.table1 td{
	border-bottom: 1px solid lightgray;
	height: 100px;
}
.table1 th{
	border-bottom: 3px dotted gray;
	border-top: 3px dotted gray;
	height: 100px;
}
</style>

</head>
<body>

<%
// 회원정보 받아오기
MemberDto mem = (MemberDto)session.getAttribute("login"); 
%>

<%
// 호텔 seq 받아오기
int seq = Integer.parseInt(request.getParameter("seq"));

IHotelDao dao = HotelDao.getInstance();
HotelDto dto = dao.getHotelDetail(seq);

// System.out.println(dto.toString());
%>

<%
// check in 날짜
String year = dto.getCheckIn().substring(0, 4);
String month = dto.getCheckIn().substring(5, 7);
String day = dto.getCheckIn().substring(8, 10);

int Day = Integer.parseInt(year + month + day);

// 오늘 날짜
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
int today = Integer.parseInt(formatter.format(new java.util.Date()));
%>

<form action="../main/index.jsp" onsubmit="return frmCk()">
<input type="hidden" name="showPage" value="hotelReserve">
<input type="hidden" name="seq" value="<%=dto.gethNum() %>">
<input type="hidden" name="price" value="">
	<table align="center" class="table1">
		<tr>
			<th colspan="2"><font size="15"><%=dto.getName() %></font></th>
		</tr>
		<tr>
			<td rowspan="6">
			<%if(dto.getName().equals("글로벌 호텔")){ %>
				<img class="mySlides" alt="사진" src="../H_image/global1.jpg" style="max-width: 600px; height: auto;">
				<img class="mySlides" alt="사진" src="../H_image/global2.jpg" style="max-width: 600px; height: auto;">
				<img class="mySlides" alt="사진" src="../H_image/global3.jpg" style="max-width: 600px; height: auto;">
				<img class="mySlides" alt="사진" src="../H_image/global4.jpg" style="max-width: 600px; height: auto;">
				<button type="button" class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button type="button" class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			<%}else if(dto.getName().equals("플라자 호텔")){ %>
				<img class="mySlides" alt="사진" src="../H_image/plaza1.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/plaza2.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/plaza3.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/plaza4.jpg" style="max-width: 600px;">
				<button type="button" class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button type="button" class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			<%}else if(dto.getName().equals("디자인 호텔")){ %>
				<img class="mySlides" alt="사진" src="../H_image/design1.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/design2.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/design3.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/design4.jpg" style="max-width: 600px;">
				<button type="button" class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button type="button" class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			<%}else if(dto.getName().equals("시티 호텔")){ %>
				<img class="mySlides" alt="사진" src="../H_image/city1.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/city2.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/city3.jpg" style="max-width: 600px;">
				<button type="button" class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button type="button" class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			<%}else  if(dto.getName().equals("아트 호텔")){ %>
				<img class="mySlides" alt="사진" src="../H_image/art1.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/art2.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/art3.jpg" style="max-width: 600px;">
				<img class="mySlides" alt="사진" src="../H_image/art4.jpg" style="max-width: 600px;">
				<button type="button" class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button type="button" class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			<%}else{%>
				<img align="middle" class="mySlides" alt="사진" src="../H_image/test.jpg" style="max-width: 600px;">	
			<%} %>
			</td>
		</tr>
		<tr>
			<td>위치: <%=dto.getLocation() %></td>
		</tr>
		<tr>
			<td>숙박일: <%=dto.getCheckIn() %> ~ <%=dto.getCheckOut() %></td>
		</tr>
		<tr>
			<td>객실수: 
				<select name="room">
					<%if(dto.getRoom() <= 0 || Day < today){ // 객실이 0개일 경우%>
						<option value="0">객실 매진</option>
					<%}else{
					for(int i = 1; i <= dto.getRoom(); i ++){ %>
						<option value="<%=i %>"><%=i %>개</option>
					<%}
					}%>
				</select>
			</td>
		</tr>
		<%if(mem == null){ // 비회원일경우 %>
		<tr>
			<td>
				금액: <p name="price_ori" style="display: inline; color: blue;"><%=dto.getPrice() %></p>원<br>
			</td>
		</tr>
		<%}else if(mem != null){ // 회원일경우 등급별 할인혜택 %>
			<tr>
				<td>
					금액: <p name="price_ori" style="display: inline; text-decoration:line-through; color: red;"></p>원<br>
					할인적용가: <p name="price_dis" style="display: inline; color: blue;"></p>원
				</td>				
			</tr>
		<%}%>
		<tr>
			<td>
				<%if(mem != null){ %>
					<input type="submit" id="res" value="예약하기">
				<%}else{ %>
					<input type="submit" id="non" value="비회원예약하기">
				<%} %>
			</td>
		</tr>
	</table>
</form>

<a href="../main/index.jsp?showPage=hotel">검색페이지로</a>

<!-- 회원일경우 script -->
<c:if test="${not empty login }">
<script type="text/javascript">

//사진 슬라이더
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1} 
  if (n < 1) {slideIndex = x.length} ;
  for (i = 0; i < x.length; i++) {
      x[i].style.display = "none"; 
  }
  x[slideIndex-1].style.display = "block"; 
}


$(document).ready(function() {

// 맨처음 price 뿌려주기
$.ajax({
	type:"GET",
	data:{
		"room":$("[name='room']").val(),
		"price":<%out.print(dto.getPrice());%>
	},
	url:"../hotel/hotelPrice_ori.jsp",
	success:function(data){
		$('[name = "price_ori"]').text($.trim(data));
	},
	error:function(xhr, status, error){
		alert("error");
	}
});

// ajax - ori
$('select[name = "room"]').change(function () {
//	alert("room");
	$.ajax({
		type:"GET",
		data:{
			"room":$("[name='room']").val(),
			"price":<%out.print(dto.getPrice());%>
		},
		url:"../hotel/hotelPrice_ori.jsp",
		success:function(data){
			$('[name = "price_ori"]').text($.trim(data));
		},
		error:function(xhr, status, error){
			alert("error");
		}
	}); 	
});

// 맨처음 price 뿌려주기
$.ajax({
	type:"GET",
	data:{
		"room":$("[name='room']").val(),
		"price":<%out.print(dto.getPrice());%>,
		"grade":<%out.print(mem.getGrade());%>
	},
	url:"../hotel/hotelPrice_dis.jsp",
	success:function(data){
		$('[name = "price_dis"]').text($.trim(data));
	},
	error:function(xhr, status, error){
		alert("error");
	}
}); 

//ajax - dis
$('select[name = "room"]').change(function () {
//	alert("room");
	$.ajax({
		type:"GET",
		data:{
			"room":$("[name='room']").val(),
			"price":<%out.print(dto.getPrice());%>,
			"grade":<%out.print(mem.getGrade());%>
		},
		url:"../hotel/hotelPrice_dis.jsp",
		success:function(data){
			$('[name = "price_dis"]').text($.trim(data));
		},
		error:function(xhr, status, error){
			alert("error");
		}
	}); 	
});


// 콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 회원예약시 price 값넘겨주기
$("#res").click(function() {	
	if($('select[name = "room"]').val() != "0"){
		if(confirm("예약하시겠습니까?") == true){
			if(<%out.print(mem.getGrade()); %> <= 10){		
				$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>*0.95));		
			}else if(<%out.print(mem.getGrade()); %> > 10 && <%out.print(mem.getGrade()); %> <= 20){ 		
				$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>*0.90));		
			}else if(<%out.print(mem.getGrade()); %> > 20 && <%out.print(mem.getGrade()); %> <= 30){ 		
				$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>*0.85));	
			}else if(<%out.print(mem.getGrade()); %> > 30 && <%out.print(mem.getGrade()); %> <= 40){
				$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>*0.8));	 
			}else if(<%out.print(mem.getGrade()); %> > 40){
				$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>*0.75));	 
			}
		}else{
			return false;
		}
	}
});

});

//객실이 0개일 경우
function frmCk() {
	if($('select[name = "room"]').val() == "0"){
		alert("예약할 수 있는 객실이 없습니다.");
		return false;
	}
}
</script>
</c:if>
<!-- 회원일경우 script 끝 -->


<!-- 비회원일경우 script -->
<c:if test="${empty login }">
<script type="text/javascript">

//사진 슬라이더
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (n > x.length) {slideIndex = 1} 
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
    }
    x[slideIndex-1].style.display = "block"; 
}

//맨처음 price 뿌려주기
$.ajax({
	type:"GET",
	data:{
		"room":$("[name='room']").val(),
		"price":<%out.print(dto.getPrice());%>
	},
	url:"../hotel/hotelPrice_ori.jsp",
	success:function(data){
		$('[name = "price_ori"]').text($.trim(data));
	},
	error:function(xhr, status, error){
		alert("error");
	}
});

//ajax - ori
$('select[name = "room"]').change(function () {
//	alert("room");
	$.ajax({
		type:"GET",
		data:{
			"room":$("[name='room']").val(),
			"price":<%out.print(dto.getPrice());%>
		},
		url:"../hotel/hotelPrice_ori.jsp",
		success:function(data){
			$('[name = "price_ori"]').text($.trim(data));
		},
		error:function(xhr, status, error){
			alert("error");
		}
	}); 	
});

// 비회원 예약 버튼
$("#non").click(function() {
	$('[name = "showPage"]').val("Non-member");
	// 예약시 price 값넘겨주기
	$('[name = "price"]').val(Math.round($('select[name = "room"]').val()*<%out.print(dto.getPrice()); %>));
});		

//객실이 0개일 경우
function frmCk() {
	if($('select[name = "room"]').val() == "0"){
		alert("예약할 수 있는 객실이 없습니다.");
		return false;
	}
}
</script>
</c:if>
<!-- 비회원일경우 script 끝 -->

</body>
</html>

