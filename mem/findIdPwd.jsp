<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>findIdPwd.jsp</title>

<style type="text/css">
.table1{
   width: 410px;
    height: 119px;
    border-bottom: 1px solid lightgray;
   border-top: 1px solid lightgray;
}
.table1 th{
   height: 30px;
   border-bottom: 1px solid lightgray;
   background-color: lightgray;
}
</style>

</head>
<body>

<table border=0 style="margin: auto; width: 200px; height: 500px">
<tr>
<td>

   <!--좌측에 들어가는 테이블-->
   <table class="table1">
      <tr>
         <th colspan="2">아이디 찾기</td>
      </tr>
      <tr>
         <td>이메일</td>
         <td>
            <input type="text" name="email_id" size="10">@
            <input type="text" name="email_ad_id" size="10">
            <select name="email_addr_id">
               <option value="">직접입력</option>
               <option value="naver.com">naver.com</option>
               <option value="daum.net">daum.net</option>
               <option value="hotmail.com">hotmail.com</option>
               <option value="nate.com">nate.com</option>
               <option value="gmail.com">gmail.com</option>
            </select>
         </td>
      </tr>
      <tr>
         <td>핸드폰번호</td>
         <td>
            <select name="phone1">
               <option value="010">010</option>
               <option value="011">011</option>
               <option value="016">016</option>
               <option value="017">017</option>
               <option value="018">018</option>
               <option value="019">019</option>
            </select>
            -<input type="text" name="phone2" size="5" onkeyup="onlyNumber(this)">
            -<input type="text" name="phone3" size="5" onkeyup="onlyNumber(this)">
         </td>
      </tr>
      <tr>
         <td colspan="2" align="center"> <button type="button" id="findId">아이디찾기</button> </td>
      </tr>
   </table>
      
</td>
<td>
   
   <!--우측에 들어가는 테이블-->
   <table class="table1" style="margin-left: 60px;">
      <tr>
         <th colspan="2">비밀번호 찾기</th>
      </tr>
      <tr>
         <td>아이디</td>
         <td>
            <input type="text" name="id" style="width: 209px">
         </td>
      </tr>
      <tr>
         <td>이메일</td>
         <td>
            <input type="text" name="email_pwd" size="10">@
            <input type="text" name="email_ad_pwd" size="10">
            <select name="email_addr_pwd">
               <option value="">직접입력</option>
               <option value="naver.com">naver.com</option>
               <option value="daum.net">daum.net</option>
               <option value="hotmail.com">hotmail.com</option>
               <option value="nate.com">nate.com</option>
               <option value="gmail.com">gmail.com</option>
            </select>
         </td>
      </tr>
      <tr>
         <td colspan="2" align="center"> <button type="button" id="findPwd">비밀번호찾기</button> </td>
      </tr>
   </table>

</td>
</tr>
<tr><td colspan="2" align="center"><a href="../main/index.jsp?showPage=login">로그인페이지로</a></td></tr>
</table>

<script type="text/javascript">
$(document).ready(function() {
   $("#findId").click(function() {
//      alert("클릭");
   if($("[name='email_id']").val() == "" || $("[name='phone2']").val() == "" || $("[name='email_ad_id']").val() == "" || $("[name='phone3']").val() == "" ){
      alert("항목을 모두 입력해주세요");
   }else if($('[name="phone2"]').val().match(/[^0-9]/g) || $('[name="phone3"]').val().match(/[^0-9]/g)){
      alert("핸드폰 번호는 숫자만 입력해주세요");
   }else{
      $.ajax({
         type:"POST",
         data:{
            "email":$("[name='email_id']").val(),
            "email_ad":$("[name='email_ad_id']").val(),
            "phone1":$("[name='phone1']").val(),
            "phone2":$("[name='phone2']").val(),
            "phone3":$("[name='phone3']").val()
         },
         url:"../mem/findIdAf.jsp",
         success:function(data){
            alert($.trim(data));
         },
         error:whenerror
      });
   }
   });
   
$("#findPwd").click(function() {
//   alert("클릭");
   if($("[name='id']").val() == "" || $("[name='email_pwd']").val() == "" || $("[name='email_ad_pwd']").val() == ""){
      alert("항목을 모두 입력해주세요");
   }else{
      $.ajax({
         type:"POST",
         data:{
            "id":$("[name='id']").val(),            
            "email":$("[name='email_pwd']").val(),
            "email_ad":$("[name='email_ad_pwd']").val()
         },
         url:"../mem/findPwdAf.jsp",
         success:function(data){
            alert($.trim(data));
         },
         error:whenerror
      });
   }
   });
   
   
//이메일
$("[name='email_addr_id']").change(function() {
   $("[name='email_ad_id']").val($("[name='email_addr_id']").val());
});

//이메일
$("[name='email_addr_pwd']").change(function() {
   $("[name='email_ad_pwd']").val($("[name='email_addr_pwd']").val());
});

   
});
function whenerror(){
      alert('error');
}


//핸드폰
function onlyNumber(obj) {
 // 숫자만 입력
 obj.value = obj.value.replace(/[^0-9]/g,'');      
 // 길이제한
 if(obj.value.length > 4){
    obj.value = obj.value.substring(0, 4);
 }
}
</script>


</body>
</html>