<%@page import="air.AirPlainDTO"%>
<%@page import="air.AirPlainDAO"%>
<%@page import="air.IAirPlainDAO"%>
<%@page import="admin.AirplainDto"%>
<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
<%@page import="air.AirTotalInfoDTO"%>
<%@page import="mem.MemberDto"%>
<%@page import="air.AirProductDTO"%>
<%@page import="air.AirProudctDAO"%>
<%@page import="air.IAirProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>항공상품상세</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
#table table {
   border-top : #444;
   border-collapse: collapse;
   border-top: 1px solid darkgray;
   border-bottom: 1px solid darkgray;
   margin: auto;
   /* margin-top: 40px; */
   width: 426px;
   text-align: center;
}
#table th {
   border-right: 1px solid lightgray;
   text-align: left;
   padding-right: 10px;
}
#table td {
   padding-left: 0px;
}
$table th, td {
   border-bottom: 1px solid lightgray;
}
.tb_bs {
   background-color: #F2F2F2;
}
h3 {
   text-align: center;
   width: 426px;
   margin: auto;
   margin-top: 30px;
   margin-bottom:10px;
}
.inputStyle{
   border: 1px solid lightgray;
   width: 300px;
   height: 30px; 
   padding: 5px;
}
</style>
</head>
<body>
   <%
      // 로그인정보 저장하기
      MemberDto user = (MemberDto) session.getAttribute("login");
      String userID = "";
      
      if (user != null) {
         userID = user.getId();
      }
      //include로 보여줄 페이지 값 보여주기
      String showPage = request.getParameter("showPage");
   %>
   <%
      String _seq = request.getParameter("seq");
      int seq = Integer.parseInt(_seq);
      IAirProductDAO airdao = AirProudctDAO.getInstance();
      AirTotalInfoDTO airdto = airdao.AirProductDetail(seq);

   %>
   <div>
      <h3 style="margin-top: 30px;">예약정보</h3>
      <!-- 좌석자리 -->
      <%
         int seatType = 0;
      %>
      <form action="../air/AirReservAf.jsp">
         <input type="hidden" name="showPage" value="AirReservFinal"> 
         <input type="hidden" name="seq" value="<%=seq%>">
         <input type="hidden" name="id" value="<%=userID%>">
         <input type="hidden" name="seat_1">
         <table id="table" align="center">
            <%
               if (userID.equals("") || userID == null) {
            %>
            <tr>
               <td colspan="2">비회원은 예약이 불가합니다.
               <td>
            </tr>
            <tr>
               <td colspan="2"><a href="../main/index.jsp">돌아가기</a></td>
            </tr>
            <%
               } else {
            %>
            <tr>
               <th>아이디</th>
               <td>
                  <input type="text" name="id" readonly value="<%=userID%>" class="inputStyle">
               </td>
            </tr>
            <tr>
               <th>비행기번호</th>
               <td>
                  <input type="text" name="a_num" readonly value="<%=airdto.getT_ANUM()%>" class="inputStyle">
               </td>
            </tr>
            <tr>
               <th>비행기명</th>
               <td>
                  <input type="text" name="a_name" readonly value="<%=airdto.getT_ANAME()%>" class="inputStyle">
               </td>
            </tr>
            <tr>
               <th>비행기 가격</th>
               <td>
                  <input type="text" name="a_price" readonly value="<%=airdto.getT_APRICE()%>" class="inputStyle">
               </td>
            </tr>  
            <tr>
               <th>상품명</th>
               <td>
                  <input type="text" name="p_name" readonly value="<%=airdto.getT_PNAME()%>" class="inputStyle">
               </td>
            </tr>
            <tr>
               <th>상품 가격</th>
               <td>
                  <input type="text" name="p_price" readonly value="<%=airdto.getT_PPRICE()%>" class="inputStyle">
               </td>
            </tr>     
            <tr>
               <th>출발일</th>
               <td>
                  <input type="text" name="a_time_s" readonly value="<%=airdto.getT_ATIME_S()%>" class="inputStyle">
               </td>
            </tr>
            <tr>
               <th>귀국일</th>
               <td>
                  <input type="text" name="a_time_e" readonly value="<%=airdto.getT_ATIME_E()%>" class="inputStyle">
               </td>
            </tr>
            
            <tr>
               <th>일등석 남은 좌석 수</th>
               <td>
                  <input type="text" name="Air_seatCntAdt" id="adt" lass="inputStyle" style="width: 300px;" readonly="readonly" value="<%=airdto.getT_ASEAT_ONE()%>">

               </td>
            </tr>
            <tr>
               <th>비즈니스석 남은 좌석 수</th>
               <td>
                  <input type="text" name="Air_seatCntChi" id="chi" lass="inputStyle" style="width: 300px;" readonly="readonly" value="<%=airdto.getT_ASEAT_TWO()%>">
               </td>
            </tr>
            <tr>
               <th>일반석 남은 좌석 수</th>
               <td>
                  <input type="text" name="Air_seatCntInf" id="inf" lass="inputStyle" style="width: 300px;" readonly="readonly" value="<%=airdto.getT_ASEAT_THREE()%>"> 
                  
               </td>
            </tr>
        
	        <tr>
	       		<th>인원 선택</th>	        
	        
		        <td colspan="2">   
		        
			        <select id="adt" name="adt" class="peopleNum" style="width: 99px">
			            <option value="1">성인1명</option>
			            <option value="2">성인2명</option>
			            <option value="3">성인3명</option>
			            <option value="4">성인4명</option>
			            <option value="5">성인5명</option>
			            <option value="6">성인6명</option>
			            <option value="7">성인7명</option>
			            <option value="8">성인8명</option>
			            <option value="9">성인9명</option>
			        </select>
			        
			        <select id="chi" name="chi" class="peopleNum" style="width: 99px">
			            <option value="0">아동0명</option>
			            <option value="1">아동1명</option>
			            <option value="2">아동2명</option>
			            <option value="3">아동3명</option>
			            <option value="4">아동4명</option>
			            <option value="5">아동5명</option>
			            <option value="6">아동6명</option>
			            <option value="7">아동7명</option>
			            <option value="8">아동8명</option>
			            <option value="9">아동9명</option>
			        </select>
			        
			        <select id="inf" name="inf" class="peopleNum" style="width: 98px">
			            <option value="0">유아0명</option>
			            <option value="1">유아1명</option>
			            <option value="2">유아2명</option>
			            <option value="3">유아3명</option>
			            <option value="4">유아4명</option>
			            <option value="5">유아5명</option>
			            <option value="6">유아6명</option>
			            <option value="7">유아7명</option>
			            <option value="8">유아8명</option>
			            <option value="9">유아9명</option>
			        </select>
		   		</td>
	   		</tr>
	   		
	   		<tr>
               <th>좌석명</th>
               <td>
               	  <input type="radio" name="Air_seat" value="일반석" onclick="javascript:brd();" checked="checked"> 일반석 
                  <input type="radio" name="Air_seat" value="비즈니스석" onclick="javascript:brd();"> 비즈니스석 
                  <input type="radio" name="Air_seat" value="일등석" onclick="javascript:brd();"> 일등석
               </td>
            </tr>
            
            <tr>
               <th>총가격</th>
               <td>
                  <input type='text' name='finalPrice' id='finalPrice' readonly="readonly"  class="inputStyle">
               </td>
            </tr>
            <%
               }
            %>
         </table>
         <div style="text-align: center; margin: 10px 0;">
            <input type="submit" value="결재하기" style="width:100px; height: 30px;">
         </div>
         
         <input type="hidden" name="eLocation" value="<%=airdto.getA_location_s()+"->"+airdto.getA_location_e()%>">
      </form>
   </div>
   
