
<%@page import="bbs_QNA.BbsDao_QNA"%>
<%@page import="bbs_QNA.iBbsDao_QNA"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim()); 
iBbsDao_QNA dao = BbsDao_QNA.getInstance();
%>
<% boolean isS= dao.q_del(seq);

if(isS){%>
<script type="text/javascript">
	  alert("글 삭제성공"); 
	  location.href="../main/index.jsp?showPage=qna";
</script>
<%} else{ %>
<script type="text/javascript">
	alert("삭제 실패 "); 
	location.href="../main/index.jsp?showPage=qna";
</script>
<%} %>삭제

</body>
</html>