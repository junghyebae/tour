<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
</head>
<body>
<h1 align="center" >상품 정보 단일 추가</h1>

<form action="index.jsp" method="post">
<table>
<col width="100"><col width="200"><col width="600">
<!-- 상품명 -->
<tr>
	<th>상품명</th>
	<td>
		<input type="text" name="p_name" value="상품명을입력하시오">
		<script type="text/javascript">
		$(function() {
			$("[name='p_name']").focus(function() {
				$("[name='p_name']").val("");
			});
			$("[name='p_name']").blur(function() {
				if($('[name="p_name"]').val().length <1){
					$("[name='p_name']").val("상품명을입력하시오");
				}
				else{
					
				}
				
			});
		})
		</script>
	</td>
	<td rowspan="2">
	●나라 참고<br>
	동남아: 방콕,대만,마닐라,싱카포르,세부,호치민,다낭,하노이
		일본:오사카,도쿄,후쿠오카,오키나와,도야마
		중국:홍콩, 상해,마카오,하얼빈,항저우
		유럽:로마,파리,런던,프라하,마드리드,밀라노,아테네
		미주:워싱턴,애틀란타,보스턴,샌프란시스코
		캐나다:밴쿠버,에드먼튼,몬트리올
		서남아:카트만두,델리,콜롬보
		중동:두바이,테헤란,도하 
	</td>
</tr>
<!-- 상품가격 -->
<tr>
	<th>상품가격</th>
	<td>
		<input type="text" name="p_price" value="500000">
		<script type="text/javascript">
		$(function() {
			$("[name='p_price']").blur(function() {
				if($('[name="p_price"]').val().match(/[^0-9]/g)){
					$("[name='p_price']").val(500000);
				}
				
			});
		});
		</script>
	</td>
</tr>
<!-- 일정 -->
<tr>
	<th>일정선택</th>
	<td>
		<select name="p_schedule">
			<%
			for(int i=1; i<=30; i++){
				%>
				<option value="<%=i%>"><%=i%>일</option>
				<%
			}
			%>
		</select>
	</td>
	<td>
	● 1일부터 30일중 하나를 선택하시오.
	</td>
</tr>
<!-- 국가선택 -->
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
		<select name="p_country" disabled="disabled">
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
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='0'>방콕</option> "+
							"<option value='1'>대만</option> "+
							"<option value='2'>마닐라</option> "+
							"<option value='3'>싱가포르</option> "+
							"<option value='4'>세부</option> "+
							"<option value='5'>호치민</option> "+
							"<option value='6'>다낭</option> "+
							"<option value='7'>하노이</option> ";
					$("[name='p_country']").html(str);
				}
				else if(countryName==2){
					//일본선택
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='8'>오사카</option> "+
							"<option value='9'>도쿄</option> "+
							"<option value='10'>후쿠오카</option> "+
							"<option value='11'>오키나와</option> "+
							"<option value='12'>도야마</option> ";
							
					$("[name='p_country']").html(str);
				}
				else if(countryName==3){
					//중국선택
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='13'>홍콩</option> "+
							"<option value='14'>상해</option> "+
							"<option value='15'>마카오</option> "+
							"<option value='16'>하얼빈</option> "+
							"<option value='17'>항저우</option> ";
							
					$("[name='p_country']").html(str);
				}
				else if(countryName==4){
					//유럽
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='18'>로마</option> "+
							"<option value='19'>파리</option> "+
							"<option value='20'>런던</option> "+
							"<option value='21'>프라하</option> "+
							"<option value='22'>마드리드</option> "+
							"<option value='23'>밀라노</option> "+
							"<option value='24'>아테네</option> ";
					$("[name='p_country']").html(str);
				}
				else if(countryName==5){
					//미주
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='25'>워싱턴</option> "+
							"<option value='26'>애틀란타</option> "+
							"<option value='27'>보스턴</option> "+
							"<option value='28'>샌프란시스코</option>";
							
					$("[name='p_country']").html(str);
				}
				else if(countryName==6){
					//캐나다
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='29'>밴쿠버</option> "+
							"<option value='30'>에드먼튼</option> "+
							"<option value='31'>몬트리올</option> ";
							
					$("[name='p_country']").html(str);
				}
				else if(countryName==7){
					//서남아
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='32'>카트만두</option> "+
							"<option value='33'>델리</option> "+
							"<option value='34'>콜롬보</option> ";
							
					$("[name='p_country']").html(str);
				}
				else if(countryName==8){
					//중동
					$("[name='p_country'").removeAttr("disabled");
					var str="<option value='35'>두바이</option> "+
							"<option value='36'>테헤란</option> "+
							"<option value='37'>도하</option> ";
							
					$("[name='p_country']").html(str);
				}
				else{
					$("[name='p_country'").prop('disabled','disabled');
				}
				
				
			});
		});
		</script>
	</td>
	<td>
	●선택한 대륙에 대한 지역을 선택합니다. 
	</td>
</tr>
<!-- 보내기 -->
<tr>
	<td colspan="2" align="center">
	<input type="hidden" name="showPage" value="admin_packageAf2">
	<input type="submit" value="작성하기" disabled="disabled" id="submit">
	<script type="text/javascript">
	$(function() {
		$("[name='p_name']").blur(function() {
			process();
		});
		$("[name='p_price']").blur(function() {
			process();
		});
		$("#area").click(function() {
			process();
		});
	});

	function process() {
		//alert("발생완료");
		//모든 입력창이 입력이 됐는지 확인
		if($("[name='p_price']").val().length > 0){
			if($("[name='p_name']").val() !="상품명을입력하시오"){
				if($("#area").val() !="대륙선택"){
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
	</script>
	</td>
</tr>
</table>

</form>
</body>
</html>