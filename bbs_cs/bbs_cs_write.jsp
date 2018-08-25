<%@page import="mem.MemberDto"%>
<%@page import="jdbc.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
    <% DBConn.initConnect(); %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상담작성</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
String id = request.getParameter("id");
%>

<div>
<form action="../bbs_cs/bbs_cs_writeAf.jsp" method="post" class=formm>
	<input type="hidden" value="<%=id %>" name="parent_id">
<hr>
<h1>상담게시판<span class="font">글쓰기ㅡ</span></h1>
<a href="../main/index.jsp">HOME</a>
<a href="../main/index.jsp?showPage=cs">글 목록 돌아가기 </a>
<hr>
<input type="hidden" value="0" name="process">
<table class="tableform">
<col width="200"><col width="500">
<tr>
	<td>작성자</td>
	<td>
		<input type="text" name="id" readonly="readonly" size="50" value="<%=id%>" class="inputtextcss"> 
	</td>
</tr>
<tr>
<td>분류</td>
<td>
	<select name="category" class="optioncss">
		<option value="1">회원가입</option>
		<option value="2" >항공권</option>
		<option value="3">호텔</option>
		<option value="4">기타</option>
	</select>
</td>
</tr>
<tr>
<td>공개여부</td>
<td>
<input type="radio" name="secret" value="1" checked="checked">공개
<input type="radio" name="secret" value="2" >비공개
</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" size="50" class="inputtextcss">
	</td>
</tr>
<tr>
	<td>내용</td>
	<td>	
		<textarea name="content" class="textareacss" ></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" class="testbordernone" >
	<input type="submit" value="글쓰기" class="buttoncss">
	</td>
</tr>
</table>
</form>
</div>

</body>
</html>