<%@page import="mem.MemberDto"%>
<%@page import="admin.PackageDto"%>
<%@page import="java.util.List"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../admin/jquery.cookie.js"></script>

<style type="text/css">


</style>

</head>
<body>
<%
request.setCharacterEncoding("utf-8");
%>
<%
//로그인정보 가져오기
MemberDto user = (MemberDto)session.getAttribute("login");
%>
<%
if(request.getParameter("type").equals("readcount")){
	%>
	<table style="text-align: center;">
	<col width="150"><col width="150"><col width="150">
	
	
	<%
	IPackageDao dao = PackageDao.getInstance();
	List<PackageDto> packlist =dao.rankreadCount();
	if(packlist !=null){
		for(int i=0; i<packlist.size(); i++){
			%>
			<tr>
				<td colspan="3">
				<!-- 클릭시 상세 디테일로 이동 -->
				<%
				if(user !=null){
					%>
					<a href="index.jsp?showPage=AirListDetail&seq=<%=packlist.get(i).getP_num()%>" 
					onclick="parameter(<%=packlist.get(i).getP_num()%>)">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					:<%=packlist.get(i).getP_readcount()%>
					</a>
					<%
				}
				else{
					%>
					<a href="#" onclick="alert('먼저로그인해주십시요.')">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					:<%=packlist.get(i).getP_readcount()%>
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
			<td colspan="3">
			데이터가 존재하지 않습니다.
			</td>
		</tr>
		<%
	}
	%>
	</table>
	<%
}
else if(request.getParameter("type").equals("buycount")){
	%>
	<table style="text-align: center;">
	<col width="150"><col width="150"><col width="150">
	
	
	<%
	IPackageDao dao = PackageDao.getInstance();
	List<PackageDto> packlist =dao.rankList();
	if(packlist !=null){
		for(int i=0; i<packlist.size(); i++){
			%>
			<tr>
				<td colspan="3">
				<!-- 클릭시 상세 디테일부분으로 이동 -->
				<%
				if(user !=null){
					%>
					<a href="index.jsp?showPage=AirListDetail&seq=<%=packlist.get(i).getP_num()%>" 
					onclick="parameter(<%=packlist.get(i).getP_num()%>)">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					:<%=packlist.get(i).getP_buycount()%>
					</a>
					<%
				}
				else{
					%>
					<a href="#" onclick="alert('먼저로그인해주십시요.')">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					:<%=packlist.get(i).getP_buycount()%>
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
			<td colspan="3">
			데이터가 존재하지 않습니다.
			</td>
		</tr>
		<%
	}
	%>
	</table>
	<%
}
else if(request.getParameter("type").equals("like")){
	%>
	<table border="1">
	<col width="150"><col width="150"><col width="150">
	
	
	<%
	IPackageDao dao = PackageDao.getInstance();
	List<PackageDto> packlist =dao.likeRank();
	if(packlist !=null){
		for(int i=0; i<packlist.size(); i++){
			%>
			<tr>
				<td colspan="3">
				<!-- 클릭시 상세 디테일부분으로 이동 -->
				<%
				if(user !=null){
					%>
					<a href="index.jsp?showPage=AirListDetail&seq=<%=packlist.get(i).getP_num()%>" 
					onclick="parameter(<%=packlist.get(i).getP_num()%>)">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					&nbsp;&nbsp;
					:<%=Math.round((packlist.get(i).getP_like()+5)/(packlist.get(i).getP_buycount()+1))%>점
					</a>
					<%
				}
				else{
					%>
					<a href="#" onclick="alert('먼저로그인해주십시요.')">
					<strong><%=i+1%>위.</strong><%=packlist.get(i).getP_name()%>
					&nbsp;&nbsp;
					:<%=Math.round((packlist.get(i).getP_like()+5)/(packlist.get(i).getP_buycount()+1))%>점
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
			<td colspan="3">
			데이터가 존재하지 않습니다.
			</td>
		</tr>
		<%
	}
	%>
	</table>
	<%
}
%>
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
                  //만약 name값이 pack5의 값과 같다면 5번쨰까지밀어낸다.
                  if(name==pack5){
                     $.cookie("pack5",pack4, {path:"/", expires:2});
                     $.cookie("pack4",pack3, {path:"/", expires:2});
                     $.cookie("pack3",pack2, {path:"/", expires:2});
                     $.cookie("pack2",pack1, {path:"/", expires:2});
                     $.cookie("pack1",name, {path:"/", expires:2});
                  }
                  //같은것이 하나라도 없을경우 
                  else{
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