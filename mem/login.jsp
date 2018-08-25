<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="../mem/jquery.cookie.js"></script>

<style type="text/css">
.table1{
	border-bottom: 1px solid lightgray;
	border-top: 1px solid lightgray;
}
.td1{
    padding-left: 6px;
    width: 91px;
    height: 40px;
}
.form1{
    padding-top: 150px;
}
.table1 th{
	height: 55px;
	border-bottom: 1px solid lightgray;
}
.td3{
	padding-top: 11px;
	padding-bottom: 11px;
}
.button1{
    padding-right: 13px;
    padding-left: 14px;
    padding-top: 5px;
    padding-bottom: 5px;
    border-right-width: 2px;
}
</style>

</head>

<body>

<div align="center">
<form action="../main/index.jsp" class="form1">
<input type="hidden" name="showPage" value="loginAf">
	<table class="table1">
		<tr>
			<th colspan="2"><font size="6">로그인</font></th>
		</tr>
		<tr>
			<td class="td1" align="center">아이디</td>
			<td class="td2">
				<input type="text" name="id">				
				<input type="checkbox" id="_chk_save_id"> 아이디 저장
			</td>
		</tr>
		<tr>
			<td class="td1" align="center">비밀번호</td>
			<td class="td2">
				<input type="password" name="pwd">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">			
				<input type="submit" value="로그인" class="button1" style="margin-right: 30px;">
				<input type="button" onclick="location.href='../main/index.jsp?showPage=regi'" value="회원가입" class="button1">	
			</td>			
		</tr>
		<tr>
			<td colspan="2" align="center" class="td3">
				<a href="../main/index.jsp?showPage=find">아이디/비밀번호 찾기</a>
			</td>
		</tr>
	</table>
</form>
</div>
	
	
<script type="text/javascript">
				
// keypress는 인자값으로 e(event)가 들어온다.
      $('[name="id"]').keypress(function(event) {
          if(event.which == '13'){
              //초기화 되는 부분
              event.preventDefault();
              
              //id에서 엔터키를 누르면 pw로 포커스를 이동
              $('[name="pw"]').focus();
          }
      });	

   	// ID 저장
      var user_id = $.cookie("user_id");		

    	//null이 아닐때 
if(user_id != null){
 $('[name="id"]').val(user_id);
 $("#_chk_save_id").attr("checked", "checked");    // 체크가 됐었을때
}

//checkbox를 click하였을때
$("#_chk_save_id").click(function() {
//	alert("체크박스 클릭!");
 
 if($(this).attr("checked") == "checked"){
     if($('[name="id"]').val() == ""){    // id가 비어져있을때
         $(this).attr("checked", false); // checkbox에 check를 없애주는 부분
         alert("id를 입력해주십시오");
     }else { // 쿠키에 저장
         $.cookie("user_id", $('[name="id"]').val(), {path:"/", expires:365});
     }
 }else {
     $.cookie("user_id", null, {path:"/", expires:-1});
 }
});
	
</script>

</body>
</html>