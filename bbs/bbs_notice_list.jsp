<%@page import="paging.PagingBean"%>
<%@page import="mem.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="bbs.BbsDto_notice"%>
<%@page import="bbs.BbsDao_notice"%>
<%@page import="bbs.iBbsDao_notice"%>
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
<title>공지게시판</title>
</head>
<body>
<%
String findWord ="";
findWord = request.getParameter("findWord");
System.out.println("찾는단어 notice"+findWord);
%>
<%
PagingBean paging = new PagingBean(); //페이징dto
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}
else{
	int currentPage = Integer.parseInt(
			request.getParameter("nowPage"));
	paging.setNowPage(currentPage);
}
%>
<%
iBbsDao_notice dao = BbsDao_notice.getInstance();
if(findWord == null) findWord = "";
List<BbsDto_notice> bbslist = dao.getBbsPagingList(paging, findWord);
%>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>

<form action="../main/index.jsp" class=formm>
 	<input type="hidden" name="showPage" value="notice">
	<hr>
	<h1>공지게시판</h1>
	<a href="../main/index.jsp">HOME</a>
	<hr>

<div style="width: 100%" align="right">
    <input type="text" name="findWord" class="findwordcss">
    <input type="submit" value="검색" class="buttoncss">
    <%if(mem.getAuth()==1) {%>
	<a href="../main/index.jsp?id=<%=mem.getId() %>&showPage=notice_write"><button type="button" class="buttoncss">글쓰기</button></a>
     <%} %> 
</div>


<table class="tableform">
<col width="100"> <col width="400"> <col width="200"> <col width="200">
<tr>  <th>순서</th><th>제목</th><th>조회수</th><th>작성자</th>  </tr>

<%if(bbslist.size()==0){ %>
	<tr align="center" > <th colspan="4">해당 항목이 존재하지 않습니다.</th> </tr>
<%} %>


<% 		
for(int i=0; i<bbslist.size(); i++){
	BbsDto_notice bbs = bbslist.get(i);%>
	<tr> 
	<td><%=i+1%> </td>
	<td>
		<a href="../main/index.jsp?seq=<%=bbs.getSeq() %>&showPage=notice_detail"> 
		<%=bbs.getTitle() %>
		</a>
	</td>
	<td><%=bbs.getReadcount() %></td>
	<td>관리자</td>
	</tr>
<% }%>
</table>

</form>


<div align="center">
<jsp:include page="notice_paging.jsp">
	<jsp:param value="index.jsp" name="actionPath"/>
	<jsp:param value="notice" name="listType"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>




<script type="text/javascript">
function searchBbs() {	
	var msg = document.getElementById("search").value;
	location.href = "../main/index.jsp?showPage=notice&findWord=" + msg;
}

</script>


</body>
</html>