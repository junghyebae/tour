<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<h1 align="center">비행기 정보 단일 추가</h1>
<%
request.setCharacterEncoding("utf-8");
%>


<form action="index.jsp" method="post">
<table>
<col width="100"><col width="300"><col width="500">

<!-- 항공선택 -->
<tr>
	<th>항공사 명</th>
	<td>
		<select name="a_name">
			<option value="1" selected="selected">대한항공</option>
			<option value="2">아시아나항공</option>
		</select>
	</td>
	<td>
		<p>대한항공, 아시아나항공 중 하나를 선택합니다.</p>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 좌석수 선택  -->
<tr>
	<th>최대좌석갯수선택</th>
	<td>
	좌석1
	<input type="button" onclick="left(1)" value="◁">
	<input type="text" size="3" name="a_seat_one" value="50" readonly="readonly">
	<input type="button" onclick="right(1)" value="▷">
	</td>
	<td>
	일등석의 최대좌석수입니다.(최소:0 최대:50)
	</td>
</tr>
<tr>
	<th></th>
	<td>
	좌석2
	<input type="button" onclick="left(2)" value="◁">
	<input type="text" size="3" name="a_seat_two" value="50" readonly="readonly">
	<input type="button" onclick="right(2)" value="▷">
	</td>
	<td>
	비즈니스석의 최대좌석수입니다.(최소:0 최대:50)
	</td>
</tr>
<tr>
	<th></th>
	<td>
	좌석3
	<input type="button" onclick="left(3)" value="◁">
	<input type="text" size="3" name="a_seat_three" value="50" readonly="readonly">
	<input type="button" onclick="right(3)" value="▷">
	</td>
	<td>
	일반석의 최대좌석수입니다.(최소:0 최대:50)
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 출발지역 -->
<tr>
	<th> 출발지역 </th>
	<td>
	<select name="a_location_s">
		<option value="1" selected="selected">서울(인천/김포)</option>
		<option value="2" >인천</option>
		<option value="3" >김포</option>
		<option value="4" >부산</option>
		<option value="5" >제주</option>
		<option value="6" >광주</option>
		<option value="7" >대구</option>
		<option value="8" >청주</option>
		<option value="9" >무안</option>
		<option value="10" >양양</option>
	</select>
	</td>
	<td>
	출발지역을 10개중 하나를 선택합니다.
	</td>
</tr>
<!-- 도착지역 -->
<tr>
	<th>대륙선택</th>
	<td>
		<select name="country">
			<option selected="selected">대륙선택</option>
			<option value="1">동남아</option>
			<option value="2">일본</option>
			<option value="3">중국</option>
			<option value="4">유럽</option>
			<option value="5">미주</option>
			<option value="6">캐나다</option>
			<option value="7">서남아</option>
			<option value="8">중동</option>
		</select>
	</td>
	<td>
	해당 대륙을 먼저 선택합니다.
	</td>
</tr>
<tr>
	<th>도착지역선택</th>
	<td>
		<select name="a_location_e" disabled="disabled">
			<option>도착지역선택</option>

		</select>
	</td>
	<td>
	선택한 대륙에 대한 도착지역을 선택합니다.
	</td>
</tr>
<!-- 출발시간 -->
<tr>
	<th>출발일자</th>
	<td>
		<input type="text" id="datepicker" size="20" readonly="readonly" name="a_time_s1" value="클릭하여선택하시오">
	</td>
	<td>
	<p id="selectTime_s">출발일자를 선택하면 출발시간 설정이 여기에 나타납니다.</p>
	</td>
</tr>
<!-- 도착시간 -->
<tr>
	<th>도착일자</th>
	<td>
		<input type="text" id="datepicker2" size="20" readonly="readonly" name="a_time_e1" value="클릭하여선택하시오"> 
	</td>
	<td>
	<p id="selectTime_e">도착일자를 선택하면 도착시간 설정이 여기에 나타납니다.</p>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 가격 -->
<tr>
	<th>가격</th>
	<td>
		<input type="text" name="a_price" size="10" value="100000">원
	</td>
	<td>
	<p id="price">가격을 입력하십시요.</p>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 제출 및 초기화 -->
