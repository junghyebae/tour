<%@page import="bbs.BbsDto_notice"%>
<%@page import="bbs.BbsDao_notice"%>
<%@page import="bbs.iBbsDao_notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지삭제</title>
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim()); 
iBbsDao_notice dao = BbsDao_notice.getInstance();
%>
<% boolean isS= dao.notice_del(seq);

if(isS){%>
<script type="text/javascript">
	  alert("글 삭제성공"); 
	  location.href="../main/index.jsp?showPage=notice";
</script>
<%} else{ %>
<script type="text/javascript">
	alert("삭제 실패 "); 
	location.href="../main/index.jsp?showPage=notice";
</script>
<%} %>



</body>
</html>