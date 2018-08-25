<%@page import="mem.MemberDto"%>
<%@page import="bbs.BbsDto_notice"%>
<%@page import="bbs.BbsDao_notice"%>
<%@page import="bbs.iBbsDao_notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
iBbsDao_notice dao = BbsDao_notice.getInstance();
BbsDto_notice dto = dao.notice_detail(seq);
%>

<% 
MemberDto mem = (MemberDto)session.getAttribute("login");
%> 

<form action="../bbs/bbs_notice_updateAf.jsp" method="post" class=formm>
<hr>
<h1>공지게시판 <span class="font"> 글수정하기 </span></h1>
<hr>
	<input type="hidden" name="seq" value=<%=dto.getSeq() %>>
<table class="tableform">
<col width="200"><col width="500">
<tr>
	<td>작성자</td>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=dto.getReadcount()%></td>
</tr>
<tr>
	<td>제목</td>
	<td><input type="text" name="title"  size="50" value="<%=dto.getTitle() %>" class="inputtextcss"> </td>
</tr>
<tr>
	<td>내용</td>
	
	<td>
	<textarea rows="10" cols="50" name="content" class="textareacss"><%=dto.getContent() %></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" class="testbordernon">
	<input type="submit" value="수정" class="buttoncss" onclick="return confirm('글을 수정하시겠습니까?');">
	</td>
</tr>
</table>
</form>
<a href="bbs_notice_list.jsp">글 목록 돌아가기 </a>
</body>
</html>