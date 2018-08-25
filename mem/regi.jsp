<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>regi.jsp</title>

<style type="text/css">
.tdtd{
   background-color: lightgray;
}
.tdtd1{
   padding-left: 40px;
}
.form1{
    padding-left: 500px;
    padding-top: 50px;
}
.element.style {
}
</style>

</head>
<body>

<%
Calendar cal = Calendar.getInstance(); 
%>


<div class="center">
   <form action="../main/index.jsp" method="post" onSubmit="return formChk();" class="form1">
   <input type="hidden" name="showPage" value="regiAf">
   <input type="hidden" name="idChk" value="idUnChk">
   <input type="hidden" name="emailChk" value="emailUnCheck">
   <input type="hidden" name="pwdCk_" value="pwdUnChk">
   <input type="hidden" name="phoneCk_" value="phoneUnChk">
   <h2 style="padding-left: 236px;">회원가입</h2>
      <table class="table" style=" width: 940px; height: 503px;">
         <tr>
            <td class="tdtd" align="center">아이디</td>
            <td class="tdtd1">
               <input type="text" name="id" id="id" onkeyup="fn_press_han(this);" size="20" onchange="idChanged()">
               <button type="button" id="idBtn">중복확인</button><br>
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">비밀번호</td>
            <td class="tdtd1">
               <input type="text" name="pwd" size="20" onblur="pwdChk()">
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">비밀번호 확인</td>
            <td class="tdtd1">
               <input type="text" size="20" name="pwd_" onblur="pwdChk()"> <p style="display: inline; font-size: 2px" id="passChk"></p>
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">이름</td>
            <td class="tdtd1">
               <input type="text" name="name" size="20" onblur="onlyKor(this)">
               <p style="display: inline; font-size: 2px" id="nameCk"></p>
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">이메일</td>
            <td class="tdtd1">
               <input type="text" name="email" size="10" onkeyup="fn_press_han(this);" onchange="emailChanged()">@
               <input type="text" name="email_ad" size="10" onkeyup="fn_press_han(this);" onchange="emailChanged()">
               <select name="email_addr">
                  <option value="">직접입력</option>
                  <option value="naver.com">naver.com</option>
                  <option value="daum.net">daum.net</option>
                  <option value="hotmail.com">hotmail.com</option>
                  <option value="nate.com">nate.com</option>
                  <option value="gmail.com">gmail.com</option>
               </select>
               <button type="button" id="emailBtn">중복확인</button>
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">핸드폰</td>
            <td class="tdtd1">
            <select name="phone1">
               <option value="010">010</option>
               <option value="011">011</option>
               <option value="016">016</option>
               <option value="017">017</option>
               <option value="018">018</option>
               <option value="019">019</option>
            </select>
               -<input type="text" name="phone2" size="5" onblur="phoneCk()" onkeyup="onlyNumber(this)">
               -<input type="text" name="phone3" size="5" onblur="phoneCk()" onkeyup="onlyNumber(this)">
               <p style="display: inline; font-size: 2px" id="phoneCk"></p>
            </td>
         </tr>
         
         <tr>
            <td class="tdtd" align="center">생년월일</td>
            <td class="tdtd1">
               <select name="year">
                  <%for(int i = 1960; i <= 2017; i++){ %>
                     <option value="<%=i %>"><%=i %></option>
                  <%} %>
               </select>년
               <select name="month">
                  <%for(int i = 1; i <= 12; i++){ %>
                     <option value="<%=i %>"><%=i %></option>
                  <%} %>
               </select>월
               <select name="day">
                  <%for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){ %>
                     <option value="<%=i %>"><%=i %></option>
                  <%} %>
               </select>일
            </td>
         </tr>
         
         <tr>
            <td colspan="2" align="center">
               <input type="submit" value="회원가입">
            </td>
         </tr>
      </table>
   </form>      
</div>


<script type="text/javascript">
$(document).ready(function() {
   
   // id check
   $("#idBtn").click(function() {
//      alert("클릭");
   if($("#id").val() == ""){
      alert("아이디를 입력해주세요.");
   }else if($("#id").val().length < 5){
      alert("아이디를 4자이상 작성해주세요.");
   }else{
      $.ajax({
         type:"POST",
         data:{
            "id":$("#id").val()
         },
         url:"../mem/idChk.jsp",
         success:function(data){
//            $("#idChk").html(data);
            
            if($.trim(data) == "yes"){
               $('[name="idChk"]').val("idCheck");
               alert("사용가능한 아이디 입니다.");
            }else{
               alert("사용불가능한 아이디 입니다.");
               $('[name="idChk"]').val("idUnCheck");
               $("#id").val("");
            }
         },
         error:whenerror
      });
   }
   });
   
   // email check
   $("#emailBtn").click(function() {
//      alert("클릭");
   if($("[name='email']").val() == "" || $("[name='email_ad']").val() == ""){
      alert("이메일를 입력해 주세요");
   }else if($("[name='email']").val().match(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g)){
      alert("이메일에 한글은 입력될수 없습니다.");
   }else{
      $.ajax({
         type:"POST",
         data:{
            "email":$("[name='email']").val(),
            "email_ad":$("[name='email_ad']").val()
         },
         url:"../mem/emailChk.jsp",
         success:function(data){            
            if($.trim(data) == "yes"){
               $('[name="emailChk"]').val("emailCheck");
               alert("사용가능한 이메일 입니다.");
            }else{
               alert("사용불가능한 이메일 입니다.");
               $("[name='email']").val("");
               $('[name="emailChk"]').val("emailUnCheck");
            }
         },
         error:whenerror
      });
   }
   });
   
// lastday
$('select[name = "month"]').change(function () {
//   alert("month");
   var lastday = (new Date(                  
         $('select[name="year"]').val()+"",                  
         $('select[name="month"]').val()+"", 0)).getDate();            // 세팅      
         var str = "";      
   for(i = 1; i <= lastday; i++){         
      str += "<option value = '" + i + "'>" + i + "</option>";
   }
   // 적용      
   $("select[name='day']").html(str);   
//   alert(lastday);
});
});
function whenerror(){
      alert('error');
}

