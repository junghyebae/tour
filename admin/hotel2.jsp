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
<%
request.setCharacterEncoding("utf-8");
%>
<h1 align="center" >호텔 정보 단일 추가</h1>



<form action="index.jsp" method="post">
<table>
<col width="200"><col width="300"><col width="600">
<!-- 1.호텔이름 -->
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<tr>
	<th> 호텔 이름 </th>
	<td>
		<input type="text" name="h_name" value="호텔명을입력하시오">
		<!-- focus & blur -->
		<script type="text/javascript">
		$(function() {
			$("[name='h_name']").focus(function() {
				$("[name='h_name']").val("");
			});
			$("[name='h_name']").blur(function() {
				if($('[name="h_name"]').val().length <1){
					$("[name='h_name']").val("호텔명을입력하시오");
				}
				else{
					
				}
				
			});
		})
		</script>
	</td>
	<td>
		●설정한 호텔명을 입력하세요.
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 2.날짜 선택 -->
<tr>
	<th>체크인</th>
	<td>
		<input type="text" id="datepicker" size="20" 
		readonly="readonly" name="h_check_in" value="클릭하여선택하시오">
	</td>
	<td>
		●체크인으로 설정할 날짜를 입력하시오. 
	</td>
</tr>
<tr>
	<th>체크아웃</th>
	<td>
		<input type="text" id="datepicker2" size="20" 
		readonly="readonly" name="h_check_out" value="클릭하여선택하시오">
	</td>
	<td>
		●체크아웃으로 설정할 날짜를 입력하시오. 
	</td>
	<td>
	<!-- 날짜함수 스크립트 -->
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
	});	
	</script>
	<!-- 체크아웃의 값을 체크인보다 크게할경우 -->
	<script type="text/javascript">
	$(document).ready(function() {
		$("#datepicker2").change(function name() {
			//alert("잘들어옴");
			var s = $("#datepicker").val();
			var e = $("#datepicker2").val();
			//alert(s);
			if(s=="클릭하여선택하시오"){
				alert("체크인 값을 먼저 입력하십시요.");
				$("#datepicker2").val("클릭하여선택하시오");
			}
			else if(s>e){
				alert("해당날짜로는 선택이 불가능합니다.");
				$("#datepicker2").val("클릭하여선택하시오");
			} 
			
		});
	});
	</script>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 3.지역선택 -->
<tr>
	<th>대륙선택</th>
	<td>
		<select id="area">
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
	●해당 대륙을 먼저 선택하시면 상세 지역을 선택할 수 있습니다.
	</td>
