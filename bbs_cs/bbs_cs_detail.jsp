<%@page import="mem.MemberDto"%>
<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
iBbsDao_cs dao = BbsDao_cs.getInstance();
dao.cs_readcount(seq);
BbsDto_cs dto = dao.cs_detail(seq);
%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>

<% //category, process, secret
String category="";
String process="";
String secret="";

//카테고리 분류 
if(dto.getCATEGORY().equals("1")){
	category ="회원가입";
}else if(dto.getCATEGORY().equals("2")){
	category="항공권";
}else if(dto.getCATEGORY().equals("3")){
	category="호텔";
}else{
	category="기타";
}

//처리 여부
if(dto.getPROCESS().equals("0")){
	process="답변중";
}else if(dto.getPROCESS().equals("1")){
	process="답변완료";
}

//비공개 여부
if(dto.getSECRET()==1){
	secret="공개";
}else if(dto.getSECRET()==2){
	secret="비공개";
}
%>

<form class=formm>
	<hr>
	<h1>상담게시판</h1>
	<a href="../main/index.jsp?showPage=cs">돌아가기</a> 
	<hr>
	<div style="width: 100%" align="right">
		<%if(mem.getId().equals(dto.getID())){  // 자신의 글만 수정 삭제 가능 %>
			<a href="../main/index.jsp?seq=<%=dto.getSeq()%>&showPage=cs_update "><button type="button" class="buttoncss">글수정</button></a>
			<a href="../bbs_cs/bbs_cs_del.jsp?seq=<%=dto.getSeq() %>" onclick="return confirm('글을 삭제하시겠습니까?');"><button type="button" class="buttoncss">글삭제</button></a>
		<%} %>
		<%if(mem.getAuth()==1) { // 관리자만 답변 가능 %>
			<a href="../main/index.jsp?seq=<%=dto.getSeq() %>&showPage=cs_answer"><button type="button" class="buttoncss">답변</button></a>
		<%} %>
</div>

<table class="tableform">
<tr>
	<th>아이디ㅣ<%=dto.getID() %></th>
	<th>분류ㅣ<%=category%></th>
	<th>조회수ㅣ<%=dto.getREADCOUNT() %></th>
	<th>답변ㅣ<%=process %></th>
	<th>공개여부ㅣ<%=secret %></th>
</tr>
<tr>	
	<td><b>제목</b></td>
	<td colspan="4"><b><%=dto.getTITLE() %></b></td>
</tr>
<tr>
	<td>내용</td>
	<td colspan="4"><textarea rows="15" cols="60" readonly="readonly"><%=dto.getCONTENT() %></textarea></td>
</tr>
</table>	

</form>
</body>
</html>