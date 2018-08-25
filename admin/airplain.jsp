<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
</head>
<body>
<h1 align="center">비행기 정보 다중 추가</h1>

<form action="index.jsp" method="post">
<table cellpadding="4px">
<col width="150"><col width="600">
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 비행기이름 -->
<tr>
	<td>비행기이름</td>
	<td>
		<select name="a_name">
		<option value="1" selected="selected">대한항공</option>
		<option value="2">아시아나항공</option>
		</select>
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 출발지 -->
<tr>
	<td>출발지</td>
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
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 도착지 -->
<tr>
	<td>도착지</td>
	<td>
		도착지는 동남아: 방콕,대만,마닐라,싱가포르,세부,호치민,다낭,하노이
		일본:오사카,도쿄,후쿠오카,오키나와,도야마
		중국:홍콩, 상해,마카오,하얼빈,항저우
		유럽:로마,파리,런던,프라하,마드리드,밀라노,아테네
		미주:워싱턴,애틀란타,보스턴,샌프란시스코
		캐나다:밴쿠버,에드먼튼,몬트리올
		서남아:카트만두,델리,콜롬보
		중동:두바이,테헤란,도하 
		가 자동으로 들어갑니다.
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<!-- 시간설정 -->
<tr>
	<td>출발시간</td>
	<td>		  
		현재 시간 기준 8월 21일 (1달이후인 9월21일로 들어감)
		시간은 동남아는 10:00 , 일본 11:00 ,... 중동 17:00 이렇게 들어감		
	</td>
</tr>
<tr>
	<td>도착시간</td>
	<td>
		도착시간은 출발시간에 무조건 3일 더함
	</td>
</tr>
<tr>
<td colspan="3">
<hr>
</td>
</tr>
<tr>
	<td>가격</td>
	<td>
		1부터10까지 숫자중하나를 입력하시오.
		랜덤으로 들어갑니다.
		<input type="text" size="2" name="price" value="1">
		<script type="text/javascript">
		$(function() {
			$("[name='price']").blur(function() {
				if($('[name="price"]').val().match(/[^0-9]/g)){
					$("[name='price']").val(1);
				}
				if($('[name="price"]').val()==0){
					$("[name='price']").val(1);
				}
				if($('[name="price"]').val()>10){
					$("[name='price']").val(10);
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
<tr>
	<td>
		<input type="hidden" name="showPage" value="admin_airplainAf">
		<input type="submit" value="추가하기">
	</td>
</tr>
</table>
</form>
</body>
</html>