<%@page import="java.util.Calendar"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>mypageUpdate.jsp</title>

<style type="text/css">
.table1, td{
	border-bottom: 1px solid lightgray;
	padding-bottom: 10px;
	padding-top: 10px;
}
.table1{
	width: 581px;
}
</style>

</head>
<body>

<%!
public String one(String str){
	return str.trim().charAt(0)=='0'?str.charAt(1)+"":str.trim();
}
%>

<%
Calendar cal = Calendar.getInstance(); 
%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");

String year = mem.getBirth().substring(0, 4);
String month = one(mem.getBirth().substring(5, 7));
String day = one(mem.getBirth().substring(8, 10));

String phone1 = mem.getPhone().substring(0, 3);
String phone2 = mem.getPhone().substring(4, 8);
String phone3 = mem.getPhone().substring(9, 13);
%>

<%
String email = mem.getEmail();
int num = email.indexOf('@');

String email_id = email.substring(0, num);
String email_addr = email.substring(num+1);
%>


<h2 align="center">내정보수정</h2>

<form action="../main/index.jsp" onSubmit="return formChk();">
<input type="hidden" name="showPage" value="mypageUpdateAf">
<input type="hidden" name="emailChk" value="emailCheck">
<input type="hidden" name="pwdCk_" value="pwdUnChk">
<input type="hidden" name="phoneCk_" value="phoneCheck">
	<table align="center" class="table1">
	<col width="100"><col width="300">
		<tr>
			<td>아이디</td>
			<td><input type="text" value="${login.id }" size="20" name="id" readonly="readonly"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="text" value="${login.pwd }" size="20" name="pwd" onblur="pwdChk()"></td>
		</tr>
		<tr>
			<td>비밀번호확인</td>
			<td>
				<input type="text" size="20" name="pwd_" onblur="pwdChk()">
				<p style="display: inline; font-size: 3px" id="passChk"></p>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" value="${login.name }" size="20" name="name"  onblur="onlyKor(this)">
				<p style="display: inline; font-size: 2px" id="nameCk"></p>
			</td>			
		</tr>
		<tr>
			<td>핸드폰</td>
			<td>
				<select name="phone1">
					<option <%=phone1.equals("010")?"selected='selected'":"" %> value="010">010</option>
					<option <%=phone1.equals("011")?"selected='selected'":"" %> value="011">011</option>
					<option <%=phone1.equals("016")?"selected='selected'":"" %> value="016">016</option>
					<option <%=phone1.equals("017")?"selected='selected'":"" %> value="017">017</option>
					<option <%=phone1.equals("018")?"selected='selected'":"" %> value="018">018</option>
					<option <%=phone1.equals("019")?"selected='selected'":"" %> value="019">019</option>
				</select>
					-<input type="text" name="phone2" size="5" onblur="phoneCk()" onkeyup="onlyNumber(this)" value="<%=phone2 %>" onchange="phChanged()">
					-<input type="text" name="phone3" size="5" onblur="phoneCk()" onkeyup="onlyNumber(this)" value="<%=phone3 %>" onchange="phChanged()">
					<p style="display: inline; font-size: 2px" id="phoneCk"></p>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="text" value="<%=email_id %>" size="10" name="email" onkeydown="fn_press_han(this);" onchange="emailChanged()">@
				<input type="text" value="<%=email_addr %>" size="10" name="email_ad" onkeydown="fn_press_han(this);" onchange="emailChanged()">
					<select name="email_addr" onchange="emailChanged()">
						<option value="">직접입력</option>
						<option <%=email_addr.equals("naver.com")?"selected='selected'":"" %> value="naver.com">naver.com</option>
						<option <%=email_addr.equals("daum.net")?"selected='selected'":"" %> value="daum.net">daum.net</option>
						<option <%=email_addr.equals("hotmail.com")?"selected='selected'":"" %> value="hotmail.com">hotmail.com</option>
						<option <%=email_addr.equals("nate.com")?"selected='selected'":"" %> value="nate.com">nate.com</option>
						<option <%=email_addr.equals("gmail.com")?"selected='selected'":"" %> value="gmail.com">gmail.com</option>
					</select>
				<button type="button" id="emailBtn">중복확인</button>
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>
				<select name="year">
					<%for(int i = 1960; i <= 2017; i++){ %>
						<option <%=year.equals(i + "")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
					<%} %>
				</select>년
				<select name="month">
					<%for(int i = 1; i <= 12; i++){ %>
						<option <%=month.equals(i + "")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
					<%} %>
				</select>월
				<select name="day">
					<%for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){ %>
						<option <%=day.equals(i + "")?"selected='selected'":"" %> value="<%=i %>"><%=i %></option>
					<%} %>
				</select>일
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정완료">
			</td>
		</tr>
	</table>
</form>

<script type="text/javascript">

$(document).ready(function() {
// email check
$("#emailBtn").click(function() {
//	alert("클릭");
if($("[name='email']").val() == "" || $("[name='email_ad']").val() == ""){
	alert("이메일를 입력해 주세요");
}else if($("[name='email']").val() == "<%out.print(email_id); %>"){	// 기존이메일과 동일할때
	$('[name="emailChk"]').val("emailCheck");
	alert("사용가능한 이메일 입니다.");
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
			}
		},
		error:whenerror
	});
}
});
	
//lastday
$('select[name = "month"]').change(function () {
//	alert("month");
	var lastday = (new Date(                  
			$('select[name="year"]').val()+"",                  
			$('select[name="month"]').val()+"", 0)).getDate();            // 세팅      
			var str = "";      
	for(i = 1; i <= lastday; i++){         
		str += "<option value = '" + i + "'>" + i + "</option>";
	}
	// 적용      
	$("select[name='day']").html(str);   
//	alert(lastday);
});


//이메일
$("[name='email_addr']").change(function() {
	$("[name='email_ad']").val($("[name='email_addr']").val());
});


//기존의 핸드폰번호와 같을경우
if($('[name="phone"]').val() == "<%out.print(mem.getPhone()); %>"){
	$('[name="phoneCk_"]').val("phoneCheck");
}

});
function whenerror(){
	   alert('error');
}

//한글입력방지
function fn_press_han(obj){
	//좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
	|| event.keyCode == 46 ) return;
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
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

// 비밀번호 체크
function pwdChk() {
//	alert("zmfflr");
	if($("[name='pwd']").val().length < 5){
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

//핸드폰 체크
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


// 이메일 변경되었을 시
function emailChanged() {
	$('[name="emailChk"]').val("emailUnCheck");
}

// 핸드폰 변경되었을 시
function phChanged() {
	$('[name="phoneCk_"]').val("phoneUnChk");
}

function formChk() {
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
	if($('[name="emailChk"]').val() != "emailCheck"){
		alert("이메일 체크를 해주세요");
		return false;
	}
	if($('[name="phoneCk_"]').val() != "phoneCheck"){
		alert("휴대폰번호를 확인해주세요");
		return false;
	}
	if($("[name='email']").val().match(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g)){
		alert("이메일에 한글은 입력될수 없습니다.");
	}
}
</script>

</body>
</html>