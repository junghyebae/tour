
<%@page import="mem.MemberDto"%>
<%@page import="admin.PackageDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../admin/jquery.cookie.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.4/jquery.min.js"></script> -->
<!-- <script src="https://code.jquery.com/jquery-1.7.4.js"></script> -->

<style type="text/css">

.area {
  display: table;
  margin: 0;
  padding: 0;
  table-layout: fixed;
  width: 100%;
  text-align: center;
}

li {
  display: table-cell;
  list-style: none
}

td {
	margin-bottom: 5px;
}

</style>

</head>
<body>
<%
//로그인정보 불러오기
MemberDto user = (MemberDto)session.getAttribute("login");

%>
<h1 align="center">최근본 상품 및 호텔</h1>

<ul class="area">
	<li class="item" style="width:50%; background-color: #66ccff;"><a href="#" id="package">상품</a></li>
	<li class="item" style="width:50%; background-color: #1ab2ff;"><a href="#" id="hotel">호텔</a></li>
</ul>


<div id="showRecent">

<table align="center">
<col width="200">


<%
IPackageDao dao = PackageDao.getInstance();


Cookie[] cookies = request.getCookies();

if(cookies !=null){
	List<PackageDto> list = new ArrayList<>();
	PackageDto dto = null;
	for(int i=cookies.length-1; i>=0; i--){
		Cookie c = cookies[i];
		String cName = c.getName();
		System.out.println("cName:"+cName);
		String cValue = c.getValue();
		System.out.println("cValue:"+cValue);
		
		if(cName.equals("pack1") || cName.equals("pack2") || cName.equals("pack3") 
				|| cName.equals("pack4")||cName.equals("pack5")){
			dto = dao.getPackage(Integer.parseInt(cValue));
			//System.out.println(dto.toString());
			list.add(dto);
		}
	}
	if(dto!=null && list !=null){
		for(int i=0; i<list.size();i++){
			%>
			<tr>
			<td>
			<% 
			if(user !=null){
				%>
				<a href="index.jsp?showPage=AirListDetail&seq=<%=list.get(i).getP_num()%>" 
					onclick="parameter(<%=list.get(i).getP_num()%>)">
				<strong><%=i+1%>.</strong><%=list.get(i).getP_name()%>
				</a>
				<%
			}
			else{
				%>
				<a href="#" onclick="alert('먼저로그인해주십시요.')">
				<strong><%=i+1%>.</strong><%=list.get(i).getP_name()%>
				</a>
				<%
			}
			%>
			
			</td>
			</tr>
			<%
		}
	}
	else{
		%>	
		<tr>
		<td rowspan="4">최근본상품이 없습니다.</td>
		</tr>	
		<%
	}
	
		
}
//쿠키가 존재하지않을 경우
else{
	%>
	<tr>
	<td rowspan="4">최근본상품이 없습니다.</td>
	</tr>
	<%
}
%>


</table>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#package").click(function() {
		$.ajax({
			type:"post",
			url:"../main/ajax_recent.jsp",
			data:{
				type:"package",
			},
			success:function(data){
				$("#showRecent").html(data);
				$("#package").prop("style","color:yellow");
				$("#hotel").removeAttr("style");
			}
		})
	});
	
	$("#hotel").click(function() {
		$.ajax({
			type:"post",
			url:"../main/ajax_recent.jsp",
			data:{
				type:"hotel",
			},
			success:function(data){
				$("#showRecent").html(data);
				$("#hotel").prop("style","color:yellow");
				$("#package").removeAttr("style");
			}
		})
	});
});
</script>
<script type="text/javascript">

//만약 1순위로 출력할 쿠키에 이미 값이 저장되어있다면 1순위를 2순위로 밀어내고, 1순위에 새로운 쿠키값을 저장한다. -----(1)
//하지만 1순위에 저장할쿠키값이 이미 같다면 밀어내지않는다. 하지만 같은 값이라도 시간을 갱신해주기위해  값을저장하도록한다. ----(2)
//접근방식은 상품 검색시, 또는 상품예약시 해당하는 p_num 을 parameter값으로 넘겨주도록한다. 아래 방식참고

