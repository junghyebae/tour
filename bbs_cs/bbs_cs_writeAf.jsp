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
<title>Insert title here</title>
</head>
<body>
<%
String id = request.getParameter("id");
String title = request.getParameter("title"); 
String content = request.getParameter("content");
String process = request.getParameter("process");
String ssecret = request.getParameter("secret");
int secret = Integer.parseInt(ssecret);
String category = request.getParameter("category");
String parent_id = request.getParameter("parent_id");
System.out.println("----------------------------------- : "  +parent_id);

iBbsDao_cs dao = BbsDao_cs.getInstance();
boolean isS = dao.cs_write(new BbsDto_cs(id, title, content, process, category, secret, parent_id));
if(isS){
%>
<script type="text/javascript">
alert("글 입력 성공"); 
location.href="../main/index.jsp?showPage=cs";
</script>
<%}else{ %>
<script type="text/javascript">
alert("다시입력하십시오");
location.href="../main/index.jsp?showPage=cs";
</script>
<%} %>
</body>
</html>