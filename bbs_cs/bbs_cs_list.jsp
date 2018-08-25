<%@page import="paging.PagingBean"%>
<%@page import="mem.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="jdbc.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% DBConn.initConnect(); 
request.setCharacterEncoding("UTF-8");%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상담게시판</title>
</head>

<body>
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
<% //페이징
PagingBean paging = new PagingBean();
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}else{
	paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));	
}
%>
<% //검색
String findWord ="";
String category = "";
String findId = "";
findWord = request.getParameter("findWord");
category = request.getParameter("category");
findId = request.getParameter("findId");
%>
<% 
iBbsDao_cs dao = BbsDao_cs.getInstance();
if(category == null || category.equals("0")) category = "";
if(findWord == null) findWord = "";
if(findId == null) findId = "";
List<BbsDto_cs> bbslist = dao.cs_PagingList(paging, findWord, category);

%>
<% // login session
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>

<form action="../main/index.jsp" class=formm>
	<input type="hidden" name="showPage" value="cs">
	<hr>
	<h1>상담게시판</h1> 
	<a href="../main/index.jsp">HOME</a>
	<hr>
<div style="width: 100%" align="right">
   <select name="category" class="optioncss">
    	<option value="0">검색</option>
    	<option value="1">회원가입</option>
    	<option value="2">항공권</option>
    	<option value="3">호텔</option>
    	<option value="4">기타</option>
    </select>
    <input type="text" name="findWord" class="findwordcss">
    <input type="submit" value="검색" class="buttoncss">
    	<%if(!(mem.getId().equals(""))) {  //비회원 아닐경우만 상담 글쓰기 가능   %> 
		<a href=../main/index.jsp?showPage=cs_write&id=<%=mem.getId() %>><button type="button" class="buttoncss">글쓰기</button></a>
		<a href=../main/index.jsp?showPage=myCs><button type="button" class="buttoncss1">내가쓴글보기</button></a>
	<%}else{ %>
		<a href=../main/index.jsp?showPage=login onclick="nonMem"><button type="button" class="buttoncss">글쓰기</button></a>
	<%} %>
</div>



<table cellspacing="0" class="tableform">
	<tr> 
		<th>순서</th><th>분류</th><th width="400">제목</th>
     	<th>조회수</th><th>답변</th><th>공개여부</th><th>아이디</th>
	</tr>
	
<%if(bbslist.size()==0){ %>
	<tr align="center" > <th colspan="7">해당 항목이 존재하지 않습니다.</th> </tr>
<%} %>
	

<%  
String process="";
String secret="";

for(int i =0; i<bbslist.size(); i++){
	BbsDto_cs bbs = bbslist.get(i);

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
		<td><%=i+1%></td> 
		<td><%=category %></td>
		<td style="text-align: left; padding-left: 50px" >
        	<%=arrow(bbs.getDEPTH()) %>
			<% if((bbs.getDEL())==1){ %> 
			삭제 된 글입니다
			<%}else { %>
				<%if(bbs.getParent_id().equals(mem.getId()) || bbs.getSECRET()==1 || mem.getAuth()==1) { %>  
					<a href="../main/index.jsp?seq=<%=bbs.getSeq()%>&showPage=cs_detail"><%=bbs.getTITLE()%></a>
				<%}else { %>
					<%=bbs.getTITLE() %>
					<img src='../bbs_cs/s.png' width='15px' height='15px'/>
					
				<%} %>
		<%} %>
		</td>
		<td><%=bbs.getREADCOUNT()%></td>
		<td>
			<%if(process.equals("답변완료")){ %>
				<%if(bbs.getID().equals("admin")){ %>
					<p style="color: gray;">-</p>
				<%}else{ %>
				<p style="color: green">답변완료</p>
				<%} %>
			<%}else{ %>
				<p style="color: blue"><%=process%></p>
			<%} %>
		</td>
		<td><%=secret %></td>
		<td>
		<%if(bbs.getID().equals("admin")){ %>
			관리자<%}else{ %>
		<%=bbs.getID() %>
		<%} %>
		</td>
	</tr>
	
<%}  %>

</table>

</form>

<div align="center">
<jsp:include page="cs_paging.jsp">
	<jsp:param value="index.jsp" name="actionPath"/>
	<jsp:param value="cs" name="listType"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>



<script type="text/javascript">
function searchBbs() {	
	var msg = document.getElementById("search").value;
	location.href = "bbslist.jsp?findWord=" + msg;
}

</script>



</body>
</html>