function parameter(name) {
   //alert("parameter"+name);
   //1,2,3,4,5 까지 저장을하도록한다.
   var pack1 = $.cookie("pack1");      
   var pack2 = $.cookie("pack2");
   var pack3 = $.cookie("pack3");
   var pack4 = $.cookie("pack4");
   var pack5 = $.cookie("pack5");
   //alert("pack1="+pack1);
   //alert("pack2="+pack2);
   //alert("pack3="+pack3);
   //alert("pack4="+pack4);
   //alert("pack5="+pack5);
   //들어온 값을 pack1에저장하고 기존에 저장된값을 한칸씩 밀어내도록한다. 역순으로 저장해야 데이터가 안날라가고 전달됨
   //null이아니라는건 즉 이미 본상품이 5개가됐다는것(기존의 pack5의 값을 날려버림)
   if(pack5 !=null){
      //만약 name값이 pack1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
      if(name == pack1){
    	  //alert("들어옴");
         $.cookie("pack1",name, {path:"/", expires:2});
      }
      else{
         //만약 name값이 pack2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
         if(name ==pack2){
        	 //alert("들어옴1");
      
            $.cookie("pack2",pack1, {path:"/", expires:2});
            $.cookie("pack1",name, {path:"/", expires:2});
         }
         else{
            //만약 name값이 pack3의 값과 같다면 3번째까지밀어낸다.
            if(name==pack3){
            	//alert("들어옴2");
               $.cookie("pack3",pack2, {path:"/", expires:2});
               $.cookie("pack2",pack1, {path:"/", expires:2});
               $.cookie("pack1",name, {path:"/", expires:2});
            }
            else{
               //만약 name값이 pack4의 값과 같다면 4번쨰까지밀어낸다.
               if(name==pack4){
            	  //alert("들어옴3");
                  $.cookie("pack4",pack3, {path:"/", expires:2});
                  $.cookie("pack3",pack2, {path:"/", expires:2});
                  $.cookie("pack2",pack1, {path:"/", expires:2});
                  $.cookie("pack1",name, {path:"/", expires:2});
               }
               else{
                  //만약 name값이 pack5의 값과 같다면 5번쨰까지밀어낸다.
                  if(name==pack5){
                	 // alert("들어옴4");
                     $.cookie("pack5",pack4, {path:"/", expires:2});
                     $.cookie("pack4",pack3, {path:"/", expires:2});
                     $.cookie("pack3",pack2, {path:"/", expires:2});
                     $.cookie("pack2",pack1, {path:"/", expires:2});
                     $.cookie("pack1",name, {path:"/", expires:2});
                  }
                  //같은것이 하나라도 없을경우 
                  else{
                	 //alert("들어옴5");
                     $.cookie("pack5",null,{path:"/", expires:-1});
                     $.cookie("pack5",pack4, {path:"/", expires:2});
                     $.cookie("pack4",pack3, {path:"/", expires:2});
                     $.cookie("pack3",pack2, {path:"/", expires:2});
                     $.cookie("pack2",pack1, {path:"/", expires:2});
                     $.cookie("pack1",name, {path:"/", expires:2});
                  }
               }
            }
         }
      }
   }
   //이미 본상품이 4개 
   else if(pack4 !=null){
      //만약 name값이 pack1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
      if(name == pack1){
         $.cookie("pack1",name, {path:"/", expires:2});
      }
      else{
         //만약 name값이 pack2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
         if(name ==pack2){
            $.cookie("pack2",pack1, {path:"/", expires:2});
            $.cookie("pack1",name, {path:"/", expires:2});
         }
         else{
            //만약 name값이 pack3의 값과 같다면 3번째까지밀어낸다.
            if(name==pack3){
               $.cookie("pack3",pack2, {path:"/", expires:2});
               $.cookie("pack2",pack1, {path:"/", expires:2});
               $.cookie("pack1",name, {path:"/", expires:2});
            }
            else{
               //만약 name값이 pack4의 값과 같다면 4번쨰까지밀어낸다.
               if(name==pack4){
                  $.cookie("pack4",pack3, {path:"/", expires:2});
                  $.cookie("pack3",pack2, {path:"/", expires:2});
                  $.cookie("pack2",pack1, {path:"/", expires:2});
                  $.cookie("pack1",name, {path:"/", expires:2});
               }
               else{
                  //같은것이 하나라도 없을경우 
                  $.cookie("pack5",pack4, {path:"/", expires:2});
                  $.cookie("pack4",pack3, {path:"/", expires:2});
                  $.cookie("pack3",pack2, {path:"/", expires:2});
                  $.cookie("pack2",pack1, {path:"/", expires:2});
                  $.cookie("pack1",name, {path:"/", expires:2});
               }
            }
         }
      }
   }
   //이미 본상품이 3개
   else if(pack3 !=null){
      //만약 name값이 pack1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
      if(name == pack1){
         $.cookie("pack1",name, {path:"/", expires:2});
      }
      else{
         //만약 name값이 pack2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
         if(name ==pack2){
            $.cookie("pack2",pack1, {path:"/", expires:2});
            $.cookie("pack1",name, {path:"/", expires:2});
         }
         else{
            //만약 name값이 pack3의 값과 같다면 3번째까지밀어낸다.
            if(name==pack3){
               $.cookie("pack3",pack2, {path:"/", expires:2});
               $.cookie("pack2",pack1, {path:"/", expires:2});
               $.cookie("pack1",name, {path:"/", expires:2});
            }
            else{
               //같은것이 하나라도 없을경우    
               $.cookie("pack4",pack3, {path:"/", expires:2});
               $.cookie("pack3",pack2, {path:"/", expires:2});
               $.cookie("pack2",pack1, {path:"/", expires:2});
               $.cookie("pack1",name, {path:"/", expires:2});         
            }
         }
      }
   }
   //이미 본상품이 2개
   else if(pack2 !=null){
      //만약 name값이 pack1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
      if(name == pack1){
         $.cookie("pack1",name, {path:"/", expires:2});
      }
      else{
         //만약 name값이 pack2의 값과 같다면 1번째를 2번째로 밀어내는것까지만한다.
         if(name ==pack2){
            $.cookie("pack2",pack1, {path:"/", expires:2});
            $.cookie("pack1",name, {path:"/", expires:2});
         }
         else{
            //같은것이 하나라도 없을경우       
            $.cookie("pack3",pack2, {path:"/", expires:2});
            $.cookie("pack2",pack1, {path:"/", expires:2});
            $.cookie("pack1",name, {path:"/", expires:2});
         }
      }
   }
   //이미 본상품이 1개
   else if(pack1 !=null){
      //만약 name값이 pack1의 값과 같다면 밀어낼필요없이 시간만 다시 세팅해준다.
      if(name == pack1){
         $.cookie("pack1",name, {path:"/", expires:2});
      }
      else{
         //같은것이 하나라도 없을경우       
         $.cookie("pack2",pack1, {path:"/", expires:2});
         $.cookie("pack1",name, {path:"/", expires:2});
      }
   }
   //이미본상품이 한개도없다면
   else if(pack1 ==null){
      //alert("잘들어옴");
      $.cookie("pack1",name, {path:"/", expires:1});
   }
   
}

</script>
</body>
</html>