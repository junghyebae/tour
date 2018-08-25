<%@page import="air.AirTotalInfoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="air.AirPlainDAO"%>
<%@page import="air.IAirPlainDAO"%>
<%@page import="air.AirPlainDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="air.PagingBean"%>
<%@page import="air.IAirProductDAO"%>
<%@page import="air.AirProudctDAO"%>
<%@page import="air.AirProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");      
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비행기 예약 시스템</title>
<!-- JQuery 달력을 위한 준비 -->
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script> 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script> 
$(document).ready(function() { 
   // $(".datepicker").datepicker(); 
   $("#datepicker1").datepicker({
        changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
        changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
        minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
        nextText: '다음 달', // next 아이콘의 툴팁.
        prevText: '이전 달', // prev 아이콘의 툴팁.
        numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
        yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
        showButtonPanel: false, // 캘린더 하단에 버튼 패널을 표시한다. 
        dateFormat: "yymmdd", // 텍스트 필드에 입력되는 날짜 형식.
        showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
       });
   
   $("#datepicker2").datepicker({
        changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
        changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
        minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
        nextText: '다음 달', // next 아이콘의 툴팁.
        prevText: '이전 달', // prev 아이콘의 툴팁.
        numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
        yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
        showButtonPanel: false, // 캘린더 하단에 버튼 패널을 표시한다. 
        dateFormat: "yymmdd", // 텍스트 필드에 입력되는 날짜 형식.
        showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
       });
}); 
</script>
<style type="text/css">
th {
   text-align: right;
   width: 165px;
   padding-right: 20px;
}
td {
   padding-left: 7px;
}
#sh_detailForm {
   float: left; 
   width:99.7%; 
   height:279px;
   
}
#sh_simpleForm {
   width:99.7%;
   height:40px;
   text-align: center;
}

.sh_simple_box {
   width: 278px;
   height: 30px;
   margin-right: 10px;
   margin-top: 4px;
}

.simple_btn {
   width: 88px;
   height: 30px;
}
.peopleCnt {
   border-collapse: collapse;
   margin:auto;
   margin-top: 4px;
   /* margin-right: 396px; */
}
.text_box {
   width: 45px;
   height: 26px;
   text-align: right;
   padding-right: 4px;
   margin-right: 0px;
}
</style>
<body>
<%
// 로그인정보 저장하기
MemberDto user = (MemberDto)session.getAttribute("login");

//include로 보여줄 페이지 값 보여주기
String showPage = request.getParameter("showPage"); 
System.out.println("페이지이동 : "+showPage);

// 상품리스트
IAirProductDAO productDao = AirProudctDAO.getInstance();
List<AirProductDTO> pro_list = productDao.AirProudctList();

