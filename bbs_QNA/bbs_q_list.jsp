<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@page import="paging.PagingBean"%>

<%@page import="mem.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="bbs_QNA.BbsDto_QNA"%>
<%@page import="bbs_QNA.BbsDao_QNA"%>
<%@page import="bbs_QNA.iBbsDao_QNA"%>
<%@page import="jdbc.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% DBConn.initConnect(); 
request.setCharacterEncoding("UTF-8");%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
<head>
<!-- <style type="text/css">
.answer, tr{
	hover
}
</style> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자주하는질문</title>
</head>
<body>
<%!
public String dot3(String msg){
	String s ="";
	if(msg.length()>=20){
		s = msg.substring(0,20);
		s +="...";
	}else {
		s = msg.trim();
	}
	return s;
}


%>
<%//페이징
PagingBean paging = new PagingBean();
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}else{
	paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));	
}
%>

<% //검색
String findWord ="";
findWord = request.getParameter("findWord");
System.out.println("----------------qna :" + findWord);
%>

<% 
// 버튼 눌렀을때 카테고리별로 리스트 보여주기 위해서 
String button_group= request.getParameter("button_group");
System.out.println("q_list.jsp 버튼 번호  : "+button_group);

iBbsDao_QNA dao = BbsDao_QNA.getInstance();
List<BbsDto_QNA> bbslist;

if(findWord == null) findWord = "";
if(button_group== null || button_group.equals("")) button_group = "1" ; //카테고리 버튼 안 눌렀을 땐 회원가입qna 보여준다. 버튼 누르면 button_group
bbslist = dao.p_PagingList(paging, findWord, button_group);
%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem==null){
	mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
}
%>


<form action="../main/index.jsp" class=formm>
	 <input type="hidden" name="showPage" value="qna">
	 <hr>
	 <h2>자주하는질문</h2>
	 <a href="../main/index.jsp" >HOME</a>
	 <hr>
<br>
<div style="width: 100%" align="right">
<button name="button_group" value="1" class="buttongroupcss">회원가입</button>
<button name="button_group" value="2" class="buttongroupcss">항공권</button>
<button name="button_group" value="3" class="buttongroupcss">호텔</button>
 <%if(mem.getAuth()==1) {%>
	 <a href="../main/index.jsp?id=<%=mem.getId() %>&showPage=qna_write"><button type="button" class="buttoncss1">글쓰기</button></a>
	 <%} %>
</div>
	
<br>
<%if (button_group.equals("1")){%>
<h3>회원가입 QNA</h3>
<%}else if(button_group.equals("2")){ %>
<h3>항공권 QNA</h3>
<%}else if(button_group.equals("3")){ %>
<h3>호텔 QNA</h3>
<%} %>
<table class="tableform" >
<col width="50"> <col width="500">
<tr class='test'>  <th>순서</th><th>제목</th>  </tr>
<%if(bbslist.size()==0){ %>
	<tr align="center" > <th colspan="2">해당 항목이 존재하지 않습니다.</th> </tr>
<%} %>

<% 		
for(int i=0; i<bbslist.size(); i++){
	BbsDto_QNA bbs = bbslist.get(i);
	%>
	
	<tr align="center"> 
	<td style="font-size:20px ;color: #0191C8";><b> Q </b></td> 
	<td>
		<div onclick="content(<%=bbs.getSeq()%>)">
			<%=bbs.getTitle() %>
		</div>
	</tr>
	<tr style="display: none" id=<%=bbs.getSeq() %>>
	<td style="font-size:20px ;color: #74C2E1";><b> A</b></td>
	<td>
			<%=dot3(bbs.getContent()) %> <br><br>
		   <a href="../main/index.jsp?seq=<%=bbs.getSeq() %>&showPage=qna_detail" style="text-align: right; color: gray" >상세보기 </a>
	</td>
	</tr>
<% }%>
</table>
</form>

<form action="../main/index.jsp" class="formm" style="width: 100%" align="right">
	<input type="text" name="findWord" class="findwordcss">
	<input type="hidden" name="showPage" value="qna">
	<input type="hidden" value="<%=button_group %>" name="button_group">
	<input type="submit" value="검색" class="buttoncss">
</form>

<div align="center">
<jsp:include page="q_paging.jsp">
	<jsp:param value="index.jsp" name="actionPath"/>
	<jsp:param value="qna" name="listType"/>
	<jsp:param value="<%=button_group %>" name="button_group"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>

<script type="text/javascript">
function content(n) {
	v = n;
	$("#"+v).slideToggle("fast");
}
</script>


</body>
</html>