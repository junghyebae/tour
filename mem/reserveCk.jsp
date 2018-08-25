<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="airRes.airResDto"%>
<%@page import="airRes.airResDao"%>
<%@page import="airRes.iairResDao"%>
<%@page import="hotelRes.hotelResDto"%>
<%@page import="java.util.List"%>
<%@page import="hotelRes.hotelResDao"%>
<%@page import="hotelRes.IhotelResDao"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reserveCk.jsp</title>
<style type="text/css">
td, th {
   padding: 0px;
   padding-top: 5px; 
}
th {
   width: 40px;
}
.formm {
   padding-left: 250px; padding-right: 250px;
}
.test, td, th{
   border-bottom: 1px solid lightgray;
   padding-bottom: 10px;
}
.tableclass{
    width: 100%;
}.buttoncss{
     border: #000000 solid 1px;
    padding-top: 0px;
    padding-right: 0px;
    padding-bottom: 0px;
    padding-left: 0px;
    height: 20px;
    width: 50px;
    border-bottom-width: 1px;
    background-color: #66ccff;
    margin-right: 5px;


}





</style>

</head>
<body>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>

<!-- 회원일 경우 -->
<c:if test="${not empty login }">
<%
// 아이디로 예약정보 가져와서 뿌려주기  (호텔)
IhotelResDao Hdao = hotelResDao.getInstance();
List<hotelResDto> Hlist = Hdao.getHotelList(mem.getId());
//(뱅기)
iairResDao Adao = airResDao.getInstance();
List<airResDto> Alist = Adao.getAirResList(mem.getId());
%>


<%!
//////////////----------- 비행기 날짜 추가  
public String toDates(String mdate){
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분"); 
   
   String s = mdate.substring(0, 4) + "-" //yyyy
         + mdate.substring(4, 6) + "-" //mm
         + mdate.substring(6, 8) + " " //dd
         + mdate.substring(8, 10) + ":" //hh
         + mdate.substring(10, 12) + ":00" ; 
   Timestamp d = Timestamp.valueOf(s);
   
   return sdf.format(d);
}
%>
</script>
<!-- 비행기예약 -->   

<form class="formm">
<hr>
<h2>예약확인</h2>
<hr>
<h3>항공권 예약 목록</h3>
<input type="button" value="접기" id="airbtn" class="buttoncss">
<table class="tableclass" id="airReserveCheck">
<col width="100">
<col width="150">
<col width="250">
<col width="250">
<col width="250">
<col width="100">
<col width="100">
<col width="100">
<col width="100">
<col width="100">
<col width="100">
<col width="100">
   <tr class="test">
      <td style="padding: 10px;" colspan="13" align="center"><b>항공예약</b></td>
   </tr>
   <tr>   
      <th>예약번호</th><th>비행기</th><th>상품</th>
      <th>출발일</th><th>귀국일</th>
      <th style="size: 20">성인</th><th>아동</th><th>유아</th>
      <th>좌석명</th><th>총가격</th><th>예약처리</th>
      <th>예약취소</th>
   </tr>
   
   <%if(Alist.size()==0 || Alist == null){ %>
      <tr><td colspan="12">예약사항이 없습니다.</td></tr>
   <%}else{
      for(int i = 0; i < Alist.size(); i ++){
      airResDto dto = Alist.get(i);
      String r_state="";
      %>
      <tr align="center">
         <td><%=dto.getR_NUM() %></td>
         <td><%=dto.getR_INFO_NUM() %></td>
         <td><%=dto.getR_PACK_NAME() %></a></td>
          <td><%=toDates(dto.getR_ST_DATE()) %></td>
         <td><%=toDates(dto.getR_EN_DATE()) %></td>
         <td><%=dto.getR_PPLE_NUM_ADT() %>명</td>
         <td><%=dto.getR_PPLE_NUM_CHI() %>명</td>
         <td><%=dto.getR_PPLE_NUM_INF() %>명</td>
         <td><%=dto.getR_PPLE_SEAT() %></td>
         <td><%=String.format("%,d", dto.getR_TOTAL_PLACE())%>원</td>
         <%if(dto.getR_STATE()==0){
             r_state="취소";
         }else if(dto.getR_STATE()==1){
            r_state="대기";
         }else if(dto.getR_STATE()==2){
            r_state="완료";
         }%>
         <td><%=r_state %></td>
         <td>   
         <a href="../main/index.jsp?showPage=Acancel&seq=<%=dto.getR_NUM() %>">
            <button type="button" onclick="return confirm('예약을 취소합니다.');">취소</button>
         </a> 
         </td>
      </tr>
      <%} %>
   <%} %>
</table>
<br><br>

<!-- 호텔예약 -->
<h3 style="width:150px">호텔 예약 목록 </h3> <input type="button" value="접기" id="hotelbtn" class="buttoncss">
<script type="text/javascript">
$("#airbtn").click(function () {
	var a = $("#airbtn").val();
	if(a == "접기"){
		$("#airbtn").val("펼치기");
		$("#airReserveCheck").hide();
	}
	if(a == "펼치기"){
		$("#airbtn").val("접기");
		$("#airReserveCheck").show();
	}
});

