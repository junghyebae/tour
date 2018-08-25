<%@page import="admin.MemberDto_AD"%>
<%@page import="admin.MemberDao_AD"%>
<%@page import="admin.IMemberDao_AD"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//값가져오기
String id = request.getParameter("typeid");
String ttype = request.getParameter("ttype");
System.out.println("id = "+id+" ttype= "+ttype);

IMemberDao_AD dao = MemberDao_AD.getInstance();
MemberDto_AD dto = dao.getMember(id);

if(dto !=null && ttype.equals("member")){
	%>
	<h2  align="center">회원 상세 정보</h2>
	<hr>
	<table border="1" align="center">
	<col width="150"><col width="200">
	<!-- 아이디 -->
	<tr>
		<th>아이디</th>
		<th><%=dto.getId()%></th>
	</tr>
	<!-- 이름 -->
	<tr>
		<th>이름</th>
		<th><%=dto.getName()%></th>
	</tr>
	<!-- 번호 -->
	<tr>
		<th>전화번호</th>
		<th><%=dto.getPhone()%></th>
	</tr>
	<!-- 생일 -->
	<tr>
		<th>아이디</th>
		<th><%=dto.getBirth()%></th>
	</tr>
	<!-- 등급 -->
	<tr>
		<th>등급</th>
		<%
		if(dto.getGrade()>=0 && dto.getGrade()<=10){
			%>
			<th>브론즈</th>
			<%
		}
		else if(dto.getGrade()>=11 && dto.getGrade()<=20){
			%>
			<th>실버</th>
			<%		
		}
		else if(dto.getGrade()>=21 && dto.getGrade()<=30){
			%>
			<th>골드</th>
			<%		
		}
		else if(dto.getGrade()>=31 && dto.getGrade()<=40){
			%>
			<th>플래티넘</th>
			<%		
		} 
		else if(dto.getGrade()>=41 ){
			%>
			<th>다이아몬드</th>
			<%		
		}
		else{
			%>
			<th>등급없음</th>
			<%
		}
		%>
	</tr>
	<!-- 회원분류 -->
	<tr>
		<th>분류</th>
		<%
		if(dto.getAuth()==0){
			%>
			<th>일반회원</th>
			<%
		}else{
			%>
			<th>관리자</th>
			<%
		}
		%>
	</tr>
	</table>
	<%
}
%>
</body>
</html>