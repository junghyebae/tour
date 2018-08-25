<%@page import="mem.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="../admin/jquery.cookie.js"></script>
	
	<style type="text/css">
		.hh{
			text-align: center;
			color: red;
		}
		
		.admin_menu{
			border: 1 solid black;
			width: 15%; 
			height: 780px;
			float: left;
		}
		
		.admin_view{
			margin-left: 300px;
			border: 1 solid black; 
			width: 85%; 
			height: 780px;
		}
		
		
	</style>

</head>
<body>

<%
//로그인정보가져오기
MemberDto dto = null;
dto = (MemberDto)session.getAttribute("login");

if(dto == null){
	dto = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
			
}

System.out.println("dto.getId: " + dto.getId());

//관리자모드로 접속했다면 이부분을 보여주도록한다.
	if(dto != null){	
		if(dto.getAuth()==1){
			%>
					<table align="center">
					<col width="200"><col width="100"><col width="200"><col width="100"><col width="800">
					<!-- 구분선 -->
					<tr id="chartarea">
					<td colspan="4">&nbsp;</td>
					<td rowspan="13"></td>
					</tr>
					<!-- 1.비행기 정보 추가 -->
					<tr>
						<td> 비행기 정보 다중추가 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_airplain'"
					 				value="클릭">
						</td>
						<td> 비행기 정보 단일추가 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_airplain2'"
					 				value="클릭">
						</td>
						
					</tr>
					<!-- 2.비행기 정보 리스트 보기 -->
					<tr>
						<td> 비행기 정보 확인 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_airplainList'"
					 				value="클릭">
						</td>
					</tr>
					<!-- 구분선 -->
					<tr>
					<td colspan="4">&nbsp;</td>
					</tr>
					<!-- 3.상품 정보 추가 -->
					<tr>
						<td> 상품 정보 다중 추가 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_package'"
					 				value="클릭">
						</td>
						<td> 상품 정보 단일 추가 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_package2'"
					 				value="클릭">
						</td>
					</tr>
					<!-- 4.상품 정보 리스트 보기 -->
					<tr>
						<td> 상품 정보 확인 :</td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_packageList'"
					 				value="클릭">
						</td>
					</tr>
					<!-- 구분선 -->
					<tr>
					<td colspan="4">&nbsp;</td>
					</tr>
					<!-- 5.호텔정보 다중 추가 -->
					<tr>
						<td> 호텔 정보 다중 추가 : </td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_hotel'" value="클릭">
						</td>
						<td> 호텔 정보 단일 추가 : </td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_hotel2'" value="클릭">
						</td>
					</tr>
					<!-- 6.호텔정보 확인 -->
					<tr>
						<td> 호텔 정보 확인 : </td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_hotelList'" value="클릭">
						</td>
					</tr>
					<!-- 구분선 -->
					<tr>
					<td colspan="4">&nbsp;</td>
					</tr>
					<!-- 7.회원관리 및 예약현황 -->
					<tr>
						<td> 회원관리 </td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_memberList'"
					 				value="클릭">
						</td>
						<td> 예약현황 </td>
						<td>
						<input type="button" onclick="location.href='../main/index.jsp?showPage=admin_reserveList'"
					 				value="클릭">
						</td>
					</tr>
					<tr>
					<td colspan="4">&nbsp;</td>
					</tr>
					<!-- 8.차트보기 -->
					<tr>
						<td> 회원등급 차트보기</td>
						<td>
						<button onclick="chart(1)" id="memberchart">클릭</button>
						</td>
					</tr>
					</table>
				</div>
				
				
				<script type="text/javascript">
				var type =0;
				function chart(n) {
					type =n;
				}
				
				$(document).ready(function() {
					$("#memberchart").click(function() {
						//alert("클릭됨");
						//alert("type ="+type);
						
							$.ajax({
								type:"post",
								url:"../admin/gradeChart.jsp",
								success:function(data){
									$("#chartarea").html("<td colspan='4'>&nbsp;</hd> <td rowspan='13'>"+
										data+"</td>"
											);
									
								}
							})
						
					});
				});
				
				</script>
			<%
		}else{
			%>				
				<h1 class="hh">경고!</h1><br>
				<h1 class="hh">관리자가 아닙니다!</h1><br>
				<h1 class="hh">잘못된 경로로 들어오게 되어 자동적으로 5초 뒤에 메인 화면으로 돌아갑니다.</h1>
				<script type="text/javascript">
					setTimeout("location.href='../main/index.jsp'",5000);
				</script>
			<%			
		}
			
	}
%>

</body>
</html>