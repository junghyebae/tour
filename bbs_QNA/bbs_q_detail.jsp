<%@page import="bbs_QNA.BbsDto_QNA"%>
<%@page import="bbs_QNA.BbsDao_QNA"%>
<%@page import="bbs_QNA.iBbsDao_QNA"%>
<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자주하는질문디테일</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
iBbsDao_QNA dao = BbsDao_QNA.getInstance();
BbsDto_QNA dto = dao.q_detail(seq);
BbsDto_QNA pre_dto = dao.q_pre_detail(seq);
BbsDto_QNA next_dto = dao.q_next_detail(seq);
%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>


<form class=formm>
 <hr> 
 <h1>자주하는질문 <span class="font"> 상세보기 </span> </h1>
 <a href="../main/index.jsp?showPage=qna">HOME</a> 
 <hr>
<br><br>
	<div style="width: 100%" align="right">
		<%if(mem.getAuth()==1) { %>
		<a href="../main/index.jsp?seq=<%=dto.getSeq()%>&showPage=qna_update"><button type="button" class="buttoncss">글수정</button></a>
		<a href="../bbs_QNA/bbs_q_del.jsp?seq=<%=dto.getSeq() %>" onclick="return confirm('글을 삭제하시겠습니까?');"><button type="button" class="buttoncss">글삭제</button></a>
		<%} %>
</div>
<table class="tableform">
<col width="200"><col width="500">
<tr>
	<th>제목</th>
	<th><%=dto.getTitle() %></th>
</tr>
<tr>
	<th>내용</th>
	<th>
	<textarea class="textareacss" readonly="readonly"><%=dto.getContent() %></textarea>
	</th>
</tr>
</table>
<br>
<table width="100%">
<col width="200"><col width="500">
<tr>
	<td style="background-color: #f6f4f1" class="test1">이전글</td>
	<td class="test1">
	<%if(pre_dto==null){%>
		이전글이 존재하지 않습니다
    <% }else{%>	
		<a href="../main/index.jsp?showPage=qna_detail&seq=<%=pre_dto.getSeq() %>"><%=pre_dto.getTitle() %></a>
	<%} %>
	</td>
</tr>
<tr>
	<td style="background-color: #f6f4f1" class="test1">다음글</td>
	<td class="test1">
	<%if(next_dto==null){%>
		다음글이 존재하지 않습니다
    <% }else{%>	
		<a href="../main/index.jsp?showPage=qna_detail&seq=<%=next_dto.getSeq() %>"><%=next_dto.getTitle() %></a>
	<%} %>
	</td>
</tr>
</table>

</form>


</body>
</html>