<script type="text/javascript">
   function formChk() {
      
   }
   
   // 숫자만
   function onlyNumber(obj) {
      // 숫자만 입력
      obj.value = obj.value.replace(/[^0-9]/g,'');      
      // 길이제한
      if(obj.value.length > 2){
         obj.value = obj.value.substring(0, 2);
      }
   }
   function check(obj) {
      if(obj.value.length == 0){
         obj.value = 0;
      }
   }
   function check1(obj) {
      if(obj.value.length == 0){
         obj.value = 1;
      }
   }
</script>


<script type="text/javascript">
      $(document).ready(function() {
         
         $("[name='adt']").change(function() {
            var adt_num = document.getElementById("adt");
            
            //alert("성인 인원: " + adt_num.options[adt_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='a_time_s']").val(),
                  "Edate":$("[name='a_time_e']").val(),
                  "eLocation":$("[name='eLocation']").val(),
                  "product":$("[name='p_name']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "Air_seat":$("[name='Air_seat']").val()
               },
               url:"../air/AirReservAf.jsp",
               success:function(data){
                  $("#finalPrice").val(data);
               },
               error:function(xhr, status, error){
                  $("#finalPrice").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         $("[name='chi']").change(function() {
            var chi_num = document.getElementById("chi");
            
            //alert("아동 인원: " + chi_num.options[chi_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         
         $("[name='inf']").change(function() {
            var inf_num = document.getElementById("inf");
            
            //alert("유아 인원: " + inf_num.options[inf_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val(),
                  "inf_num":$("[name='inf']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         
         $("[name='seat_select']").change(function() {
            var seat = document.getElementById("seat_select");
            
            //alert("선택 좌석: " + seat.options[seat.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val(),
                  "inf_num":$("[name='inf']").val(),
                  "seat":$("[name='seat_select']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
      });
   </script>


</body>
</html>
