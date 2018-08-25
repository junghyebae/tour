<%@page import="mem.MemberDto"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>질문 답변달기</title>
<link rel="stylesheet" type="text/css" href="../bbs_cs/answer.css">
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
iBbsDao_cs dao = BbsDao_cs.getInstance();
BbsDto_cs dto = dao.cs_detail(seq);
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
<% // login session
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>


<form action="../bbs_cs/bbs_cs_answerAf.jsp" class=formm>
<input type="hidden" value="1" name="process">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">
<input type="hidden" value="<%=dto.getCATEGORY() %>" name="category">
<input type="hidden" value="<%=dto.getSECRET() %>" name="secret">
<input type="hidden" value="<%=dto.getID() %>" name="parent_id">
<input type="hidden" value="<%=mem.getId() %>" name="id">
	<hr>
	<h2>상담게시판</h2>
	<a href="../main/index.jsp?showPage=cs">돌아가기</a> 
	<hr>

<table>
<tr>
	<th>아이디ㅣ<%=mem.getId() %></th>
	<th>분류ㅣ<%=category%></th>
	<th>공개여부ㅣ<%=secret %></th>
</tr>
<tr>	
	<td>제목</td>
	<td colspan="2"><input type="text" name="title" value="답변입니다" class="inputtextcss"></td>
</tr>
<tr>
	<td>내용</td>
	<td colspan="2"><textarea rows="10" cols="50" name="content" class="textareacss">
	------문의사항 : 
	제목:<%=dto.getTITLE() %>
	내용:<%=dto.getCONTENT()%>
	--------
	</textarea></td>
</tr>
<tr>
	<td colspan="3" class="testbordernone" >
		<input type="submit" value="답변달기" class="buttoncss">
	</td>
</tr>
</table>		
</form>


</body>
</html>