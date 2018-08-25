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
}
#table th {
   border-right: 1px solid lightgray;
   text-align: right;
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
      <form action="../main/index.jsp">
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
               <th>상품명</th>
               <td>
                  <input type="text" name="p_name" readonly value="<%=airdto.getT_PNAME()%>" class="inputStyle">
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
               <th>좌석명</th>
               <td>
                  <input type="radio" name="Air_seat" value="일등석" onclick="javascript:brd();"> 일등석 
                  <input type="radio" name="Air_seat" value="비즈니스석" onclick="javascript:brd();"> 비즈니스석 
                  <input type="radio" name="Air_seat" value="일반석" onclick="javascript:brd();"> 일반석 
                  <script type="text/javascript">
                     function brd() {

                        var temp = $('[name="Air_seat"]:checked').val();

                        $.ajax({
                           type : "GET",
                           data : {
                              "seat" : $('[name="Air_seat"]:checked').val(),
                              "anum" : $("[name='a_num'").val(),
                              
                           },
                           url : "../air/AirDetail_Seat_AJAX.jsp",
                           success : function(data) {
                              //alert("data: " + data);
                              $("[name='total']").val($.trim(data)-1);
                              $("[name='seat_1']").val($.trim(data));
                              $("[name='Air_seatCntAdt']").val(1);
                              $("[name='Air_seatCntChi']").val(0);
                              $("[name='Air_seatCntInf']").val(0);
                              
                           },
                           error : function(xhr, status, error) {
                              alert("통신불가");
                           }
                        });
                        
                        // 가격뿌려주기
                        $.ajax({
                           type : "GET",
                           data : {
                              "a_num"  : $('[name="a_num"]').val(),
                              "a_time_s" : $('[name="a_time_s"]').val(),
                              "a_time_e" : $('[name="a_time_e"]').val(),
                              "Air_seatCntAdt" : "1",
                              "Air_seatCntChi" : "0",
                              "Air_seatCntInf" : "0",
                              "Pack_pname" : $('[name="p_name"]').val(),
                              "Air_seat" : $('[name="Air_seat"]:checked').val()
                           },
                           url : "../air/AirReservAf.jsp",
                           success : function(data) {
                              $("[name='finalPrice']").val($.trim(data));
                           },
                           error : function(xhr, status, error) {
                              alert("통신불가");
                           }
                        });
                     }
                     
                  $(document).ready(function() {
                     $("[name='Air_seat']").click(function() {
                        $("[name='Air_seatCntAdt']").removeAttr("readonly");
                        $("[name='Air_seatCntChi']").removeAttr("readonly");
                        $("[name='Air_seatCntInf']").removeAttr("readonly");
                     });
                  });
                  </script>
               </td>
            </tr>
            <tr>
               <th>인원수(성인)</th>
               <td>
                  <!-- <input type="text" name="Air_seatCntAdt" id="adt" onblur="numbersetting()"> -->
                  <input type="text" name="Air_seatCntAdt" id="adt" onfocus="this.value=''; return true;" 
                  class="inputStyle" style="width: 258px;" readonly="readonly" onkeyup="onlyNumber(this)" onblur="check1(this)"> 
                  <input type="text" readonly="readonly" id="adt_num" name="total" class="adt1" value="0" 
                        style="width: 41px; border: 1px solid lightgray; height:30px; text-align: right; padding-right: 3px;">

               </td>
            </tr>
            <tr>
               <th>인원수(아동)</th>
               <td>
                  <input type="text" name="Air_seatCntChi" id="chi" onfocus="this.value=''; return true;" 
                  class="inputStyle" style="width: 258px;" readonly="readonly" onkeyup="onlyNumber(this)" onblur="check(this)"> 
                  <input type="text" readonly="readonly" name="total" class="adt1" value="0" 
                        style="width: 41px; border: 1px solid lightgray; height:30px; text-align: right; padding-right: 3px;">
               </td>
            </tr>
            <tr>
               <th>인원수(유아)</th>
               <td>
                  <input type="text" name="Air_seatCntInf" id="inf" onfocus="this.value=''; return true;"
                  class="inputStyle" style="width: 258px;" readonly="readonly" onkeyup="onlyNumber(this)" onblur="check(this)"> 
                  <input type="text" readonly="readonly" name="total" class="adt1" value="0"
                        style="width: 41px; border: 1px solid lightgray; height:30px; text-align: right; padding-right: 3px;">
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
         <%if(user != null){ %>
         <div style="text-align: center; margin: 10px 0;">
            <input type="submit" value="결재하기" style="width:100px; height: 30px;">
         </div>
         <%} %>
      </form>
   </div>
   
