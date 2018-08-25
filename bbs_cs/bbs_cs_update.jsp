<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상담수정</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
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

//처리 여부
if(dto.getPROCESS().equals("0")){
	process="답변중";
}else if(dto.getPROCESS().equals("1")){
	process="답변완료";
}


%>

<form action="../bbs_cs/bbs_cs_updateAf.jsp" method="post" class=formm>
<hr>
<h1>상담게시판<span class="font">수정하기</span></h1> 
	<a href="../main/index.jsp">HOME</a>
	<a href="../main/index.jsp?showPage=cs">글 목록 돌아가기 </a>
<hr>
	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	
<table class="tableform">
	<col width="200"><col width="500">
<tr>
	<td>아이디</td>
	<td><%=dto.getID() %></td>
</tr>
<tr>
	<td>분류</td>
	<td>
	<select name="category" class="optioncss">
		<option value="1" <%=dto.getCATEGORY().equals("1")?"selected='selected'":"" %>>회원가입</option>
		<option value="2" <%=dto.getCATEGORY().equals("2")?"selected='selected'":"" %>>항공권</option>
		<option value="3" <%=dto.getCATEGORY().equals("3")?"selected='selected'":"" %>>호텔</option>
		<option value="4" <%=dto.getCATEGORY().equals("4")?"selected='selected'":"" %>>기타</option>
	 </select>
    </td>
</tr>
<tr>
	<td>공개여부</td>
	<td><input type="radio" name="secret" value="1"  checked="checked">공개
        <input type="radio" name="secret" value="2" >비공개</td>
</tr>
<tr>	
	<td>제목</td>
	<td><input type="text" value="<%=dto.getTITLE() %>" name="title"></td>
</tr>
<tr>
	<td>내용</td>
	<td><textarea class="textareacss" name="content"><%=dto.getCONTENT() %></textarea></td>
</tr>
<tr>
	<td colspan="2" class="testbordernone" >
	<input type="submit" value="수정하기" class="buttoncss">
	</td>
</tr>
</table>
</form>



</body>
</html>