//비행기정보 리스트
IAirPlainDAO airplainDao = AirPlainDAO.getInstance();
List<AirPlainDTO> fly_list = airplainDao.getAirplainList();
List<AirPlainDTO> fly_sCntList = airplainDao.getAirplainCntList();
AirPlainDTO airPlaindto = new AirPlainDTO();
%>
   <!-- 키워드검색폼 -->
   <div id="sh_simpleForm">
      <form action="../main/index.jsp" style="padding-left: 59px; margin: 0px 5px;">
         <input type="hidden" name="showPage" value="shSimpleAirList">
         <input type="hidden" name="chType" value="1">
         <input type="text" name="findWord" class="sh_simple_box" value="검색" onfocus="this.value=''"
          style="width:282px;">
         <input type="submit" class="simple_btn" value="검색">
         <button type="button" id="chBtn" class="simple_btn">펼치기▲</button>
      </form>
   </div>
   <script>
   function check() {
     if(fr.start_date.value == "") {
       alert("출발날짜를 선택해 주세요.");
       return false;
     }else if(fr.arrive_date.value == "") {
      alert("도착날짜를 선택해 주세요.");
       return false;
     }else {
        true;
     }
   }
   </script>
   <!-- 상세검색폼 -->
   <div style="border: blue; padding-left: 30px; display: none" id="chForm">
      <!-- <form action="../main/index.jsp"> -->
      <form name="fr" onsubmit="return check();">
         <input type="hidden" name="showPage" value="searchDetailAirList">
         <input type="hidden" name="chType" value="2">
         <div style="width:774px; margin:auto; padding-right:297px; border-bottom: 1px solid lightgray; border-top:1px solid lightgray; margin-bottom: 10px;">
         <table class="peopleCnt">
            <tr>
               <th>날짜</th>
               <td>
                  <input type="text" name="start_date" id="datepicker1" readonly style="width:124px; height:30px; text-align: center;"> 
                  <em style="width: 30px; height:30px; display: inline-block; text-align: center; padding-top: 6px; padding-left: 0px;">-</em> 
                  <input type="text" name="arrive_date" id="datepicker2" readonly style="width:124px; height:30px; text-align: center;">
               </td>
            </tr>
            <tr>
               <th>비행기</th>
               <td>
                  <select name="air_name" class="sh_simple_box">
                     <%
                        for(int i=0; i<fly_list.size(); i++){
                     %>
                        <option name="air_name"><%=fly_list.get(i).getA_name() %></option>
                     <%
                        }
                     %>
                  </select>
               </td>
            </tr>
            
            <tr>
               <th>출발지역</th>
               <td>
                  <select name="start_cnt" class="sh_simple_box">
                     <%
                        for(int i=0; i<fly_sCntList.size(); i++){
                     %>
                        <option name="start_cnt"><%=fly_sCntList.get(i).getA_location_s() %></option>      
                     <%
                        }
                     %>
                  </select>
               </td>
            </tr>
            <tr>
               <th>도착지역</th>
               <td>
                  <select name="arrive_cnt" class="sh_simple_box">
                     <%
                        for(int i=0; i<pro_list.size(); i++){
                     %>
                        <option name="arrive_cnt"><%=pro_list.get(i).getP_COUNTRY() %></option>      
                     <%
                        }
                     %>
                  </select>
               </td>
            </tr>
         </table>
         <table class="peopleCnt" style="margin-left: 9px;">
            <tr>
               <th>인원</th>
               <td>유아</td>
               <td>
                  <input type="text" name="seat_count" class="text_box" value="0" onkeyup="onlyNumber(this)">
               </td>
               <td>학생</td>
               <td>
                  <input type="text" name="seat_count" class="text_box" value="0" onkeyup="onlyNumber(this)">
               </td>
               <td>성인</td>
               <td>
                  <input type="text" name="seat_count" class="text_box" value="0" onkeyup="onlyNumber(this)">
               </td>
            </tr>
         </table>
         <script type="text/javascript">
            function onlyNumber(obj) {
               // 숫자만 입력
               obj.value = obj.value.replace(/[^0-9]/g,'');      
               if(obj.value.length > 2){
                  obj.value = obj.value.substring(0, 2);
               }
            }
          
          </script>
         <table class="peopleCnt" style="margin: 9px 11px;">
            <tr>
               <th>좌석선택</th>
               <td>
                  <input type="radio" name="Air_seat" class="Air_seat" value="1" checked="checked"> 
               </td>
               <td>일반석</td>
               <td>
                  <input type="radio" name="Air_seat" class="Air_seat" value="2"> 
               </td>
               <td>비즈니스석</td>
               <td>
                  <input type="radio" name="Air_seat" class="Air_seat" value="3"> 
               </td>
               <td>일등석</td>
            </tr>
         </table>
         </div>
         <div style="text-align: center; padding-right: 102px; margin-bottom: 10px;" >
            <button type="reset" class="simple_btn">Reset</button>
            <input type="submit" class="simple_btn" value="검색">
         </div>
      </form>