<script type="text/javascript">\
   
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
    var temp = "";
   temp = Number(temp);
   
      var sum = "";
   sum = Number(sum);
   
   var counting = $("[name='seat_1']").val();
   
   // 준비
    var adt_ = $("#adt").val();
    var chi_ = $("#chi").val();
    var inf_ = $("#inf").val();
    
    
      
      // 범위지정
      $(".inputStyle").focusout(function() {
         if(Number($("#adt").val()) + Number($("#chi").val()) + Number($("#inf").val()) > Number($("[name='seat_1']").val())){
             alert("범위를 초과하였습니다");
             $("#adt").val(1);
             $("#chi").val(0);
             $("#inf").val(0);
         }
      });
      
      // adt
      $("#adt").focusout(function() {
         if($("#adt").val() == "" || $("#adt").val() == 0){
            $("#adt").val(1);
         }
         counting = $("[name='seat_1']").val();
         sum = counting - Number($("#adt").val()) - Number($("#chi").val()) - Number($("#inf").val());
         $('.adt1').val(sum);
         
          adt_ = $("#adt").val();
            chi_ = $("#chi").val();
            inf_ = $("#inf").val();
            
            $.ajax({
               type : "GET",
               data : {
                  "a_num"  : $('[name="a_num"]').val(),
                  "a_time_s" : $('[name="a_time_s"]').val(),
                  "a_time_e" : $('[name="a_time_e"]').val(),
                  "Air_seatCntAdt" : $('[name="Air_seatCntAdt"]').val(),
                  "Air_seatCntChi" : $('[name="Air_seatCntChi"]').val(),
                  "Air_seatCntInf" : $('[name="Air_seatCntInf"]').val(),
                  "Pack_pname" : $('[name="p_name"]').val(),
                  "Air_seat" : $('[name="Air_seat"]:checked').val()
               },
               url : "../air/AirReservAf.jsp",
               success : function(data) {
                  $("[name='finalPrice']").val($.trim(data));
               },
               error : function(xhr, status, error) {
                  alert("통신불가");
               }
            });
      });

      // chi
      $("#chi").focusout(function() {
         if($("#chi").val() == ""){
            $("#chi").val(0);
         }
         counting = $("[name='seat_1']").val();
         sum = counting - Number($("#adt").val()) - Number($("#chi").val()) - Number($("#inf").val());
         $('.adt1').val(sum);
         
          adt_ = $("#adt").val();
            chi_ = $("#chi").val();
            inf_ = $("#inf").val();
            
            $.ajax({
               type : "GET",
               data : {
                  "a_num"  : $('[name="a_num"]').val(),
                  "a_time_s" : $('[name="a_time_s"]').val(),
                  "a_time_e" : $('[name="a_time_e"]').val(),
                  "Air_seatCntAdt" : $('[name="Air_seatCntAdt"]').val(),
                  "Air_seatCntChi" : $('[name="Air_seatCntChi"]').val(),
                  "Air_seatCntInf" : $('[name="Air_seatCntInf"]').val(),
                  "Pack_pname" : $('[name="p_name"]').val(),
                  "Air_seat" : $('[name="Air_seat"]:checked').val()
               },
               url : "../air/AirReservAf.jsp",
               success : function(data) {
                  $("[name='finalPrice']").val($.trim(data));
               },
               error : function(xhr, status, error) {
                  alert("통신불가");
               }
            });
      });
         
      // inf
      $("#inf").focusout(function() {
         if($("#inf").val() == ""){
            $("#inf").val(0);
         }
         counting = $("[name='seat_1']").val();
         sum = counting - Number($("#adt").val()) - Number($("#chi").val()) - Number($("#inf").val());
         $('.adt1').val(sum);
         
         adt_ = $("#adt").val();
         chi_ = $("#chi").val();
         inf_ = $("#inf").val();
         
         $.ajax({
            type : "GET",
            data : {
               "a_num"  : $('[name="a_num"]').val(),
               "a_time_s" : $('[name="a_time_s"]').val(),
               "a_time_e" : $('[name="a_time_e"]').val(),
               "Air_seatCntAdt" : $('[name="Air_seatCntAdt"]').val(),
               "Air_seatCntChi" : $('[name="Air_seatCntChi"]').val(),
               "Air_seatCntInf" : $('[name="Air_seatCntInf"]').val(),
               "Pack_pname" : $('[name="p_name"]').val(),
               "Air_seat" : $('[name="Air_seat"]:checked').val()
            },
            url : "../air/AirReservAf.jsp",
            success : function(data) {
               $("[name='finalPrice']").val($.trim(data));
            },
            error : function(xhr, status, error) {
               alert("통신불가");
            }
         });
         
      });
      
   </script>
   <!-- 총가격  -->
   
</body>
</html>
