<%@page import="bbs.BbsDto_notice"%>
<%@page import="bbs.BbsDao_notice"%>
<%@page import="bbs.iBbsDao_notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>writeAf.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String title = request.getParameter("title"); 
String content = request.getParameter("content");

iBbsDao_notice dao = BbsDao_notice.getInstance();
boolean isS= dao.notice_write(new BbsDto_notice(id,title,content));
if(isS){%>
	<script type="text/javascript">
	alert("글 입력 성공"); 
	location.href="../main/index.jsp?showPage=notice";
	</script>
<%}else{ %>
	<script type="text/javascript">
	alert("다시입력하십시오");
	location.href="../main/index.jsp?showPage=notice";
	</script>
<%} %>

</body>
</html>