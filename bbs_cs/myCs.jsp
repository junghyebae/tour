<%@page import="paging.PagingBean"%>
<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="java.util.List"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@page import="mem.MemberDto"%>
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

<% //페이징
PagingBean paging = new PagingBean(); 
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}else{
	paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));	
}
%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");

iBbsDao_cs dao = BbsDao_cs.getInstance();
List<BbsDto_cs> list = dao.getMylist(paging, mem.getId());
%>

<%!//댓글 화살표 표시
public String arrow(int depth){ 
	String rs = "<img src='../bbs_cs/arrow.png' width='20px' height='20px'/>";
	String nbsp = "&nbsp;&nbsp;" ;
	String ts="";
	for(int i=0 ; i<depth; i++){
		ts += nbsp; 
	}
	return depth == 0 ? "" : ts+rs;    
}
%>
<form class=formm> 
<hr>
<h2>상담게시판</h2> 
<a href="../main/index.jsp">HOME</a>
<hr>
<div style="width: 100%" align="right">
<a href="../main/index.jsp?showPage=cs"><button type="button" class="buttoncss1">글목록돌아가기</button></a>
</div>

<table class="tableform">
	<tr> 
		<th>순서</th><th>분류</th><th>제목</th>
     	<th>조회수</th><th>답변</th><th>공개여부</th><th>아이디</th>
	</tr>
<%if(list.size()==0){ %>
	<tr align="center" > <th colspan="7">해당 항목이 존재하지 않습니다.</th> </tr>
<%}else{
	
String process="";
String secret="";
String category="";

for(int i =0; i<list.size(); i++){
	BbsDto_cs bbs = list.get(i);

	//카테고리 분류 
	if(bbs.getCATEGORY().equals("1")){
		category ="회원가입";
	}else if(bbs.getCATEGORY().equals("2")){
		category="항공권";
	}else if(bbs.getCATEGORY().equals("3")){
		category="호텔";
	}else{
		category="기타";
	}
	
	//처리 여부
	if(bbs.getPROCESS().equals("0")){
		process="답변중";
	}else if(bbs.getPROCESS().equals("1")){
		process="답변완료";
	}
	
	//비공개 여부
	if(bbs.getSECRET()==1){
		secret="공개";
	}else if(bbs.getSECRET()==2){
		secret="비공개";
	}

%>
	<tr>
		<td align="center"><%=i%></td> 
		<td align="center"><%=category %></td>
		<td style="padding-left: 30px">
        	<%=arrow(bbs.getDEPTH()) %>
			<% if((bbs.getDEL())==1){ %> 
			삭제 된 글입니다
			<%}else { %>
				<a href="../main/index.jsp?seq=<%=bbs.getSeq()%>&showPage=cs_detail"><%=bbs.getTITLE()%></a>
			<%} %> 
		</td>
		<td align="center" ><%=bbs.getREADCOUNT()%></td>
		<td align="center">
			<%if(process.equals("답변완료")){ %>
				<div onclick="content(<%=bbs.getSeq()%>)" style="color: green">답변완료</div>
			<%}else{ %>
				<p style="color: blue"><%=process%></p>
			<%} %>
		</td>
		<td align="center"><%=secret %></td>
		<td><%=mem.getId()%></td>
	</tr>
	
<%} 
}%>
</table>
</form>
<jsp:include page="../bbs_cs/myCs_paging.jsp">   
   <jsp:param name="actionPath" value="../main/index.jsp" />
   <jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>"/>
   <jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
   <jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
   <jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>

</body>
</html>