</div>
<!-- 상세검색시 제약걸어주는 스크립트 -->
<!-- 도착날짜를 출발날짜와 같거나 작게 설정할경우-->
<script type="text/javascript">
$(document).ready(function() {
   $("#datepicker2").change(function name() {
      //alert("잘들어옴");
      var s = $("#datepicker1").val();
      var e = $("#datepicker2").val();
      //alert(s);
      if(s==""){
         alert("출발날짜를 먼저 입력하십시요.");
         $("#datepicker2").val("");
      }
      else if(s>=e){
         alert("해당날짜로는 선택이 불가능합니다.");
         $("#datepicker2").val("");
      } 
   });
   
   $("#chForm").hide();
   $("#chBtn").click(function (){
      var btnName = $("#chBtn").text();
      
      if(btnName == "상세검색▼"){
         $("#chForm").hide();
         $("#chBtn").text("펼치기▲");
      }
      if(btnName == "펼치기▲"){
         $("#chForm").show();
         $("#chBtn").text("상세검색▼");
      }
      
   });
});
</script>
<%
String findWord = request.getParameter("findWord");
%>
<!-- 페이징 처리 정보 교환 -->
<%
PagingBean paging = new PagingBean();
String chType = request.getParameter("chType");
if(request.getParameter("nowPage") == null){
   paging.setNowPage(1);
}else{
   paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));   
}
%>
<!-- 리스트 보여주는 영역 -->
<div style="border:1px solid lightgray; width: 780px; margin:auto; margin-bottom: 10px;">
   <table>
   <colgroup>
   <col width="55"> 
   <col width="180"> 
   <col width="100"> 
   <col width="350"> 
   <col width="80"> 
   <col width="35"> 
   </colgroup>
   <%
      if(chType == null || chType.equals("1")){
         // 모든리스트 전부 뿌려줌
         if(findWord == null) findWord = "";
         List<AirProductDTO> defaultlist = productDao.getAirProductPagingList(paging, findWord);
         if(defaultlist == null || defaultlist.size() == 0){
   %>
      <tr>
         <td colspan="6">작성된 글이 없습니다</td>
      </tr>
      <%
         }
         for(int i=0; i < defaultlist.size(); i++){
         AirProductDTO air = defaultlist.get(i);
      %>
      <tr>
         <td style="text-align: center;"><%=air.getP_NUM() %></td>
         <td><%=air.getP_NAME()%></td>
         <td><%=air.getP_COUNTRY() %></td>
         <td>
            <a href="../main/index.jsp?showPage=AirListDetail&seq=<%=air.getP_NUM() %>">
               <%=air.getP_CONTENT() %>
            </a>
         </td>
         <td style="text-align: right;"><%=air.getP_PRICE() %>원</td>
         <td style="text-align: right;"><%=air.getP_SCHEDULE() %></td>
      </tr>
      <%
         }
      }
      // 키워드 검색시 리스트
      else if(chType.equals("2")){
         // AirList.jsp 상세검색조건
         // String _start_date = request.getParameter("start_date");   
         // String _arrive_date = request.getParameter("arrive_date");   
         String _seat_count = request.getParameter("seat_count");   
         //String _air_seat = request.getParameter("Air_seat");      
         
         String air_name = request.getParameter("air_name");      // 비행기이름
         long start_date = Long.parseLong(request.getParameter("start_date"));      // 출발날
         long arrive_date = Long.parseLong(request.getParameter("arrive_date"));      // 도착일
         String start_cnt = request.getParameter("start_cnt");   // 출발국가
         String arrive_cnt = request.getParameter("arrive_cnt");   // 도착국가
         String _seatcount[] = request.getParameterValues("seat_count"); // 몇명인지
         int seat_count = 0;                                    // 몇명인지
         int air_seat = Integer.parseInt(request.getParameter("Air_seat"));      
         // 1:일반 2:비즈니스 3:일등
         
         for(int i=0; i<_seatcount.length; i++){
            _seatcount[i] = _seatcount[i].toString();
            System.out.println("_seatcount["+ i +"] :" + _seatcount[i]);
            seat_count += Integer.parseInt(_seatcount[i]);
         }
         
         airPlaindto.setA_name(air_name);        
         airPlaindto.setA_time_s(start_date);    
         airPlaindto.setA_time_e(arrive_date);   
         airPlaindto.setA_location_s(start_cnt); 
         airPlaindto.setA_location_e(arrive_cnt);
         
         if(air_seat == 1){
            airPlaindto.setA_seat_one(seat_count);
         }else if(air_seat == 2){
            airPlaindto.setA_seat_two(seat_count);
         }else {
            airPlaindto.setA_seat_three(seat_count);
         }
         
         List<AirProductDTO> detailList = productDao.getSearchProductList(airPlaindto, air_seat, paging);
         
         if(detailList == null || detailList.size() == 0){
      %>
         <tr>
            <td colspan="6">작성된 글이 없습니다</td>
         </tr>
      <%
         }
         
         for(int i=0; i < detailList.size(); i++){
            AirProductDTO air = detailList.get(i);
      %>
      <tr>
         <td style="text-align: center;"><%=air.getP_NUM() %></td>
         <td><%=air.getP_NAME()%></td>
         <td><%=air.getP_COUNTRY() %></td>
         <td>
            <a href="../main/index.jsp?showPage=AirListDetail&seq=<%=air.getP_NUM() %>">
               <%=air.getP_CONTENT() %>
            </a>
         </td>
         <td style="text-align: right;"><%=air.getP_PRICE() %>원</td>
         <td style="text-align: right;"><%=air.getP_SCHEDULE() %></td>
      </tr>
      <%      
         }
      }
      %>
   </table>
</div>
<!-- ---------------------------------------------------------------------------------------------- -->
<!-- 페이징 include -->
<div>
<jsp:include page="air_paging.jsp">
   <jsp:param name="actionPath" value="index.jsp" />
   <jsp:param value="shSimpleAirList" name="listType"/>
   <jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
   <jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
   <jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
   <jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>



</body>
</html>