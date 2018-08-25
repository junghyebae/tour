<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="air.AirTotalInfoDTO"%>
<%@page import="mem.MemberDto"%>
<%@page import="air.AirProductDTO"%>
<%@page import="air.AirProudctDAO"%>
<%@page import="air.IAirProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>항공상품상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- <style type="text/css">
#table table {
	border-top : #444;
	border-collapse: collapse;
	border-top: 1px solid darkgray;
	border-bottom: 1px solid darkgray;
	margin: auto;
	/* margin-top: 40px; */
	width: 426px;
}
#table th {
	border-right: 1px solid lightgray;
	text-align: right;
	padding-right: 10px;
}
#table td {
	padding-left: 10px;
}
#table th, td {
	border-bottom: 1px solid lightgray;
}
.tb_bs {
	background-color: #F2F2F2;
}
h3 {
	text-align: center;
	width: 426px;
	margin:auto;
	margin-top: 30px;
	margin-bottom:10px;
}
</style> -->

<style type="text/css">
#AirDetail_table table {
   border-top : #444;
   border-collapse: collapse;
   border-top: 1px solid darkgray;
   border-bottom: 1px solid darkgray;
   margin: auto;
   /* margin-top: 40px; */
   width: 426px;
}
#AirDetail_table th {
   border-right: 1px solid lightgray;
   text-align: right;
   padding-right: 10px;
}
#AirDetail_table td {
   padding-left: 30px;
   padding-bottom: 30px;
}
#AirDetail_table th, td {
   border-bottom: 1px solid lightgray;
}
.tb_bs {
   background-color: #F2F2F2;
}
h3 {
   text-align: center;
   width: 426px;
   margin:auto;
   margin-top: 30px;
   margin-bottom:10px;
}
</style> 
</head>
<body>
<%
// 로그인정보 저장하기
MemberDto user = (MemberDto)session.getAttribute("login");
String userID = "";
if(user != null){
	userID = user.getId();
}

//include로 보여줄 페이지 값 보여주기
String showPage = request.getParameter("showPage"); 
System.out.println("페이지이동 : "+showPage);
%>
<%
	String _seq = request.getParameter("seq");
	int seq = Integer.parseInt(_seq);
	
	IAirProductDAO airdao = AirProudctDAO.getInstance();
	AirTotalInfoDTO airdto = airdao.AirProductDetail(seq);
	
	System.out.println("오 : " + airdto.toString());
%>

<%
//조회수증가
IPackageDao readDao = PackageDao.getInstance();
boolean isss = readDao.readcountIncrement(seq);
%>
<%!
public String toDates(String mdate){
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분"); 
   
   String s = mdate.substring(0, 4) + "-" //yyyy
         + mdate.substring(4, 6) + "-" //mm
         + mdate.substring(6, 8) + " " //dd
         + mdate.substring(8, 10) + ":" //hh
         + mdate.substring(10, 12) + ":00" ; 
   Timestamp d = Timestamp.valueOf(s);
   
   return sdf.format(d);
}
%>
<div>
	<!-- 좌석자리 -->
	<% 
		int seatType = 0; 
	%>
	<form action="../main/index.jsp">
	<input type="hidden" name="showPage" value="AirReserv">
	<input type="hidden" name="seq" value="<%=seq %>">
	<h3>상세내역</h3>
	<table id="AirDetail_table" align="center">
		<colgroup>
			<col width="90">
			<col width="300">
		</colgroup>
		<tr>
			<th>비행기번호</th>
			<td>
				<p id="a_num"><%=airdto.getT_ANUM() %></p>
			</td>
		</tr>
		<tr>
			<th>비행기명</th>
			<td><%=airdto.getT_ANAME() %></td>
		</tr>
		<tr>
			<th>상품명</th>
			<td><%=airdto.getT_PNAME() %></td>
		</tr>
		<tr>
			<th>출발일</th>
         	<%String s = String.valueOf(airdto.getT_ATIME_S()) ;%>
        	 <td><%=toDates(s) %></td>
		</tr>
		<tr>	  
        	 <th>귀국일</th>
        	 <%String p = String.valueOf(airdto.getT_ATIME_E()) ;%>
         	<td><%=toDates(p) %></td>
		</tr>
		</table>
		<div style="text-align: center; margin: 10px 0;">
			<input type="submit" value="예약하기" style="width:100px; height: 30px;">
		</div>
	</form>
</div>

</body>
</html>







