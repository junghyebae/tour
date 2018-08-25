<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.test, td, th{
	padding-left: 30px;
	padding-right: 30px;
	padding-bottom: 5px;
	padding-top: 10px
}

</style>
</head>
<body>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");

String showPage = request.getParameter("showPage");
System.out.println("페이지이동 : "+showPage);
%>

<!-- 회원일 경우 -->
<c:if test="${not empty login }">	
	<jsp:include page="reserveCk.jsp" flush="false"/>
</c:if>
<!-- 회원일 경우 끝 -->


<!-- 비회원일 경우 -->
<c:if test="${empty login }">
<table align="center" style="padding-top: 100px">
<tr>
  <td>
<!-- 호텔조회 -->
			<form action="../main/index.jsp" onsubmit="return hotelCK();">
			<input type="hidden" name="showPage" value="reserveCk">
			<input type="hidden" name="check" value="hotel">
				<table style="margin: auto; border-collapse: collapse;" frame="border";>
					<tr class="test">
						<td colspan="2" align="center" >
							<b>호텔 예약정보 조회</b>
						</td>
					</tr>
					<tr style="padding: 10px">
						<td >예약번호</td>
						<td >
							<input type="text" name="regnumHotel">
						</td>
					</tr>
					<tr style="padding: 10px">
						<td >이메일</td>
						<td>
							<input type="text" name="regEmailHotel" size="10" onkeydown="fn_press_han(this);">@
							<select name="email_addr">
								<option value="@naver.com">naver.com</option>
								<option value="@daum.net">daum.net</option>
								<option value="@hotmail.com">hotmail.com</option>
								<option value="@nate.com">nate.com</option>
								<option value="@gmail.com">gmail.com</option>
							</select>
						</td>						
					</tr>
					<tr style="padding: 10px">
						<td colspan="2" align="center" >
							<input type="submit" value="조회">
						</td>
					</tr>
				</table>
			</form>	
		</td>
	</tr>
</table>

<h4 align="center">항공권 조회는 <a href="../main/index.jsp?showPage=login" style="color: green;">로그인</a>이 필요합니다.</h4>
</c:if>
<!-- 비회원일 경우 끝 -->


<script type="text/javascript">

//한글입력방지
function fn_press_han(obj){
	//좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
	|| event.keyCode == 46 ) return;
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}


function hotelCK() {
	if($('[name="regnumHotel"]').val().match(/[^0-9]/g)){
		alert("예약번호를 확인해 주세요");
		return false;
	}
	if($("[name='regnumHotel']").val() == "" || $("[name='regEmailHotel']").val() == ""){
		alert("항목을 모두 입력해주세요.");
		return false;
	}
}

</script>


</body>
</html>