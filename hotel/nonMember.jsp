<%@page import="hotel.HotelDto"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
.table1 th, td{
	border-bottom: 1px solid lightgray;
	padding-bottom: 10px;
	padding-top: 10px;
}
.h{
	padding-top: 98px;
}
</style>

</head>
<body>

<%
int seq = Integer.parseInt(request.getParameter("seq"));
int room = Integer.parseInt(request.getParameter("room"));
int price = Integer.parseInt(request.getParameter("price"));


// 호텔 정보 가져오기
IHotelDao dao = HotelDao.getInstance();
HotelDto hotel = dao.getHotelDetail(seq);
%>

<div align="center">
<h1 class="h">비회원 예약</h1>

<form action="../main/index.jsp" onsubmit="return check()" class="form1">
<input type="hidden" name="showPage" value="nonMemRes">
<input type="hidden" name="seq" value=<%=seq %>>
<input type="hidden" name="room" value=<%=room %>>
<input type="hidden" name="price" value=<%=price %>>
	<table class="table1">
		<tr>
			<th><%=hotel.getName() %></th>
		</tr>
		<tr>
			<td>체크인/아웃: <%=hotel.getCheckIn() + " ~ " + hotel.getCheckOut() %></td>
		</tr>
		<tr>
			<td>객실수:<%=room %>개</td>
		</tr>
		<tr>
			<td>가격:<p id="price" style="display: inline;"></p>원</td>
		</tr>
		<tr>
			<td>
				이메일:
				<input type="text" name="email" size="10">@
					<select name="email_addr">
						<option value="@naver.com">naver.com</option>
						<option value="@daum.net">daum.net</option>
						<option value="@hotmail.com">hotmail.com</option>
						<option value="@nate.com">nate.com</option>
						<option value="@gmail.com">gmail.com</option>
					</select>
				<input type="submit" value="예약하기">
			</td>
		</tr>
	</table>
</form>

</div>

<script type="text/javascript">
function check() {
	if($("[name='email']").val() == ""){
		alert("이메일을 입력해주세요");
		return false;
	}
}

//price
$("#price").text(numberWithCommas(<%out.print(price); %>));
//콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>

</body>
</html>












