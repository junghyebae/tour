<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>1조 비행기 예약 시스템</title>
			
		<%-- DropDown Menu --%>
		<style>
			html{
				height: 100%;
				padding: 0;
				margin: 0;
			}
			body{
				margin: 0;
				height: 100%;
				padding: 0;
			}
			.drop {
			    list-style-type: none;
			    margin: 0;
			    padding: 5;
			    overflow: hidden;
			    background-color: #66ccff;
			}
			
			li {
			    float: left;
			}
			
			li a, .dropbtn {
			    display: inline-block;
			    color: white;
			    text-align: center;
			    padding: 14px 16px;
			    text-decoration: none;
			}
			
			.drop li a:hover, .dropdown:hover .dropbtn {
			    background-color: #33bbff;
			}
			
			li.dropdown {
			    display: inline-block;
			}
			
			.dropdown-content {
			    display: none;
			    position: absolute;
			    background-color: #f9f9f9;
			    min-width: 90px;
			    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
			}
			
			.dropdown-content a {
			    color: black;
			    padding: 10px 10px;
			    text-decoration: none;
			    display: block;
			    text-align: left;
			}
			
			.dropdown-content a:hover {background-color: #f1f1f1}
			
			.show {display:block;}

			#head{
				width: 100%;
				height: 40px;
			}
			#content_wrap{
				width: 100%;
				min-height: 100%;
				height: auto !important;
				margin: -50px auto -150px auto;
			}
			#content{
				width: 100%;
				height:100%;
				padding: 50px 0px 150px 0px;
			}
			
			#footer {
	      	width: 100%;
	      	height: 200px;
	        clear: both;
	        padding: 20px;
	        border: 1px solid #bcbcbc;

		
			bottom: 0;
			left: 0;
			right: 0;
			background-color: #e6e6e6;
			/* position: relative; */
  			background: 
    			linear-gradient(
      			#242424, 
      			#363636
    			),
    			url(http://images.cdn.fotopedia.com/_avPIZmqM3w-7z161LH_268-hd.jpg);
    		color: #F6F6F6;
    		font-family: sans-serif;
    		overflow: hidden;
    		margin-bottom: -1px;
    		margin-left: 0px;
	      	}
	      	#footer td{
	      		border: none;
	      	}
	      	#footer th{
	      		border: none;
	      	}
	      	
		</style>
		
		<link rel="stylesheet" type="text/css" href="../SemanticUI/semantic.css">
		
		<%-- JQuery UI --%>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	  	
	  	<%-- Semantic UI --%>
	  	<link rel="stylesheet" type="text/css" href="../SemanticUI/semantic.css">		
		<script
		  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
		  crossorigin="anonymous"></script>
		<script src="../SemanticUI/semantic.js"></script>
		
		<%-- Slide Show(CSS) --%>
	  	<link rel="stylesheet" href="slideshow.css">	  
		
	</head>
	
	
	<body>
	
		<div id="body">
		<div id="head">
		<%
		//로그인정보가져오기
		MemberDto dto = null;
		dto = (MemberDto)session.getAttribute("login");	
		
		%>
		
		
		<ul class="drop" id="top_ul">
			<li><img alt="X" src="../image/kh4.png" width="100px" style="margin-top: 10px"></li>
		
			<!-- a태그에 있던 속성 ( class="active" ) -->
			<li><a href="index.jsp">Main</a></li>
			
			<li>
			<% 
				//만약 로그인이 되지 않았다면 버튼으로 만들도록한다. 
				if(dto==null){
					if(request.getParameter("showPage")==null){
						%>
						<a href="index.jsp?showPage=login">로그인하기</a>
						<%
					}
					else{
					%>
					<a href="index.jsp?showPage=login">로그인하기</a>
					<%
					}
				}
				//로그인이 되었다면 로그인 정보 뿌려주기
				else{
					%>
					환영합니다. <%=dto.getId()%>님 &nbsp;&nbsp;
					<a href="index.jsp?showPage=logout">로그아웃</a>
					<%
				}
			%>
			</li>
			
			<li class="dropdown" id="li_my_dropdown">
				<a href="javascript:void(0)">MyPage</a>
				<div class="dropdown-content" id="my_dropdown">
					<a href="index.jsp?showPage=mypage">예약확인</a>
					
					<%
					if(dto != null){
						%>
						<a href="index.jsp?showPage=mypage_">내정보</a>
						<%
					}
					%>
									
				</div>
			</li>
			
			<li class="dropdown" id="li_cs_dropdown">
				<a href="javascript:void(0)">고객센터</a>
			    <div class="dropdown-content" id="cs_dropdown">
			    	<a href="index.jsp?showPage=notice">공지사항</a>
				    <a href="index.jsp?showPage=qna">QnA</a>
				    <a href="index.jsp?showPage=cs">상담문의</a>
			    </div>
			</li>
			
			<li>
				<a href="index.jsp?showPage=shSimpleAirList">항공 상세 예약(검색)</a>
			</li>
			
			<li>
				<a href="index.jsp?showPage=hotel">호텔 예약</a>
			</li>
			
			<li>
				<a href="index.jsp?showPage=calendar">비행 일정 상세보기</a>
			</li>
			
			
			<%
			//관리자모드로 접속했다면 이부분을 보여주도록한다.
				if(dto != null){	
					if(dto.getAuth()==1){
						%>
						<li>
						<a href="index.jsp?showPage=admin">관리자모드</a>
						</li>
						<%
					}
				}
			%>
			
		</ul>		
		
		<script type="text/javascript">		
			$(document).ready(function() {
				$('#li_cs_dropdown').mouseover(function(){
					$("#cs_dropdown").slideDown();
				});
				
				$('#li_my_dropdown').mouseover(function(){
					$("#my_dropdown").slideDown();
				});
		
				$('#top_ul').mouseleave(function(){
					$(".dropdown-content").slideUp();
				});
			});
		</script>
		</div>
		<div id="cotent_wrap">
		<!-- include 실행되는부분 -->
		<div id="content">
			<%
			//include로 보여줄 페이지 값 보여주기
			String showPage = request.getParameter("showPage"); 
			System.out.println("페이지이동 : "+showPage);
			%>
			
			<%
			//메인(명현)
			if(showPage ==null){
				%>
				<jsp:include page="main.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("calendar")){
				%>
				<jsp:include page="./calendar.jsp" flush="false"/>
				<%
			}
			//로그인 및 회원가입(주희)
			else if(showPage.equals("login")){
				%>
				<jsp:include page="../mem/login.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("loginAf")){
				%>
				<jsp:include page="../mem/loginAf.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("regi")){
				%>
				<jsp:include page="../mem/regi.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("regiAf")){
				%>
				<jsp:include page="../mem/regiAf.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("find")){
				%>
				<jsp:include page="../mem/findIdPwd.jsp" flush="false"/>
				<%
			}
			//마이페이지
			else if(showPage.equals("mypage")){
				%>
				<jsp:include page="../mem/mypage.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("mypage_")){
				%>
				<jsp:include page="../mem/mypage_.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("del")){
				%>
				<jsp:include page="../mem/delMember.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("mypageUpdate")){
				%>
				<jsp:include page="../mem/mypageUpdate.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("mypageUpdateAf")){
				%>
				<jsp:include page="../mem/mypageUpdateAf.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("logout")){
				%>
				<jsp:include page="../mem/logout.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("reserveCk")){
				%>
				<jsp:include page="../mem/reserveCk.jsp" flush="false"/>
				<%
			}
			
			//메인 부분(명현)			
			else if(showPage.equals("booking")){
				%>
				<jsp:include page="../booking/main_booking.jsp" flush="false"/>
				<%
			}
			
			//관리자모드(승간)
			else if(showPage.equals("admin")){
				%>
				<jsp:include page="../admin/admin.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_airplain")){
				%>
				<jsp:include page="../admin/airplain.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_airplainAf")){
				%>
				<jsp:include page="../admin/airplainAf.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_airplain2")){
				%>
				<jsp:include page="../admin/airplain2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_airplainAf2")){
				%>
				<jsp:include page="../admin/airplainAf2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_package")){
				%>
				<jsp:include page="../admin/package.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_packageAf")){
				%>
				<jsp:include page="../admin/packageAf.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_package2")){
				%>
				<jsp:include page="../admin/package2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_packageAf2")){
				%>
				<jsp:include page="../admin/packageAf2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_airplainList")){
				%>
				<jsp:include page="../admin/airplainlist.jsp" flush="false"/>
				<%
			}else if(showPage.equals("removeAirplain")){
				%>
				<jsp:include page="../admin/removeairplain.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_packageList")){
				%>
				<jsp:include page="../admin/packagelist.jsp" flush="false"/>
				<%
			}else if(showPage.equals("removePackage")){
				%>
				<jsp:include page="../admin/removepackage.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_hotel")){
				%>
				<jsp:include page="../admin/hotel.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_hotelAf")){
				%>
				<jsp:include page="../admin/hotelAf.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_hotel2")){
				%>
				<jsp:include page="../admin/hotel2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_hotelAf2")){
				%>
				<jsp:include page="../admin/hotelAf2.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_hotelList")){
				%>
				<jsp:include page="../admin/hotellist.jsp" flush="false"/>
				<%
			}else if(showPage.equals("removeHotel")){
				%>
				<jsp:include page="../admin/removehotel.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_reserveList")){
				%>
				<jsp:include page="../admin/reservelist.jsp" flush="false"/>
				<%
			}else if(showPage.equals("admin_reserve_complete")){
				%>
				<jsp:include page="../admin/reservecomplete.jsp" flush="false"/>
				<%	
			}else if(showPage.equals("admin_reserve_complete2")){
				%>
				<jsp:include page="../admin/reservecomplete2.jsp" flush="false"/>
				<%	
			}else if(showPage.equals("admin_memberList")){
				%>
				<jsp:include page="../admin/memberList.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("AD_update_mem")){
				%>
				<jsp:include page="../admin/memberUpdate.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("delMember_AD")){
				%>
				<jsp:include page="../admin/memberDel.jsp" flush="false"/>
				<%
			}
			//상세예약부분(지윤)
			else if(showPage.equals("shSimpleAirList")){
				%>
				<jsp:include page="../air/AirList.jsp" flush="false" />
				<%
			}else if(showPage.equals("searchDetailAirList")){
			%>
				<jsp:include page="../air/AirList.jsp" flush="false"/>
			<%
			}else if(showPage.equals("AirListDetail")){
			%>
				<jsp:include page="../air/AirDetail.jsp" flush="false"/>
			<%
			}else if(showPage.equals("AirReserv")){
			%>
				<jsp:include page="../air/AirReserv.jsp" flush="false"/>
			<%
			}else if(showPage.equals("AirReservAf")){
			%>
				<jsp:include page="../air/AirReservAf.jsp" flush="false"/>
			<%
			}else if(showPage.equals("AirReservFinal")){
			%>
				<jsp:include page="../air/AirReservfinal.jsp" flush="false"/>
			<%
			}
			//호텔예약부분(주희)
			else if(showPage.equals("hotel")){
			%>
			<jsp:include page="../hotel/hotel.jsp" flush="false"/>
			<%
			}
			else if(showPage.equals("hotelDetail")){
				%>
				<jsp:include page="../hotel/hotelDetail.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("hotelReserve")){
				%>
				<jsp:include page="../hotel/hotelReserve.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("Hcancel")){
				%>
				<jsp:include page="../hotel/hotelCancel.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("Non-member")){
				%>
				<jsp:include page="../hotel/nonMember.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("nonMemRes")){
				%>
				<jsp:include page="../hotel/nonMemRes.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("HcancelNon")){
				%>
				<jsp:include page="../hotel/hotelCancelNon.jsp" flush="false"/>
				<%
			}
			//게시판부분(정혜)
			else if(showPage.equals("notice")){
				%>
				<jsp:include page="../bbs/bbs_notice_list.jsp" flush="false"/>
			<%} 
			else if(showPage.equals("notice_detail")){
				%>
				<jsp:include page="../bbs/bbs_notice_detail.jsp" flush="false"/>
			<%} 
			else if(showPage.equals("notice_update")){
				%>
				<jsp:include page="../bbs/bbs_notice_update.jsp" flush="false"/>
			<%} 
			else if(showPage.equals("notice_write")){
				%>
				<jsp:include page="../bbs/bbs_notice_write.jsp" flush="false"/>
			<%} 
			//Q &A(정혜)
			else if(showPage.equals("qna")){
				%>
				<jsp:include page="../bbs_QNA/bbs_q_list.jsp" flush="false"/>
			<%}
			else if(showPage.equals("qna_write")){
				%>
				<jsp:include page="../bbs_QNA/bbs_q_write.jsp" flush="false"/>
			<%}
			else if(showPage.equals("qna_detail")){
				%>
				<jsp:include page="../bbs_QNA/bbs_q_detail.jsp" flush="false"/>
			<%}
			else if(showPage.equals("qna_update")){
				%>
				<jsp:include page="../bbs_QNA/bbs_q_update.jsp" flush="false"/>
			<%} 
			//상담게시판(정혜)
			else if(showPage.equals("cs")){
				%>
				<jsp:include page="../bbs_cs/bbs_cs_list.jsp" flush="false"/>
			<%}
			else if(showPage.equals("cs_write")){
				%>
				<jsp:include page="../bbs_cs/bbs_cs_write.jsp" flush="false"/>
			<%} 
			else if(showPage.equals("cs_detail")){
				%>
				<jsp:include page="../bbs_cs/bbs_cs_detail.jsp" flush="false"/>
			<%} 
			else if(showPage.equals("cs_update")){
				%>
				<jsp:include page="../bbs_cs/bbs_cs_update.jsp" flush="false"/>
			<%}
			else if(showPage.equals("cs_answer")){
				%>
				<jsp:include page="../bbs_cs/bbs_cs_answer.jsp" flush="false"/>
			<%}	
			///////추가됨  2개 mycs, acancel
			////********************--------------bbs_cs index 아래 1개 추가됨 ------------------
			else if(showPage.equals("myCs")){
				%>
				<jsp:include page="../bbs_cs/myCs.jsp" flush="false"/>
				<%
			}
			else if(showPage.equals("Acancel")){	/////////////////////////////////추가됨
				%>
				<jsp:include page="../mem/Acancel.jsp" flush="false"/>
				<%
			}
			%>
		</div>
		</div>
		</div>
		
		
		<div id="footer" >
		<table cellpadding="3px" style="border: none;">
		<col width="150"><col width="200"><col width="200"><col width="200"><col width="200">
		<col width="150"><col width="190"><col width="150"><col width="350"><col width="200">
		<tr >
			<th>KH투어 고객센터</th>
			<td>1544 - 9970</td>
			<th colspan="1" align="right"><h5>해외여행 문의&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5></th>
			<th colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</th>
			<th align="left">프로젝트 기간</th>
			<th align="center">오시는 길  </th>
			<td> 서울특별시 강남구 테헤란로14길 6 남도빌딩 2F &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td rowspan="2" align="center">
			<img  src="../image/talk.bmp">
			&nbsp;
			<img  src="../image/face.bmp">
			&nbsp;
			<img  src="../image/message.bmp">
			</td>
		</tr>
		<tr>
			<th>영업시간안내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
			<td> 평일  15:30 ~ 21 : 30 </td>
			<td align="right"> <sub><strong>기승간</strong> 010 8619 8323</sub> </td>
			<td align="right"> <sub><strong>배정혜</strong> 010 5755 8647</sub> </td>
			<td align="right"> <sub><strong>송지윤</strong> 010 2086 8040</sub> </td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>2017년 08월 18일 시작</td>
			<th> &nbsp;&nbsp;대표 연락처 </th>
			<td align="right"> 윤필용 010 9721 xxxx &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td> 저녁시간 18:10 ~ 18:50 </td>
			<td align="right"> <sub><strong>최명현</strong> 010 8899 6893</sub> </td>
			<td align="right"> <sub><strong>백주희</strong> 010 7445 0422</sub> </td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>2017년 09월 01일 끝</td>
			<th>&nbsp;&nbsp;&nbsp;&nbsp; 발표 시작시간 </th>
			<td align="right">2017년 09월 01일 16:00 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td align="center">
			회식장소: 부비포차 강남점 &nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		</table>
		
		</div>
		
		
	
	</body>
</html>