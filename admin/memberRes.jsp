<%@page import="airRes.airResDto"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="airRes.airResDao"%>
<%@page import="airRes.iairResDao"%>
<%@page import="hotelRes.hotelResDto"%>
<%@page import="java.util.List"%>
<%@page import="hotelRes.hotelResDao"%>
<%@page import="hotelRes.IhotelResDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
.tableclass th, td{
   border-bottom: 1px solid lightgray;
   padding-bottom: 10px;
}
</style>

</head>
<body>
<%
String id = request.getParameter("id");
%>
<%
// 아이디로 예약정보 가져와서 뿌려주기
IhotelResDao dao = hotelResDao.getInstance();
List<hotelResDto> Hlist = dao.getHotelList(id);

//(뱅기)
iairResDao Adao = airResDao.getInstance(); 
List<airResDto> Alist = Adao.getAirResList(id);
%>

<%!
//////////////----------- 비행기 날짜 추가  
public String toDates(String mdate){
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분"); 
   
   String s = mdate.substring(0, 4) + "-" //yyyy
         + mdate.substring(4, 6) + "-" //mm
         + mdate.substring(6, 8) + " " //dd
         + mdate.substring(8, 10) + ":" //hh
         + mdate.substring(10, 12) + ":00"; 
   Timestamp d = Timestamp.valueOf(s);   
   return sdf.format(d);
}
%>

<a href="#" onclick="moveA()">관리자 페이지로</a>

<h2 align="center">예약목록</h2>
<br>

<!-- 비행기예약 -->   
<table class="tableclass">
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
   <tr class="test">
      <td style="padding: 10px;" colspan="13" align="center"><b>항공예약</b></td>
   </tr>
   <tr>   
      <th>예약번호</th><th>비행기</th><th>상품</th>
      <th>출발일</th><th>귀국일</th>
      <th style="size: 20">성인</th><th>아동</th><th>유아</th>
      <th>좌석명</th><th>총가격</th><th>예약처리</th>
   </tr>
   
   <%if(Alist.size()==0 || Alist == null){ %>
      <tr><td colspan="12" align="center">예약사항이 없습니다.</td></tr>
   <%}else{
      for(int i = 0; i < Alist.size(); i ++){
      airResDto dto = Alist.get(i);
      String r_state="";
      %>
      <tr align="center">
         <td><%=dto.getR_NUM() %></td>
         <td><%=dto.getR_INFO_NUM() %></td>
         <td><%=dto.getR_PACK_NAME() %></td>
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
      </tr>
      <%} %>
   <%} %>
</table>
   
<br><br><br>
<!-- 호텔예약 -->      
<table class="tableclass">
<col width="100"><col width="100"><col width="200"><col width="100">
<col width="200"><col width="400">
   <tr>
      <td style="padding: 10px;" colspan="6" align="center"><b>호텔예약확인</b></td>
   </tr>
   
   <tr>
      <th>예약번호</th>
      <th>지역</th>
      <th>호텔명</th>
      <th>객실수</th>
      <th>가격</th>
      <th>체크인/아웃</th>
   </tr>
   
   <%if(Hlist.size() == 0 || Hlist == null){ %>
      <tr>
         <td colspan="7" align="center">예약사항이 없습니다.</td>
      </tr>
   <%}else{ 
      for(int i = 0; i < Hlist.size(); i ++){
         hotelResDto dto = Hlist.get(i);
         %>
      <tr>
         <td><%=dto.getSeq() %></td>
         <td><%=dto.getLocation() %></td>      
         <td>
            <a href="#" onclick="move(<%=dto.getNum() %>)">
               <%=dto.getName() %>
            </a>
         </td>      
         <td><%=dto.getRoom() %>개</td>
         <td><%=dto.getPrice() %>원</td>
         <td><%=dto.getCheckIn() + " ~ " + dto.getCheckOut()    %></td>
      </tr>
      <%}
   }%>
   
   
</table>


<script type="text/javascript">
function move(seq){ 
   opener.parent.location='../main/index.jsp?showPage=hotelDetail&seq='+seq; 
   } 
function moveA(){ 
      opener.parent.location='../main/index.jsp?showPage=admin_memberList'; 
      window.close(); 
      }
</script>


</body>







