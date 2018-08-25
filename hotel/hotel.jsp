<%@page import="java.text.DecimalFormat"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.IHotelDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="hotel.HotelDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="../admin/jquery.cookie.js"></script>
<title>Insert title here</title>

<style type="text/css">
.table1{
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
}
.table1 th{
	height: 37px;
}
.table1 td{
	height: 37px;
}
.form1{
	margin-top: 90px;
}

.test, td, th{
	border-bottom: 1px solid lightgray;
	padding-bottom: 10px;
	padding-top: 10px;
}
.test th{
	background-color: lightgray;
}
</style>

</head>
<body>

<%!
public static String toNumFormat(int num) {
	DecimalFormat df = new DecimalFormat("#,###");
	return df.format(num);
}
%>


<%
IHotelDao dao = HotelDao.getInstance();
List<HotelDto> list = dao.getHotelList("", "", "");

String checkIn = "";
String checkOut = "";
String location = "목적지를 입력하세요.";

String send = request.getParameter("send");

System.out.println(checkIn);

// 넘어온값이 있을경우
if(send != null){
	checkIn = request.getParameter("checkIn");
	checkOut = request.getParameter("checkOut");
	location = request.getParameter("location");

	list = dao.getHotelList(location, checkIn, checkOut);
}

//리스트확인
System.out.println("리스트의 사이즈 : "+list.size());
for(int i=0; i<list.size(); i++){
	System.out.println(list.get(i).toString());
}

%>



