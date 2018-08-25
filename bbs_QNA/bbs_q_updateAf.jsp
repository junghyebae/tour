<%@page import="bbs_QNA.BbsDto_QNA"%>
<%@page import="bbs_QNA.BbsDao_QNA"%>
<%@page import="bbs_QNA.iBbsDao_QNA"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8");%>
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
String title = request.getParameter("title"); 
String content = request.getParameter("content");
String qqgroup = request.getParameter("qgroup");
int qgroup = Integer.parseInt(qqgroup); 

iBbsDao_QNA dao = BbsDao_QNA.getInstance();
boolean isS= dao.q_update(seq, title, content, qgroup);

if(isS){%>
	<script type="text/javascript">
	alert("글 수정 성공"); 
	location.href="../main/index.jsp?showPage=qna";
	</script>
<%}else{ %>
	<script type="text/javascript">
	alert("다시입력하십시오");
	location.href="../main/index.jsp?showPage=qna";
	</script>
<%} %>

</body>
</html>