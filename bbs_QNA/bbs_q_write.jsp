<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자주하는질문작성</title>
<link rel="stylesheet" type="text/css" href="../bbs/bbs_style.css">
</head>
<body>
<%request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
System.out.print("id");
%>

<form action="../bbs_QNA/bbs_q_writeAf.jsp" method="post" class=formm>
 <hr> 
 <h1>자주하는질문 <span class="font"> 글쓰기 </span> </h1>
 <a href="../main/index.jsp?">HOME </a>
 <a href="../main/index.jsp?showPage=qna">글목록 돌아가기</a> 
 <hr>
<table class="tableform">
<col width="200"><col width="500">
<tr>
	<td>작성자</td>
	<td>
		<%
			if(id == null){
		%>
		<input type="text" name="id" readonly="readonly" size="50" value="없다." class="inputtextcss"> 
		
		<%
			}else {
		%>
		<input type="text" name="id" readonly="readonly" size="50" value="<%=id%>" class="inputtextcss"> 
		<%
			}
		%>
	</td>
</tr>
<tr>
<td>분류</td>
<td>
	<select name="qgroup" class="optioncss">
		<option value="1">회원가입</option>
		<option value="2" >항공권</option>
		<option value="3">호텔</option>
	</select>
</td>
</tr>
<tr>
	<td>질문</td>
	<td>
		<input type="text" name="title" size="50" class="inputtextcss">
	</td>
</tr>
<tr>
	<td>답변</td>
	<td>	
		<textarea  name="content"  class="textareacss"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
	<input type="submit" value="글쓰기" class="buttoncss">
	</td>
</tr>
</table>
</form>




</body>
</html>