// 이메일
$("[name='email_addr']").change(function() {
   $("[name='email_ad']").val($("[name='email_addr']").val());
});

// 한글입력방지
  function fn_press_han(obj){
   //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
   if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
   || event.keyCode == 46 ) return;
   obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}

// 핸드폰
function onlyNumber(obj) {
   // 숫자만 입력
   obj.value = obj.value.replace(/[^0-9]/g,'');      
   // 길이제한
   if(obj.value.length > 4){
      obj.value = obj.value.substring(0, 4);
   }
}

// 한글이름만 입력가능
function onlyKor(obj) {
   if(!obj.value.match(/^[가-힣]+$/)){
      $("#nameCk").text("옳바른 형식이 아닙니다");
      $("#nameCk").css("color","red");
      obj.value = "";
   }else{
      $("#nameCk").text("");
      $("#nameCk").css("color","green");
   }
}

// 비밀번호
function pwdChk() {
//   alert("zmfflr");
   if($("[name='pwd']").val().length < 4){
      $("#passChk").text("4자이상 입력해주세요.");
      $("#passChk").css("color","red");
   }else{
       if($("[name='pwd']").val() == $("[name='pwd_']").val()){
         $('[name="pwdCk_"]').val("pwdcheck");
         $("#passChk").text("비밀번호가 일치합니다");
         $("#passChk").css("color","green");
      }else{
         $("#passChk").text("비밀번호를 확인해 주세요");
         $("#passChk").css("color","red");
      }
   }
}

// 핸드폰 체크
function phoneCk() {
   if($('[name="phone2"]').val().match(/[^0-9]/g) || $('[name="phone3"]').val().match(/[^0-9]/g)){
      $("#phoneCk").text("숫자만 입력해주세요");
      $("#phoneCk").css("color","red");
   }else if($('[name="phone2"]').val().length != 4 || $('[name="phone3"]').val().length != 4){
      $("#phoneCk").text("옳바른 형식이 아닙니다");
      $("#phoneCk").css("color","red");
   }else{
      $("#phoneCk").text("통과!");
      $("#phoneCk").css("color","green");
      $('[name="phoneCk_"]').val("phoneCheck");
   }
}

// 아이디 변경되었을 시
function idChanged() {
   $('[name="idChk"]').val("idUnCheck");
}

// 이메일 변경되었을 시
function emailChanged() {
   $('[name="emailChk"]').val("emailUnCheck");
}


function formChk() {
   if($('[name="id"]').val() == null || $('[name="id"]').val() == ""){
      alert("아이디를 입력해주세요");
      return false;
   }
   if($('[name="pwd"]').val() == null || $('[name="pwd"]').val() == ""){
      alert("비밀번호를 입력해주세요");
      return false;
   }
   if($('[name="pwd_"]').val() == null || $('[name="pwd_"]').val() == ""){
      alert("비밀번호 확인란을 입력해주세요");
      return false;
   }
   if($('[name=pwdCk_]').val() != "pwdcheck"){
      alert("비밀번호를 동일하게 입력해주세요");
      return false;
   }
   if($('[name="name"]').val() == null || $('[name="name"]').val() == ""){
      alert("이름을 입력해주세요");
      return false;
   }
   if($('[name="email"]').val() == null || $('[name="email"]').val() == ""){
      alert("이메일을 입력해주세요");
      return false;
   }
   if($('[name="email_ad"]').val() == null || $('[name="email_ad"]').val() == ""){
      alert("이메일을 입력해주세요");
      return false;
   }
   if($('[name="phone2"]').val() == "" || $('[name="phone3"]').val() == ""){
      alert("휴대폰번호를 입력해주세요");
      return false;
   }
   if($('[name="idChk"]').val() != "idCheck"){
      alert("아이디 체크를 해주세요");
      return false;
   }
   if($('[name="emailChk"]').val() != "emailCheck"){
      alert("이메일 체크를 해주세요");
      return false;
   }
   if($('[name="phoneCk_"]').val() != "phoneCheck"){
      alert("휴대폰번호를 확인해주세요");
      return false;
   }
}
</script>

</body>
</html>