</tr>
<tr>
	<th>지역선택</th>
	<td>
		<select name="h_location" disabled="disabled">
			<option>지역선택</option>
		</select>
		<!-- 지역선택 script-->
		<script type="text/javascript">
		$(document).ready(function() {
			//대륙값을 선택했을때 해당 대륙값에 대한 목록을 출력한다.
			$("#area").change(function() {
				var countryName = $("#area").val();
				//alert(countryName);
				if(countryName==1){
					//동남아 선택
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='0'>방콕</option> "+
							"<option value='1'>대만</option> "+
							"<option value='2'>마닐라</option> "+
							"<option value='3'>싱가포르</option> "+
							"<option value='4'>세부</option> "+
							"<option value='5'>호치민</option> "+
							"<option value='6'>다낭</option> "+
							"<option value='7'>하노이</option> ";
					$("[name='h_location']").html(str);
				}
				else if(countryName==2){
					//일본선택
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='8'>오사카</option> "+
							"<option value='9'>도쿄</option> "+
							"<option value='10'>후쿠오카</option> "+
							"<option value='11'>오키나와</option> "+
							"<option value='12'>도야마</option> ";
							
					$("[name='h_location']").html(str);
				}
				else if(countryName==3){
					//중국선택
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='13'>홍콩</option> "+
							"<option value='14'>상해</option> "+
							"<option value='15'>마카오</option> "+
							"<option value='16'>하얼빈</option> "+
							"<option value='17'>항저우</option> ";
							
					$("[name='h_location']").html(str);
				}
				else if(countryName==4){
					//유럽
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='18'>로마</option> "+
							"<option value='19'>파리</option> "+
							"<option value='20'>런던</option> "+
							"<option value='21'>프라하</option> "+
							"<option value='22'>마드리드</option> "+
							"<option value='23'>밀라노</option> "+
							"<option value='24'>아테네</option> ";
					$("[name='h_location']").html(str);
				}
				else if(countryName==5){
					//미주
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='25'>워싱턴</option> "+
							"<option value='26'>애틀란타</option> "+
							"<option value='27'>보스턴</option> "+
							"<option value='28'>샌프란시스코</option>";
							
					$("[name='h_location']").html(str);
				}
				else if(countryName==6){
					//캐나다
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='29'>밴쿠버</option> "+
							"<option value='30'>에드먼튼</option> "+
							"<option value='31'>몬트리올</option> ";
							
					$("[name='h_location']").html(str);
				}
				else if(countryName==7){
					//서남아
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='32'>카트만두</option> "+
							"<option value='33'>델리</option> "+
							"<option value='34'>콜롬보</option> ";
							
					$("[name='h_location']").html(str);
				}
				else if(countryName==8){
					//중동
					$("[name='h_location'").removeAttr("disabled");
					var str="<option value='35'>두바이</option> "+
							"<option value='36'>테헤란</option> "+
							"<option value='37'>도하</option> ";
							
					$("[name='h_location']").html(str);
				}
				else{
					$("[name='h_location'").prop('disabled','disabled');
				}
				
				
			});
		});
		</script>
	</td>
	<td>
	●선택한 대륙에 대한 지역을 선택합니다. 
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 4.가격선택 -->
<tr>
	<th> 가격 선택 </th>
	<td>
		<input type="text" value="300000" name="h_price" size="10">
		<!-- focus & blur -->
		<script type="text/javascript">
		$(function() {
			$("[name='h_price']").focus(function() {
				$("[name='h_price']").val("");
			});
			$("[name='h_price']").blur(function() {
				if($('[name="h_price"]').val().match(/[^0-9]/g)){
					$("[name='h_price']").val(300000);
				}				
			});
		})
		</script>
	</td>
	<td>
	●가격을 입력하십시요 ( 숫자만 입력 가능 )
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 5.룸의 수 -->
<tr>
	<th> 룸의 최대 갯수 </th>
	<td>
	<input type="button" onclick="left()" value="◁">
	<input type="text" size="3" name="h_room" value="4" readonly="readonly">
	<input type="button" onclick="right()" value="▷">
	</td>
	<td>
	●최소 1개 최대 7까지 설정하시오
	<script type="text/javascript">
	function left() {
		$(function () {
			var room = $("[name='h_room']").val();
			room = (Number(room)-1);
			if(room<=1){
				$("[name='h_room']").val(1);
			}
			else{
				$("[name='h_room']").val(room);
			}
		});
	}
	function right(n) {
		$(function () {
			var room = $("[name='h_room']").val();
			room = (Number(room)+1);
			
			if(room>7){
				$("[name='h_room']").val(7);
			}
			else{
				$("[name='h_room']").val(room);
			}
		});
		
	}
	</script>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 5.버튼생성 -->
<tr>
	<td colspan="3" align="center">
	<input type="hidden" name="showPage" value="admin_hotelAf2">
	<input type="submit" value="추가하기" disabled="disabled" id="submit">
	<!-- 모든 값이 입력되면 disabled를 풀어준다. -->
	<script type="text/javascript">
	$(function() {
		$("[name='h_name']").blur(function() {
			process();
		});
		$("[name='h_check_in']").click(function() {
			process();
		});
		$("[name='h_check_out']").click(function() {
			process();
		});
		$("#area").click(function() {
			process();
		});
		$("[name='h_price']").blur(function() {
			process();
		});
	});
	
	function process() {
		//alert("발생완료");
		//모든 입력창이 입력이 됐는지 확인
		if($("[name='h_name']").val() !="클릭하여선택하시오"){
			if($("[name='h_check_in']").val() !="클릭하여선택하시오"){
				if($("[name='h_check_out']").val() !="클릭하여선택하시오"){
					if($("#area").val() !="대륙선택"){
						if($("[name='h_price']").val().length > 0){
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
		else{
			$("#submit").prop('disabled','disabled');
		}
	}
	</script>
	</td>
	
	
</tr>
</table>
</form>
</body>
</html>