<form action="../main/index.jsp" onsubmit="return check()" class="form1">
<input type="hidden" name="showPage" value="hotel">
<input type="hidden" name="send" value="send">
	<table frame="border" style="margin: auto;" class="table1">
		<tr>
			<th>
				목적지
			</th>
			<th>
				체크인
			</th>
			<th>
				체크아웃
			</th>
		</tr>
		<tr>
			<td>
				<select name="location">
					<option value="none">목적지를 선택해주세요.</option>
					<option value="none">---------------</option>
					<option <%=location.equals("오사카")?"selected='selected'":"" %> value="오사카">오사카</option>
					<option <%=location.equals("도쿄")?"selected='selected'":"" %> value="도쿄">도쿄</option>
					<option <%=location.equals("후쿠오카")?"selected='selected'":"" %> value="후쿠오카">후쿠오카</option>
					<option <%=location.equals("오키나와")?"selected='selected'":"" %> value="오키나와">오키나와</option>
					<option <%=location.equals("도야마")?"selected='selected'":"" %> value="도야마">도야마</option>
					<option <%=location.equals("홍콩")?"selected='selected'":"" %> value="홍콩">홍콩</option>
					<option <%=location.equals("상해")?"selected='selected'":"" %> value="상해">상해</option>
					<option <%=location.equals("마카오")?"selected='selected'":"" %> value="마카오">마카오</option>
					<option <%=location.equals("하얼빈")?"selected='selected'":"" %> value="하얼빈">하얼빈</option>
					<option <%=location.equals("항저우")?"selected='selected'":"" %> value="항저우">항저우</option>
					<option <%=location.equals("로마")?"selected='selected'":"" %> value="로마">로마</option>
					<option <%=location.equals("파리")?"selected='selected'":"" %> value="파리">파리</option>
					<option <%=location.equals("런던")?"selected='selected'":"" %> value="런던">런던</option>
					<option <%=location.equals("프라하")?"selected='selected'":"" %> value="프라하">프라하</option>
					<option <%=location.equals("마드리드")?"selected='selected'":"" %> value="마드리드">마드리드</option>
					<option <%=location.equals("밀라노")?"selected='selected'":"" %> value="밀라노">밀라노</option>
					<option <%=location.equals("아테네")?"selected='selected'":"" %> value="아테네">아테네</option>
					<option <%=location.equals("워싱턴")?"selected='selected'":"" %> value="워싱턴">워싱턴</option>
					<option <%=location.equals("애틀란타")?"selected='selected'":"" %> value="애틀란타">애틀란타</option>
					<option <%=location.equals("보스턴")?"selected='selected'":"" %> value="보스턴">보스턴</option>
					<option <%=location.equals("샌프란시스코")?"selected='selected'":"" %> value="샌프란시스코">샌프란시스코</option>
					<option <%=location.equals("밴쿠버")?"selected='selected'":"" %> value="밴쿠버">밴쿠버</option>
					<option <%=location.equals("에드먼튼")?"selected='selected'":"" %> value="에드먼튼">에드먼튼</option>
					<option <%=location.equals("몬트리올")?"selected='selected'":"" %> value="몬트리올">몬트리올</option>
					<option <%=location.equals("카트만두")?"selected='selected'":"" %> value="카트만두">카트만두</option>
					<option <%=location.equals("델리")?"selected='selected'":"" %> value="델리">델리</option>
					<option <%=location.equals("콜롬보")?"selected='selected'":"" %> value="콜롬보">콜롬보</option>
					<option <%=location.equals("두바이")?"selected='selected'":"" %> value="두바이">두바이</option>
					<option <%=location.equals("테헤란")?"selected='selected'":"" %> value="테헤란">테헤란</option>
					<option <%=location.equals("도하")?"selected='selected'":"" %> value="도하">도하</option>
					<option <%=location.equals("방콕")?"selected='selected'":"" %> value="방콕">방콕</option>
					<option <%=location.equals("대만")?"selected='selected'":"" %> value="대만">대만</option>
					<option <%=location.equals("마닐라")?"selected='selected'":"" %> value="마닐라">마닐라</option>
					<option <%=location.equals("싱가포르")?"selected='selected'":"" %> value="싱가포르">싱가포르</option>
					<option <%=location.equals("세부")?"selected='selected'":"" %> value="세부">세부</option>
					<option <%=location.equals("호치민")?"selected='selected'":"" %> value="호치민">호치민</option>
					<option <%=location.equals("다낭")?"selected='selected'":"" %> value="다낭">다낭</option>
					<option <%=location.equals("하노이")?"selected='selected'":"" %> value="하노이">하노이</option>
				</select>
			</td>
			<td>
				<input type="text" id="datepicker" name="checkIn" readonly="readonly" value="<%= checkIn%>">
			</td>
			<td>
				<input type="text" id="datepicker2" name="checkOut" readonly="readonly" value="<%= checkOut%>">
			</td>
		</tr>
		<tr>		
			<td colspan="3" align="center">
				<input type="submit" value="검색">
			</td>
		</tr>
	</table>
</form>
<br><br><br><br>


