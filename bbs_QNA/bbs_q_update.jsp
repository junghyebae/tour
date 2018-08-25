<%@page import="bbs_QNA.BbsDto_QNA"%>
<%@page import="bbs_QNA.BbsDao_QNA"%>
<%@page import="bbs_QNA.iBbsDao_QNA"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자주하는질문수정</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">

</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

iBbsDao_QNA dao = BbsDao_QNA.getInstance();
BbsDto_QNA dto = dao.q_detail(seq);

%>

<form action="../bbs_QNA/bbs_q_updateAf.jsp" method="post" class=formm>
 <hr> 
 <h1>자주하는질문 <span class="font"> 수정하기 </span> </h1>
 <a href="../main/index.jsp?">HOME </a>
 <a href="../main/index.jsp?showPage=qna">글목록 돌아가기</a> 
 <hr>
<input type="hidden" name="seq" value=<%=dto.getSeq() %>> 
<table class="tableform">
<col width="200"><col width="500">
<tr>
<td class="test1">분류</td>
<td class="test1">
	<select class="optioncss"  name="qgroup">
		<option value="1" <%=dto.getQgroup()==1?"selected='selected'":"" %>>회원가입</option>
		<option value="2" <%=dto.getQgroup()==2?"selected='selected'":"" %>>항공권</option>
		<option value="3" <%=dto.getQgroup()==3?"selected='selected'":"" %>>호텔</option>
	 </select>
</td>
</tr>
<tr>
	<td>질문</td>
	<td>
		<input type="text" name="title" size="50" value="<%=dto.getTitle()%>">
	</td>
</tr>
<tr>
	<td>답변</td>
	<td>	
		<textarea rows="10" cols="50" name="content" style="width:375px" ><%=dto.getContent() %></textarea>		
	</td>
</tr>
	<td colspan="2">
	<input type="submit" value="수정하기" class="buttoncss">
	</td>
</table>
</form>

</body>
</html>