<tr>
	<td align="center" colspan="3">
	<input type="hidden" name="showPage" value="admin_airplainAf2">
	<input type="submit" value="생성하기" disabled="disabled" id="submit">
	<script type="text/javascript">
	$(function() {
		$("[name='country']").blur(function() {
			process();
		});
		$("[name='a_time_s1']").click(function() {
			process();
		});
		$("[name='a_time_e1']").click(function() {
			process();
		});
		$("[name='a_price']").click(function() {
			process();
		});
	});

	function process() {
		//alert("발생완료");
		//모든 입력창이 입력이 됐는지 확인
		if($("[name='a_price']").val().length > 0){
			if($("[name='a_time_s1']").val() !="클릭하여선택하시오"){
				if($("[name='a_time_e1']").val() !="클릭하여선택하시오"){
					if($("[name='country']").val() !="대륙선택"){
						$("#submit").removeAttr("disabled");
					}
					else{
						$("#submit").prop('disabled','disabled');
					}
					
				}
				else{
					$("#submit").prop('disabled','disabled');
				}
			}
			else{
				$("#submit").prop('disabled','disabled');
			}
		}
		else{
			$("#submit").prop('disabled','disabled');
		}
	}
	</script>
	</td>

</tr>
</table>
</form>
<!-- 좌석수 선택 -->
<script type="text/javascript">

function left(n) {
	if(n == 1){
		$(function () {
			var seat = $("[name='a_seat_one']").val();
			seat = (Number(seat)-1);
			if(seat<=0){
				$("[name='a_seat_one']").val(0);
			}
			else{
				$("[name='a_seat_one']").val(seat);
			}
		});
	}
	else if(n==2){
		$(function () {
			var seat = $("[name='a_seat_two']").val();
			seat = (Number(seat)-1);
			if(seat<=0){
				$("[name='a_seat_two']").val(0);
			}
			else{
				$("[name='a_seat_two']").val(seat);
			}
		});
	}
	else if(n==3){
		$(function () {
			var seat = $("[name='a_seat_three']").val();
			seat = (Number(seat)-1);
			if(seat<=0){
				$("[name='a_seat_three']").val(0);
			}
			else{
				$("[name='a_seat_three']").val(seat);
			}
		});
	}
}
function right(n) {
	if(n == 1){
		$(function () {
			var seat = $("[name='a_seat_one']").val();
			seat = (Number(seat)+1);
			
			if(seat>=50){
				$("[name='a_seat_one']").val(50);
			}
			else{
				$("[name='a_seat_one']").val(seat);
			}
		});
	}
	else if(n==2){
		$(function () {
			var seat = $("[name='a_seat_two']").val();
			seat = (Number(seat)+1);
			if(seat>=50){
				$("[name='a_seat_two']").val(50);
			}
			else{
				$("[name='a_seat_two']").val(seat);
			}
		});
	}
	else if(n==3){
		$(function () {
			var seat = $("[name='a_seat_three']").val();
			seat = (Number(seat)+1);
			if(seat>=50){
				$("[name='a_seat_three']").val(50);
			}
			else{
				$("[name='a_seat_three']").val(seat);
			}
		});
	}
}
</script>
<!-- 대륙선택 -->
<script type="text/javascript">
$(document).ready(function() {
	//대륙값을 선택했을때 해당 대륙값에 대한 목록을 출력한다.
	$("select[name='country']").change(function() {
		var countryName = $("[name='country']").val();
		//alert(countryName);
		if(countryName==1){
			//동남아 선택
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='0'>방콕</option> "+
					"<option value='1'>대만</option> "+
					"<option value='2'>마닐라</option> "+
					"<option value='3'>싱가포르</option> "+
					"<option value='4'>세부</option> "+
					"<option value='5'>호치민</option> "+
					"<option value='6'>다낭</option> "+
					"<option value='7'>하노이</option> ";
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==2){
			//일본선택
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='8'>오사카</option> "+
					"<option value='9'>도쿄</option> "+
					"<option value='10'>후쿠오카</option> "+
					"<option value='11'>오키나와</option> "+
					"<option value='12'>도야마</option> ";
					
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==3){
			//중국선택
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='13'>홍콩</option> "+
					"<option value='14'>상해</option> "+
					"<option value='15'>마카오</option> "+
					"<option value='16'>하얼빈</option> "+
					"<option value='17'>항저우</option> ";
					
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==4){
			//유럽
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='18'>로마</option> "+
					"<option value='19'>파리</option> "+
					"<option value='20'>런던</option> "+
					"<option value='21'>프라하</option> "+
					"<option value='22'>마드리드</option> "+
					"<option value='23'>밀라노</option> "+
					"<option value='24'>아테네</option> ";
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==5){
			//미주
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='25'>워싱턴</option> "+
					"<option value='26'>애틀란타</option> "+
					"<option value='27'>보스턴</option> "+
					"<option value='28'>샌프란시스코</option>";
					
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==6){
			//캐나다
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='29'>밴쿠버</option> "+
					"<option value='30'>에드먼튼</option> "+
					"<option value='31'>몬트리올</option> ";
					
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==7){
			//서남아
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='32'>카트만두</option> "+
					"<option value='33'>델리</option> "+
					"<option value='34'>콜롬보</option> ";
					
			$("[name='a_location_e']").html(str);
		}
		else if(countryName==8){
			//중동
			$("[name='a_location_e'").removeAttr("disabled");
			var str="<option value='35'>두바이</option> "+
					"<option value='36'>테헤란</option> "+
					"<option value='37'>도하</option> ";
					
			$("[name='a_location_e']").html(str);
		}
		else{
			$("[name='a_location_e'").prop('disabled','disabled');
		}
		
		
	});
});

