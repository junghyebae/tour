<%@page import="bbs.BbsDto_notice"%>
<%@page import="bbs.BbsDao_notice"%>
<%@page import="bbs.iBbsDao_notice"%>
<%@page import="mem.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지보기</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">

</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
iBbsDao_notice dao = BbsDao_notice.getInstance();
dao.notice_readcount(seq);
BbsDto_notice dto = dao.notice_detail(seq);
BbsDto_notice pre_dto = dao.notice_pre_detail(seq);//이전글
BbsDto_notice next_dto = dao.notice_next_detail(seq);//다음글
%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>
<%!
public String Dates(String mdate){

	String s = mdate.substring(0, 9) ;
	return s;
}
%>

<div>

<form class=formm>
 <input type="hidden" name="showPage" value="notice_detail">
    <hr>
 
	<h1>공지게시판</h1>
	<%=dto.getSeq() %>
	<a href="../main/index.jsp">HOME</a>
	<hr>
	<div style="width: 100%" align="right">
		<%if(mem.getAuth()==1) {%>
			<a href="../main/index.jsp?seq=<%=dto.getSeq()%>&showPage=notice_update"><button type="button" class="buttoncss">글수정</button></a>
			<a href="../bbs/bbs_notice_del.jsp?seq=<%=dto.getSeq() %>" onclick="return confirm('글을 삭제하시겠습니까?');"><button type="button" class="buttoncss">글삭제</button></a>
		<%} %>
	</div>

<table cellspacing="0" class="tableform" >
<col width="700"><col width="100">
<tr>
	<th><%=dto.getTitle() %></th>
	<th>관리자</th>
	<th>작성일ㅣ<%=Dates(dto.getWdate()) %></th>
	<th>조회수ㅣ<%=dto.getReadcount() %></th>
</tr>
<tr>
	<td colspan="4" class="testbordernone">
		<textarea readonly="readonly" style="width: 100%" rows="20"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>

<table class="tableform">
<col width="100"><col width="500">
<tr>
	<td style="background-color: #f6f4f1" class="test1">이전글</td>
	<td class="test1">
	<%if(pre_dto==null){%>
		이전글이 존재하지 않습니다
    <% }else{%>	
		<a href="../main/index.jsp?showPage=notice_detail&seq=<%=pre_dto.getSeq() %>"><%=pre_dto.getTitle() %></a>
	<%} %>
	</td>
</tr>
<tr>
	<td style="background-color: #f6f4f1">다음글</td>
	<td class="test1">
	<%if(next_dto==null){%>
		다음글이 존재하지 않습니다
    <% }else{%>	
		<a href="../main/index.jsp?showPage=notice_detail&seq=<%=next_dto.getSeq() %>"><%=next_dto.getTitle() %></a>
	<%} %>
	</td>
</tr>
</table>

</form>

</div>

</body>
</html>