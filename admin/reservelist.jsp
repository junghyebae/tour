<%@page import="admin.AirplainDto"%>
<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
<%@page import="admin.ReserveDto"%>
<%@page import="java.util.List"%>
<%@page import="paging.PagingBean"%>
<%@page import="admin.ReserveDao"%>
<%@page import="admin.IReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>
<body>
<%
request.setCharacterEncoding("utf-8");
%>
<%
//페이징처리
PagingBean paging = new PagingBean();
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);
}
else{
	int currentPage = Integer.parseInt(
			request.getParameter("nowPage"));
	paging.setNowPage(currentPage);
}
%>
<h1 align="center" >예약 현황</h1>
<%--
[처리상태] [주문번호] [비행기정보] [상품정보] [자세히보기 ] [주문승인] [주문취소]
1.[처리상태] : 대기 , 완료, 취소
2.[주문번호] : 아이디 정보로 연결
3.[비행기정보] : 해당 비행기 정보 연결
4.[상품정보] : 해당 상품 정보 연결
5.[자세히보기] : 성인, 아동, 유아, 좌석, 총가격, 예약일
6.[주문승인] : 누를시 처리상태 -> 완료로 변경 {완료된 목록에 대해선 [주문승인] 버튼 대신 [목록에서삭제] 로 변경,
									{[주문취소]를 안보이게설정}
7.[주문취소] : 처리상태를 취소로 변경 { [주문승인]을 [대기상태로변경]으로 변경, [주문취소]를 안보이게설정}
8. 디테일부분에서 [자세히보기] 부분을 출력한다. 
detail

 --%>
<!-- 테이블생성 -->
<table cellpadding="8px">
<col width="150" > <!-- 처리상태 -->
<col width="150">
<col width="150" >
<col width="250" >
<col width="150" >
<col width="150">
<col width="150">
<col width="450">

<tr id="detail" style="background-color: gray">
	<th>[처리상태]</th>
	<th>[주문번호]</th>
	<th>[비행기정보]</th>
	<th>[상품정보]</th>
	<th>[상세정보]</th>
	<th></th>
	<th></th>
	<!-- 디테일 불러오기 -->
	
</tr>

<!-- 데이터 불러오기 -->
<%
IReserveDao dao = ReserveDao.getInstance();
List<ReserveDto> relist = dao.reserveList(paging);
%>
<%
//비행기 정보에 비행기이름을 출력하기위해서
IAirplainDao airDao = AirplainDao.getInstance();
AirplainDto airDto = null;



%>

<%
if(relist ==null || relist.size()==0){
	%>
	<tr>
		<td colspan="7" align="center"> 데이터가 없습니다. </td>
	</tr>
	<%
}
//데이터 존재
for(int i=0; i<relist.size(); i++){
	ReserveDto dto = relist.get(i);
	System.out.println("번호:"+dto.getR_info_num());
	airDto = airDao.airplainDetail(dto.getR_info_num());
	%>
	<!-- 테이블 데이터 생성 -->
	<tr  style="background-color: #BDBDBD">
		<!-- 1.처리상태-->
		<%
		if(dto.getR_state()==0){
			%>
			<td align="center">취소</td>
			<%
		}
		else if(dto.getR_state()==1){
			%>
			<td align="center">대기</td>
			<%
		}
		else if(dto.getR_state()==2){
			%>
			<td align="center">완료</td>
			<%
		}
		%>
		<!-- 2.주문번호 :클릭시 디테일부분에 회원정보 출력 -->
		<td align="center">		
			<!--아이디로 회원정보 불러오기  -->		
			<button onclick="member('<%=dto.getR_id()%>')" class="member" 
			style="width: 150px"><%=dto.getR_num()%></button>
			
		</td>
		<!-- 3.비행기정보 : 클릭시 디테일부분에 비행기정보 출력-->
		<td align="center">
		<%
		if(airDto !=null){
			%>
			<button onclick="airplain(<%=airDto.getA_num()%>)" class="airplain" 
			style="width: 150px"><%=airDto.getA_name()%></button>					
			<%
		}
		%>
		</td>
		<!-- 4.상품정보 : 클릭시 디테일부분에 상품정보 출력 -->
		<td align="center">		
			<!--상품명으로 상품관련 정보 불러오기  -->		
			<button onclick="package('<%=dto.getR_pack_name()%>')" class="package" 
			style="width: 250px"><%=dto.getR_pack_name()%></button>
		</td>
		
		<!-- 5.자세히보기(버튼) : 클릭시 추가정보 디테일에 출력 -->
		<th align="center">
			<button onclick="detail('<%=dto.getR_num()%>')" class="detail" 
			style="width: 150px">자세히보기</button>
		</th>
		<!-- 6.주문승인(버튼) : 대기상태일때 클릭시 처리상태를 완료로 변경 -->
		<th align="center">
			<%
			//현재 주문상태가 대기상태라면 
			if(dto.getR_state()==1){
				%>
				<input type="button" value="주문승인" style="width: 150px"
				onclick="location.href='../main/index.jsp?showPage=admin_reserve_complete&r_num=<%=dto.getR_num()%>'"
				>
				<%
			}
			//현재 주문상태가 취소상태라면
			else if(dto.getR_state()==0){
				%>
				<input type="button" value="주문대기" style="width: 150px" 
				onclick="location.href='../main/index.jsp?showPage=admin_reserve_complete&r_num=<%=dto.getR_num()%>'"
				>
				<%
			}
			//현재 주문상태가 완료상태라면 
			else if(dto.getR_state()==2){
				%>
				<!-- 아무것도 보이지않게한다. -->
				<%
			}
			%>

		</th>
		<!-- 7.주문취소(버튼) : 대기상태일때 클릭시 처리상태를 취소로 변경 -->
		<th align="center">
			<%
			//현재 주문상태가 대기상태라면 
			if(dto.getR_state()==1){
				%>
				<input type="button" value="주문취소" style="width: 150px"
				onclick="location.href='../main/index.jsp?showPage=admin_reserve_complete2&r_num=<%=dto.getR_num()%>'"
				>
				<%
			}
			//현재 주문상태가 취소상태라면
			else if(dto.getR_state()==0){
				%>
				<input type="button" value="기록삭제" style="width: 150px" 
				onclick="location.href='../main/index.jsp?showPage=admin_reserve_complete2&r_num=<%=dto.getR_num()%>'"
				>
				<%
			}
			//현재 주문상태가 완료상태라면 
			else if(dto.getR_state()==2){
				%>
				<input type="button" value="기록삭제" style="width: 150px" 
				onclick="location.href='../main/index.jsp?showPage=admin_reserve_complete2&r_num=<%=dto.getR_num()%>'"
				>
				<%
			}
			%>

		</th>

		
	</tr>
	<%
}
if(relist.size()<10){
	for(int i=0; i<10-relist.size();i++){
		%>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
		<%
	}
}
%>

</table>
<script type="text/javascript">

var typeid ="";
var typenum = "";
var ttype="";
var typepackage="";

function airplain(num){
	typenum = num;
	ttype='airplain';
};

function member(id){
	typeid = id;
	ttype='member';
};

function package(name) {
	typepackage= name;
	ttype='package';
};

function detail(num){
	typenum = num;
	ttype='detail';
};

$(document).ready(function() {
	$(".airplain").click(function () {
		//alert("클릭됨");
		//alert(typenum+"  "+ttype);
		$.ajax({
			type:"post",
			url:"../admin/airplaininfo.jsp",
			data:{
				t1:ttype,
				t2:typenum
				
			},
			success:function(data){
				$("#detail").html("<th>[처리상태]</th> <th>[주문번호]</th> <th>[비행기정보]</th> "+
						" <th>[상품정보]</th> <th>[상세정보]</th> <th></th> <th></th> "+
						" <td rowspan='11' style='background-color: #BDBDBD'>"+data+"</td>"
				);
			}
			
		})
	});
	$(".member").click(function() {
		//alert("클릭됨");
		//alert(typeid+" "+ttype);
		$.ajax({
			type:"post",
			url:"../admin/memberinfo.jsp",
			data:{
				ttype:ttype,
				typeid:typeid
			},
			success:function(data){
				$("#detail").html("<th>[처리상태]</th> <th>[주문번호]</th> <th>[비행기정보]</th> "+
						" <th>[상품정보]</th> <th>[상세정보]</th> <th></th> <th></th> "+
						" <td rowspan='11' style='background-color: #BDBDBD'>"+data+"</td>"
				);
			}
		
		})
		
	});
	$(".package").click(function() {
		//alert("클릭됨");
		//alert(typenum+" "+ttype);
		$.ajax({
			type:"post",
			url:"../admin/packageinfo.jsp",
			data:{
				ttype:ttype,
				typepackage:typepackage
			},
			success:function(data){
				$("#detail").html("<th>[처리상태]</th> <th>[주문번호]</th> <th>[비행기정보]</th> "+
						" <th>[상품정보]</th> <th>[상세정보]</th> <th></th> <th></th> "+
						" <td rowspan='11' style='background-color: #BDBDBD'>"+data+"</td>"
				);
			}
		
		})
		
	});
	$(".detail").click(function() {
		//alert("클릭됨");
		//alert(typenum+" "+ttype);
		
		$.ajax({
			type:"post",
			url:"../admin/reservedetail.jsp",
			data:{
				ttype:ttype,
				typenum:typenum
			},
			success:function(data){
				$("#detail").html("<th>[처리상태]</th> <th>[주문번호]</th> <th>[비행기정보]</th> "+
						" <th>[상품정보]</th> <th>[상세정보]</th> <th></th> <th></th> "+
						" <td rowspan='11' style='background-color: #BDBDBD'>"+data+"</td>"
				);
			}
		
		})
		
	});
});

</script>
</body>
</html>