$("#hotelbtn").click(function () {
	var a = $("#hotelbtn").val();
	if(a == "접기"){
		$("#hotelbtn").val("펼치기");
		$("#hotelReserveCheck").hide();
	}
	if(a == "펼치기"){
		$("#hotelbtn").val("접기");
		$("#hotelReserveCheck").show();
	}
});
</script>   
<table class="tableclass" id="hotelReserveCheck">
<col width="100"><col width="100"><col width="200"><col width="100">
<col width="200"><col width="400"><col width="100">
   <tr>
      <td style="padding: 10px;" colspan="7" align="center"><b>호텔예약확인</b></td>
   </tr>
   
   <tr>
      <th>예약번호</th>
      <th>지역</th>
      <th>호텔명</th>
      <th>객실수</th>
      <th>가격</th>
      <th>체크인/아웃</th>
      <th>예약취소</th>
   </tr>
   
   <%if(Hlist.size() == 0 || Hlist == null){ %>
      <tr><td colspan="7">예약사항이 없습니다.</td></tr>
   <%}else{ 
      for(int i = 0; i < Hlist.size(); i ++){
         hotelResDto dto = Hlist.get(i);
         %>
      <tr align="center">
         <td><%=dto.getSeq() %></td>
         <td><%=dto.getLocation() %></td>
         <td>
            <a href="../main/index.jsp?showPage=hotelDetail&seq=<%=dto.getNum() %>">
               <%=dto.getName() %>
            </a>
         </td>   
         <td><%=dto.getRoom() %>개</td>
         <td><%=String.format("%,d", dto.getPrice()) %> 원</td>
         <td><%=dto.getCheckIn() + " ~ " + dto.getCheckOut()    %></td>
      <td>
         <a href="../main/index.jsp?showPage=Hcancel&seq=<%=dto.getSeq() %>&Hnum=<%=dto.getNum() %>&room=<%=dto.getRoom() %>">
            <button type="button" onclick="return confirm('예약을 취소합니다.');">취소</button>
         </a>
      </td>
      </tr>
      <%}
   }%>   
</table>
</form>   

</c:if>

<!-- 비회원일 경우 -->
<c:if test="${empty login }">
<%
String regnumAir = request.getParameter("regnumAir");

// 호텔정보
int regnumHotel = Integer.parseInt(request.getParameter("regnumHotel"));
String regEmailHotel = request.getParameter("regEmailHotel");
String email_addr = request.getParameter("email_addr");
String check = request.getParameter("check");

// 예약된 호텔정보 list로 가져오기
IhotelResDao Hdao = hotelResDao.getInstance();
List<hotelResDto> Hlist = Hdao.getHotelList2(regnumHotel, regEmailHotel+email_addr);
   
%>

<%if(check.equals("air")){      // 패키지 예약내역
   %>
   
<table style="margin: auto;" frame="border">
   <tr>
      <td style="padding: 10px;" colspan="3"><b>패키지 예약확인 비회원</b></td>
   </tr>
</table>
<%}else{      // 호텔 예약내역 
   %>
<!-- 호텔예약 -->
<%if(Hlist.size() == 0 || Hlist == null){ %>
   <script type="text/javascript">
   alert("예약내역이 없습니다");
   location.href="../main/index.jsp?showPage=mypage";
   </script>
<%}else{%>      
<form class="formm">
<hr>
<h2>예약확인</h2>
<hr>
<h3>호텔 예약 목록 </h3>   
<table align="center" class="table1">
<col width="100"><col width="100"><col width="200"><col width="100">
<col width="200"><col width="400"><col width="100">
   <tr>
      <td style="padding: 10px;" colspan="7" align="center"><b>호텔예약확인</b></td>
   </tr>
   
   <tr>
      <th>예약번호</th>
      <th>지역</th>
      <th>호텔명</th>
      <th>객실수</th>
      <th>가격</th>
      <th>체크인/아웃</th>
      <th>예약취소</th>
   </tr>    
      <%for(int i = 0; i < Hlist.size(); i ++){
         hotelResDto dto = Hlist.get(i);
         %>
      <tr>
         <td><%=dto.getSeq() %></td>
         <td><%=dto.getLocation() %></td>
         <td>
            <a href="../main/index.jsp?showPage=hotelDetail&seq=<%=dto.getNum() %>">
               <%=dto.getName() %>
            </a>
         </td>   
         <td><%=dto.getRoom() %>개</td>
         <td><%=dto.getPrice() %>원</td>
         <td><%=dto.getCheckIn() + " ~ " + dto.getCheckOut()    %></td>
      <td>
         <a href="../main/index.jsp?showPage=HcancelNon&seq=<%=dto.getSeq() %>&Hnum=<%=dto.getNum() %>&room=<%=dto.getRoom() %>">
            <button type="button" onclick="return confirm('예약을 취소합니다.');">취소</button>
         </a>
      </td>
      </tr>
      <%}
   }%>   
</table>
   <%
}%>
</form>
</c:if>


</body>
</html>