<table align="center" class="test">
<col width="200"><col width="300"><col width="200">
	<tr>
		<th>
			지역
		</th>
		<th>
			호텔명
		</th>
		<th>
			가격
		</th>
	</tr>
	
	<!-- 검색결과가 없을경우 -->
	<%if(list.size() == 0 || list == null){
		%>
		<tr>
			<td colspan="3" align="center">
				검색결과가 없습니다.
			</td>
		</tr>
		<%
	}else{
		for(int i = 0; i < list.size(); i++){
			HotelDto dto = list.get(i);
		%>		
			<tr>
				<td align="center">
					<%=dto.getLocation() %>
				</td>
				<td align="center">
					<a href="../main/index.jsp?showPage=hotelDetail&seq=<%=dto.gethNum() %>" onclick="parameter2(<%=dto.gethNum()%>)"><%=dto.getName() %></a> 
					<!-- 호텔 쿠키저장 -->
				<script type="text/javascript">
				
				//만약 1순위로 출력할 쿠키에 이미 값이 저장되어있다면 1순위를 2순위로 밀어내고, 1순위에 새로운 쿠키값을 저장한다. -----(1)
				//하지만 1순위에 저장할쿠키값이 이미 같다면 밀어내지않는다. 하지만 같은 값이라도 시간을 갱신해주기위해  값을저장하도록한다. ----(2)
				//접근방식은 호텔 검색시, 또는 호텔예약시 해당하는 h_num 을 parameter값으로 넘겨주도록한다. 아래 방식참고
				
				function parameter2(name) {
				   //alert(name);
				   //1,2,3,4,5 까지 저장을하도록한다.
				   var ho1 = $.cookie("ho1");      
				   var ho2 = $.cookie("ho2");
				   var ho3 = $.cookie("ho3");
				   var ho4 = $.cookie("ho4");
				   var ho5 = $.cookie("ho5");
				
				   //들어온 값을 ho1에저장하고 기존에 저장된값을 한칸씩 밀어내도록한다. 역순으로 저장해야 데이터가 안날라가고 전달됨
				   //null이아니라는건 즉 이미 본호텔이 5개가됐다는것(기존의 ho5의 값을 날려버림)
				   if(ho5 !=null){
				      //만약 name값이 ho1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
				      if(name == ho1){
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				      else{
				         //만약 name값이 ho2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
				         if(name ==ho2){
				            $.cookie("ho2",ho1, {path:"/", expires:2});
				            $.cookie("ho1",name, {path:"/", expires:2});
				         }
				         else{
				            //만약 name값이 ho3의 값과 같다면 3번째까지밀어낸다.
				            if(name==ho3){
				               $.cookie("ho3",ho2, {path:"/", expires:2});
				               $.cookie("ho2",ho1, {path:"/", expires:2});
				               $.cookie("ho1",name, {path:"/", expires:2});
				            }
				            else{
				               //만약 name값이 ho4의 값과 같다면 4번쨰까지밀어낸다.
				               if(name==ho4){
				                  $.cookie("ho4",ho3, {path:"/", expires:2});
				                  $.cookie("ho3",ho2, {path:"/", expires:2});
				                  $.cookie("ho2",ho1, {path:"/", expires:2});
				                  $.cookie("ho1",name, {path:"/", expires:2});
				               }
				               else{
				                  //만약 name값이 ho5의 값과 같다면 5번쨰까지밀어낸다.
				                  if(name==ho5){
				                     $.cookie("ho5",ho4, {path:"/", expires:2});
				                     $.cookie("ho4",ho3, {path:"/", expires:2});
				                     $.cookie("ho3",ho2, {path:"/", expires:2});
				                     $.cookie("ho2",ho1, {path:"/", expires:2});
				                     $.cookie("ho1",name, {path:"/", expires:2});
				                  }
				                  //같은것이 하나라도 없을경우 
				                  else{
				                     $.cookie("ho5",null,{path:"/", expires:-1});
				                     $.cookie("ho5",ho4, {path:"/", expires:2});
				                     $.cookie("ho4",ho3, {path:"/", expires:2});
				                     $.cookie("ho3",ho2, {path:"/", expires:2});
				                     $.cookie("ho2",ho1, {path:"/", expires:2});
				                     $.cookie("ho1",name, {path:"/", expires:2});
				                  }
				               }
				            }
				         }
				      }
				   }
				   //이미 본호텔이 4개 
				   else if(ho4 !=null){
				      //만약 name값이 ho1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
				      if(name == ho1){
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				      else{
				         //만약 name값이 ho2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
				         if(name ==ho2){
				            $.cookie("ho2",ho1, {path:"/", expires:2});
				            $.cookie("ho1",name, {path:"/", expires:2});
				         }
				         else{
				            //만약 name값이 ho3의 값과 같다면 3번째까지밀어낸다.
				            if(name==ho3){
				               $.cookie("ho3",ho2, {path:"/", expires:2});
				               $.cookie("ho2",ho1, {path:"/", expires:2});
				               $.cookie("ho1",name, {path:"/", expires:2});
				            }
				            else{
				               //만약 name값이 ho4의 값과 같다면 4번쨰까지밀어낸다.
				               if(name==ho4){
				                  $.cookie("ho4",ho3, {path:"/", expires:2});
				                  $.cookie("ho3",ho2, {path:"/", expires:2});
				                  $.cookie("ho2",ho1, {path:"/", expires:2});
				                  $.cookie("ho1",name, {path:"/", expires:2});
				               }
				               else{
				                  //같은것이 하나라도 없을경우 
				                  $.cookie("ho5",ho4, {path:"/", expires:2});
				                  $.cookie("ho4",ho3, {path:"/", expires:2});
				                  $.cookie("ho3",ho2, {path:"/", expires:2});
				                  $.cookie("ho2",ho1, {path:"/", expires:2});
				                  $.cookie("ho1",name, {path:"/", expires:2});
				               }
				            }
				         }
				      }
				   }
				   //이미 본호텔이 3개
				   else if(ho3 !=null){
				      //만약 name값이 ho1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
				      if(name == ho1){
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				      else{
				         //만약 name값이 ho2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
				         if(name ==ho2){
				            $.cookie("ho2",ho1, {path:"/", expires:2});
				            $.cookie("ho1",name, {path:"/", expires:2});
				         }
				         else{
				            //만약 name값이 ho3의 값과 같다면 3번째까지밀어낸다.
				            if(name==ho3){
				               $.cookie("ho3",ho2, {path:"/", expires:2});
				               $.cookie("ho2",ho1, {path:"/", expires:2});
				               $.cookie("ho1",name, {path:"/", expires:2});
				            }
				            else{
				               //같은것이 하나라도 없을경우    
				               $.cookie("ho4",ho3, {path:"/", expires:2});
				               $.cookie("ho3",ho2, {path:"/", expires:2});
				               $.cookie("ho2",ho1, {path:"/", expires:2});
				               $.cookie("ho1",name, {path:"/", expires:2});         
				            }
				         }
				      }
				   }
				   //이미 본호텔이 2개
				   else if(ho2 !=null){
				      //만약 name값이 ho1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
				      if(name == ho1){
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				      else{
				         //만약 name값이 ho2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
				         if(name ==ho2){
				            $.cookie("ho2",ho1, {path:"/", expires:2});
				            $.cookie("ho1",name, {path:"/", expires:2});
				         }
				         else{
				            //같은것이 하나라도 없을경우       
				            $.cookie("ho3",ho2, {path:"/", expires:2});
				            $.cookie("ho2",ho1, {path:"/", expires:2});
				            $.cookie("ho1",name, {path:"/", expires:2});
				         }
				      }
				   }
				   //이미 본호텔이 1개
				   else if(ho1 !=null){
				      //만약 name값이 ho1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
				      if(name == ho1){
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				      else{
				         //같은것이 하나라도 없을경우       
				         $.cookie("ho2",ho1, {path:"/", expires:2});
				         $.cookie("ho1",name, {path:"/", expires:2});
				      }
				   }
				   //이미본호텔이 한개도없다면
				   else if(ho1 ==null){
				      //alert("잘들어옴");
				      $.cookie("ho1",name, {path:"/", expires:1});
				   }
				   
				}
				
				</script>
				</td>
				<td align="center">
					<%=toNumFormat(dto.getPrice()) %>원
				</td>
			</tr>		
		<%
		}
	}
	%>	
</table>



<script type="text/javascript">

// 체크인/아웃
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

// 검색전 확인
function check() {
	
	// 목적지입력
	if($("[name='location']").val() == "none"){
		alert("목적지를 선택해주세요.");
		return false;
	}
	
	// 날짜 선택
	if($("#datepicker").val() == "" ||  $("#datepicker2").val() == ""){
		alert("날짜를 선택해주세요.");
		return false;
	}
}
</script>



</body>
</html>