</script>
<!-- 날짜선택에 대한 스크립트 -->
<script type="text/javascript">
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
<!-- 도착날짜를 출발날짜와 같거나 작게 설정할경우-->
<script type="text/javascript">
$(document).ready(function() {
	$("#datepicker2").change(function name() {
		//alert("잘들어옴");
		var s = $("#datepicker").val();
		var e = $("#datepicker2").val();
		//alert(s);
		if(s=="클릭하여선택하시오"){
			alert("출발날짜를 먼저 입력하십시요.");
			$("#datepicker2").val("클릭하여선택하시오");
		}
		else if(s>=e){
			alert("해당날짜로는 선택이 불가능합니다.");
			$("#datepicker2").val("클릭하여선택하시오");
		} 
		
	});
});
</script>
<!-- 날짜를 선택했을때 시간 선택할수있게 만듬 -->
<script type="text/javascript">
$(document).ready(function() {
	$("#datepicker").change(function() {
		//조건문
		var s = $("#datepicker").val();
		if(s =="클릭하여선택하시오"){
			
		}
		else{
			//시
			var str = "<select name='a_time_s2'>";
			for(i=1;i<=23;i++){
				str +="<option value='"+i+"'>"+i+"시</option>";
			}
			str += "</select> &nbsp;&nbsp;&nbsp;";
			//분
			str += "<select name='a_time_s3'>";
			for(i=0;i<=5;i++){
				str +="<option value='"+(i*10)+"'>"+(i*10)+"분</option>";
			}
			str += "</select>";
			
			//넣기
			$("#selectTime_s").html(str);
		}
	});
	$("#datepicker2").change(function() {
		var s = $("#datepicker2").val();
		if(s =="클릭하여선택하시오"){
			
		}
		else{
			//시		
			var str = "<select name='a_time_e2'>";
			for(i=1;i<=23;i++){
				str +="<option value='"+i+"'>"+i+"시</option>";
			}
			str += "</select> &nbsp;&nbsp;&nbsp;";
			//분
			str += "<select name='a_time_e3'>";
			for(i=0;i<=5;i++){
				str +="<option value='"+(i*10)+"'>"+(i*10)+"분</option>";
			}
			str += "</select>";
			
			//넣기
			$("#selectTime_e").html(str);
		}
	});
});
</script>
<!-- 가격 : 숫자만 입력할수있게 만들기 -->
<script type="text/javascript">
$(function () {
	$("[name='a_price']").blur(function name() {
		if($('[name="a_price"]').val().match(/[^0-9]/g)){
			$("#price").text("숫자만 입력하십시요");
			$("[name='a_price']").val(100000);
		}
		else{
			$("#price").text("");
		}
	});


})

</script>
</body>
</html>







