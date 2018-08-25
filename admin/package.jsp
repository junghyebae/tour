<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center">상품 정보 다중 추가</h1>

<form action="index.jsp" method="post">
<table>
<col width="150"><col width="600">
<!-- 상품이름 -->
<tr>
	<td>상품명</td>
	<td>
		상품명은 동남아: 방콕,대만,마닐라,싱카포르,세부,호치민,다낭,하노이
		일본:오사카,도쿄,후쿠오카,오키나와,도야마
		중국:홍콩, 상해,마카오,하얼빈,항저우
		유럽:로마,파리,런던,프라하,마드리드,밀라노,아테네
		미주:워싱턴,애틀란타,보스턴,샌프란시스코
		캐나다:밴쿠버,에드먼튼,몬트리올
		서남아:카트만두,델리,콜롬보
		중동:두바이,테헤란,도하 
		에 플러스로 (일정 즉 : 4일, 3일 이 붙습니다.)
	</td>
</tr>
<!-- 상품가격 -->
<tr>
	<td>상품가격</td>
	<td>
		상품가격은 자동으로 계산해서 들어갑니다.
	</td>
</tr>
<!-- 일정 -->
<tr>
	<td>일정선택</td>
	<td>
	선택한 날의 정보가 모든데이터에 들어갑니다.
		<select name="schedule" >
			<%
			for(int i=1; i<=30; i++){
				%>
				<option value="<%=i%>"><%=i%>일</option>
				<%
			}
			%>
		</select>		
	</td>
</tr>
<!-- 내용 -->
<tr>
	<td>내용</td>
	<td>
	내용은 출력화면에서 다른 정보들을 출력할 것이니, 
	여기서 입력할 필요없습니다.
	</td>
</tr>
<tr>
	<td>추가하기</td>
	<td>
		<input type="hidden" name="p_name" value="한글테스트">
		<input type="hidden" name="showPage" value="admin_packageAf">
		<input type="submit" value="클릭">
	</td>
</tr>
</table>
</form>
</body>
</html>