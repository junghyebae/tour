<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="admin.PackageDto"%>
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
//값받아오기
String sschedule = request.getParameter("schedule");
//한글깨짐테스트
String p_name = request.getParameter("p_name");
System.out.println("p_name="+p_name);
//도시설정
String p_country[] = {"방콕","대만","마닐라","싱가포르","세부","호치민",
		"다낭","하노이","오사카","도쿄","후쿠오카","오키나와","도야마","홍콩",
		"상해","마카오","하얼빈","항저우","로마","파리","런던","프라하","마드리드","밀라노",
		"아테네","워싱턴","애틀란타","보스턴","샌프란시스코","밴쿠버","에드먼튼","몬트리올",
		"카트만두","델리","콜롬보","두바이","테헤란","도하" };

//상품가격 설정
int p_price[] = {100000,100000,100000,130000,90000,120000,
				140000,120000,180000,220000,160000,180000,200000,180000,
				180000,220000,150000,160000,220000,270000,330000,340000,360000,310000,
				280000,380000,220000,280000,330000,340000,280000,260000,
				180000,190000,200000,280000,300000,180000};

//일정
int schedule = Integer.parseInt(sschedule);
%>
<%
//db사용준비
IPackageDao dao = PackageDao.getInstance();
boolean isS= false;
//추가하기
for(int i=0; i<p_price.length; i++){
	//dto에 넣기
	PackageDto dto = new PackageDto(
			p_country[i]+"["+sschedule+"일] 패키지", //상품이름
			(p_price[i]*Math.round(schedule*0.85)), //상품가격
			sschedule+"일", //일정
			p_country[i] //도시이름
			);
	
	//db에 넣기
	isS=dao.addPackage(dto);
}

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
		alert("이미 상품이 존재합니다.");
		location.href ="index.jsp?showPage=admin";
	</script>
	<%
}
%>

</body>
</html>