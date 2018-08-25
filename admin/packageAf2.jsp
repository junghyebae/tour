<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="admin.PackageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//값받아오기
String p_name = request.getParameter("p_name");
System.out.println("packageAf2의 p_name: " + p_name);
long p_price = Long.parseLong(request.getParameter("p_price"));
String p_schedule = request.getParameter("p_schedule")+"일";
System.out.println("p_name="+p_name +",p_schedule="+p_schedule);
//도시정보
int country = Integer.parseInt(request.getParameter("p_country"));
String p_countryList[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };
String p_country = p_countryList[country];

%>
<%
//db사용준비
IPackageDao dao = PackageDao.getInstance();
PackageDto dto = new PackageDto(
		p_name,
		p_price,
		p_schedule,
		p_country
		);

boolean isS= dao.addPackage(dto);
//추가하기
if(isS){
	%>
	<script type="text/javascript">
	alert("추가 성공!");
	location.href ="index.jsp?showPage=admin";
	</script>
	<%
}
else{
	%>
	<script type="text/javascript">
	alert("추가 실패...");
	location.href ="index.jsp?showPage=admin";
	</script>
	<%
}
%>
</body>
</html>