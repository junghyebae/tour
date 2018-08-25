<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>mypage_.jsp</title>

<style type="text/css">
.table1 td{
	border-bottom: 1px solid lightgray;
	padding-bottom: 10px;
	padding-top: 10px;
}
</style>

</head>
<body>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");

IMemberDao dao = MemberDao.getInstance();
int grade = dao.getGrade(mem.getId());
%>

<h2 align="center">내정보</h2>
	
	<table align="center" class="table1">
	<col width="100"><col width="250">
		<tr>
			<td>아이디</td>
			<td>${login.id }</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${login.name }</td>
		</tr>
		<tr>
			<td>핸드폰</td>
			<td>${login.phone }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${login.email }</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>${login.birth }</td>
		</tr>
		<tr>
			<td>등급</td>
			<td>
			<%if(grade <= 10){ 	// 등급에 맞는 이미지 넣으면 좋을듯
				%>
				브론즈(<%=grade %>점)
				<%
			}else if(grade > 10 && grade <= 20){ 
				%>
				실버(<%=grade %>점)
				<%
			}else if(grade > 20 && grade <= 30){ 
				%>
				골드(<%=grade %>점)
				<%
			}else if(grade > 30 && grade <= 40){ 
				%>
				플레티넘(<%=grade %>점)
				<%
			}else if(grade > 40){ 
				%>
				다이아몬드(<%=grade %>점)
				<%
			}
			%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" onclick="location.href='../main/index.jsp?showPage=mypageUpdate'" value="회원정보 수정">
				<input type="button" onclick="del()" value="회원탈퇴">
			</td>
		</tr>
	</table>
	
	<script type="text/javascript">
	function del() {
		if(confirm("탈퇴하시겠습니까?") == true){
			location.href="../main/index.jsp?showPage=del";
		}
	}	
	</script>

</body>
</html>