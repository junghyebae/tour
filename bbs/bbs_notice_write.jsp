<%@page import="jdbc.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지작성</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>
<%
String id = request.getParameter("id");
System.out.print("id");
%>

<div>
<form action="../bbs/bbs_notice_writeAf.jsp" method="post" class=formm>
    <hr>
	<h1>공지게시판  <span class="font"> 글쓰기 </span> </h1>
	<a href="../main/index.jsp">HOME</a>
	<a href="bbs_notice_list.jsp">글 목록 돌아가기 </a>
	<hr>
<table class="tableform">
<tr>
	<td>작성자</td>
	<td>
		<input type="text" name="id" readonly="readonly" size="50" value="<%=id%>" class="inputtextcss"> 
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
		<textarea name="content" class="textareacss"></textarea>
	</td>
</tr>
<tr>
	<td align="right" colspan="2">
	<input type="submit" value="글쓰기" class="buttoncss">
	</td>
</tr>
</table>
</form>
</div>


</body>
</html>