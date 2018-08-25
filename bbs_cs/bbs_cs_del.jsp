<%@page import="bbs_CS.BbsDto_cs"%>
<%@page import="bbs_CS.BbsDao_cs"%>
<%@page import="bbs_CS.iBbsDao_cs"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>질문삭제</title>
</head>
<body>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

iBbsDao_cs dao = BbsDao_cs.getInstance();
boolean isS = dao.cs_del(seq);
if(isS){ %>
	<script type="text/javascript">
	  alert("글 삭제 성공"); 
	  location.href="../main/index.jsp?showPage=cs";
	</script>
<%}else{ %>
	<script type="text/javascript">
	  alert("글 삭제 실패"); 
	  location.href="../main/index.jsp?showPage=cs";
	</script>
<%} %>
</body>
</html>