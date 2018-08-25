<%@page import="admin.PackageDto"%>
<%@page import="java.util.List"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="paging.PagingBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center">상품 정보 리스트</h1>

<%
request.setCharacterEncoding("utf-8");
%>
<!-- 페이징 -->
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
//리스트가져오기
IPackageDao dao = PackageDao.getInstance();
List<PackageDto> packlist = dao.packageList(paging);
%>
<%
//검색
%>
<!-- 테이블 생성 -->
<div align="center">
<form action="index.jsp">
<table border="1" cellpadding="8px">
<col width="50"><col width="230"><col width="200">
<col width="100"><col width="150"><col width="100">
<col width="100">><col width="50">
<!-- header -->
<thead>
	<tr>
		<th>번호</th>
		<th>상품명</th> 
		<th>상품가격</th> 
		<th>일정</th>
		<th>도시</th> 
		<th>상품조회수</th> 
		<th>상품구매수</th>
		<th>삭제</th> 
	</tr>
</thead>

<tbody>
<%
System.out.println("packlist.size() ="+packlist.size());
if(packlist ==null || packlist.size()==0){
	%>
	<tr>
		<td colspan="9" align="center"> 데이터가 없습니다. </td>
	</tr>
	<%
}
//데이터가 존재
for(int i=0; i<packlist.size(); i++){
	PackageDto dto = packlist.get(i);
	%>
	<!-- 테이블 열생성 -->
	<tr>
		<!-- 1.번호 -->
		<%
		//번호정보
		if(request.getParameter("nowPage")==null){
			int nowPage = 1;
			%>
			<td><%=(i+1)+((nowPage-1)*10)%>번</td>
			<%
		}
		else{
			int nowPage = Integer.parseInt(request.getParameter("nowPage"));
			%>
			<td><%=(i+1)+((nowPage-1)*10)%>번</td>
			<%
		}
		%>
		<!-- 2.상품명 -->
		<td><%=dto.getP_name()%></td>
		<!-- 3.가격 -->
		<td><%=dto.getP_price()%></td>
		<!-- 4.일정 -->
		<td><%=dto.getP_schedule()%></td>
		<!-- 5.도시 -->
		<td><%=dto.getP_country()%></td>
		<!-- 6.조회수-->
		<td><%=dto.getP_readcount()%></td>
		<!-- 7.구매수 -->
		<td><%=dto.getP_buycount()%></td>
		<!-- 9.삭제버튼 -->
		<td>			
			<input type="hidden" name="showPage" value="removePackage">
			<input type="hidden" name="p_num" value="<%=dto.getP_num()%>">
			<input type="submit" value="삭제" >
		</td>
	</tr>
	
	<%
}
%>
</tbody>
</table>
</form>
</div>

<!-- paging Include -->
<div align="center">
<jsp:include page="paging.jsp">
	<jsp:param value="index.jsp" name="actionPath"/>
	<jsp:param value="package" name="listType"/>
	<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>" />
	<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>" />
	<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>" />
	<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>" />
</jsp:include>
</div>
</body>
</html>












