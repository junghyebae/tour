<%@page import="admin.PackageDto"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
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
request.setCharacterEncoding("utf-8");
%>
<%
//return값 받아오기
String ttype = request.getParameter("ttype");
String typepackage = request.getParameter("typepackage");
%>
<!-- 상품정보 가져오기 -->
<%
IPackageDao dao = PackageDao.getInstance();
PackageDto dto = dao.reservePackList(typepackage);

if(ttype.equals("package") && dto !=null){
	%>
	<h2  align="center">상품 상세 정보</h2>
	<hr>
	<table border="1" align="center">
	<col width="150"><col width="200">
	<!-- 상품번호 -->
	<tr>
		<th>상품번호</th>
		<th><%=dto.getP_num()%></th>
	</tr>
	<!-- 상품명 -->
	<tr>
		<th>상품명</th>
		<th><%=dto.getP_name()%></th>
	</tr>
	<!-- 상품원가 -->
	<tr>
		<th>상품원가</th>
		<th><%=dto.getP_price()%></th>
	</tr>
	<!-- 일정 -->
	<tr>
		<th>일정</th>
		<th><%=dto.getP_schedule()%></th>
	</tr>
	<!-- 도시이름-->
	<tr>
		<th>도시명</th>
		<th><%=dto.getP_country()%></th>
	</tr>
	<!-- 조회수 -->
	<tr>
		<th>상품조회수</th>
		<th><%=dto.getP_readcount()%></th>
	</tr>
	<!-- 구매수 -->
	<tr>
		<th>구매수</th>
		<th><%=dto.getP_buycount()%></th>
	</tr>
	<!-- 평점 -->
	<tr>
		<th>평점</th>

		<th>
		<%
		long heart=0;
		if(dto.getP_buycount()==0){
			%>
			0점
			<%
		}
		else{
		heart = Math.round(dto.getP_like()/dto.getP_buycount());
		%>
			<%=heart%>점
		<%
		}
		%>
		
		</th>
	</tr>
	</table>
	<%
}
%>
</body>
</html>





