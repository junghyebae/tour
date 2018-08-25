<%@page import="mem.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="admin.PackageDto"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
<%@page import="main.BookingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="main.BookingDao"%>
<%@page import="main.IBookingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Insert title here</title>

      <%-- Style / CSS --%>
        <style type="text/css">
      @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

      body{
         font-family: Nanum Gothic;
         height: 100%;
         padding: 0;
         margin: 0;
      }
      html{
      	height: 100%;
      	margin: 0;
      	padding: 0;
      }
      
      /* 
        #calendar {
      max-width: 600px;
      margin: 0 auto;
      } 
      */
      
      	.content{
            margin-top: 30px;
            margin-left: 30px;
            margin-right: 30px;
         }
         
         #body_1 {
           width: 588px;
           height: 650px;
           padding: 20px;
           margin-left: 10px;
           margin-right: 10px;
           margin-bottom: 10px;
           float: left;
           border: 1px solid #bcbcbc;
           text-align: left;
         }
         
         .sec_name{
         font-size: 15px;
        }
         
        .peopleNum{
         font-size: 13px;
         width: 80px;
         text-align: center;
         margin-left: 30px;
         margin-right: 10px;
        }     
         
         
          #body_2 {
           width: 1200px;
           height: 350px;
           margin-left: 36px;
           margin-right: 10px;
           margin-bottom: 30px;
           float: left;
           border: 1px solid #bcbcbc;
         }
         
         #body_3 {
           width: 333px;
           height: 270px;
           margin-left: 86px;
           margin-bottom: 10px;
           float: left;
         }
         
         #body_4 {
           width: 333px;
           height: 270px;
           margin-left: 50px;
           margin-bottom: 10px;
           float: left;
           border: 1px solid #bcbcbc;
         }
         
         #body_5 {
           width: 333px;
           height: 270px;
           margin-left: 50px;
           margin-bottom: 10px;
           float: left;
           border: 1px solid #bcbcbc;
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
   
   %>   

   <%
   String bbs = "bbs";
   
   /*
   String getSdate = request.getParameter("sdate");
   String getEdate = request.getParameter("edate");
   String eLocation = request.getParameter("eLocation");
   */
   
   String getSdate = "";
   String getEdate = "";
   String eLocation = "";
   //String product = "";
   int getP_num = 0;
   

   try{
      getSdate = request.getParameter("sdate");
      getEdate = request.getParameter("edate");
      
      eLocation = request.getParameter("eLocation");
      System.out.println("main상단의 서블릿 eLocation: " + eLocation);
      
      
      getSdate = getSdate.replace("-", "");
         System.out.println("getSdate: " + getSdate);         
      
      getEdate = getEdate.replace("-", "");
         System.out.println("getEdate: " + getEdate);
         
      if(getSdate.equals(getEdate)){
         %>
         <script type="text/javascript">
            alert("가는 날짜와 오는 날짜가 같습니다. 다시 선택해주세요.");
         </script>
         <%
         getSdate = "";
         getEdate = "";
      }
      
      

   }catch (NullPointerException e) {      
      getSdate = "";
      getEdate = "";
      eLocation = "";
   }
      
   %>
   
   <%-- Main 내용이 담긴 div Tag --%>
   <div class="content">
   
   <%-- Main 예약 --%>
   <div id="body_1" style="background-color: #ffffff;">
      <form action="index.jsp" method="get" name="frm">
      <input type="hidden" name="showPage" value="booking">
         <h2 align="center" style="text-decoration: underline;">회원 항공 간편 예약</h2>
         
         <br>
         
         <span class="sec_name">가는날짜 선택:</span>
   
         <input type="text" name="StartDate" id="datepicker" value="<%=getSdate%>">               
   
         <span class="sec_name">오는날짜 선택:</span>
   
         <input type="text" name="EndDate" id="datepicker2" value="<%=getEdate%>">
         
         <br><br><br>
                        
         <%-- DB에서 가져와서 LIST로 출력 --%>
         <span class="sec_name">비행기 선택:</span>
         <br>
         <select id="air_select" name="air_select">
            <%
               IBookingDao dao = BookingDao.getInstance();
               List<BookingDto> list = dao.airList(getSdate, getEdate);
                  
               /*
               for(int i=0; i<list.size(); i++){
                  System.out.println("list: " + list.get(i).toString());
               }
               */
               
               %>
               <%
                  if(list.size() == 0){
                     %>
                        <option value="x">날짜에 일치한 비행기가 없습니다.</option>                                    
                     <%                                    
                  }else{
                     if(eLocation == null){
                        %>
                        <option value="x">비행기를 선택해주세요.</option>
                        <%
                     }else{
                        %>
                        <option value="<%=eLocation %>"><%=eLocation %></option>
                        <%      
                     }
                     for(int i=0; i<list.size(); i++){
                        
                        
                        String StimeSet = list.get(i).getA_time_s();
                           StimeSet = StimeSet.substring(8);
                           StimeSet = StimeSet.substring(0, 2) + ":" + StimeSet.substring(2, 4);
                        
                        String EtimeSet = list.get(i).getA_time_e();
                           EtimeSet = EtimeSet.substring(8);
                           EtimeSet = EtimeSet.substring(0, 2) + ":" + EtimeSet.substring(2, 4);
                        
                        String set = list.get(i).getA_location_s() + "->" + list.get(i).getA_location_e() + "(" + StimeSet + "/" + EtimeSet + ")";
                        %>
                        <option value="<%=set%>"><%=set%></option>
                     <%
                     }
                  }
               %>
         </select>
         
         <%-- <input type="hidden" name="eLocation" value="<%=eLocation%> "> --%>
         
         <script type="text/javascript">
            $(document).ready(function() {
               $("#datepicker2").change(function() {
                  var datepicker = $("#datepicker").val();
                  var datepicker2 = $("#datepicker2").val();
                  
                  location.href="index.jsp?sdate=" + datepicker + "&edate=" + datepicker2;
               });
            });
         </script>
         
         <script type="text/javascript">
            var select = document.getElementById("air_select");                   
         
            $(document).ready(function() {
               $("#air_select").change(function() {
                  
                  // alert("상품 선택: " + select.options[select.selectedIndex].value);
                  
                  location.href="index.jsp?sdate=" + <%=getSdate%> + "&edate=" + <%=getEdate%> + "&eLocation=" + select.options[select.selectedIndex].value;
               });
            });
         </script>
   
         <br><br><br>
   
         <span class="sec_name">상품 선택:</span>
         <br>
         <select id="product_select" name="product_select">
            <%
               System.out.println("product_select의 log_eLocation: " + eLocation);
               if(eLocation == null)
               {
                  System.out.println("product_select의 log_eLocation은 NULL");
                  eLocation = "";
                  %>
                  <option value="x">먼저 날짜를 통해서 비행기를 선택해주세요!</option>
                  <%
               }else{
                  IPackageDao PackDao = PackageDao.getInstance();
                  
                  /*
                  int idx = eLocation.indexOf(">");
                  eLocation = eLocation.substring(idx+1);
                  */
                  
                  if(!eLocation.equals("")){
                     int idx = eLocation.indexOf(">");
                     eLocation = eLocation.substring(idx+1);
                     idx = eLocation.indexOf("(");
                     eLocation = eLocation.substring(0, idx);
                  }                              
                  
                  System.out.println("상품선택의 eLocation.substring Result: " + eLocation); 
                  
                  
                  String setDate = dao.doDiffOfDate(getSdate, getEdate);
                                                
                  List<PackageDto> PackList = PackDao.PackageList(eLocation, setDate);   
                  
                  
                  
                  %>
                  <option value="x">상품을 선택해주세요.</option>                                    
                  <%
                  for(int i=0; i<PackList.size(); i++){
                	  getP_num = PackList.get(i).getP_num();
                	  System.out.println("★★★★★ main.jsp의 getP_num: " + getP_num);
                  %>
                     <option value="<%=PackList.get(i).getP_name()%>"><%=PackList.get(i).getP_name()%></option>
                  <%
                  }
               }
            %>                     
         </select>
   
         <br><br><br>
   
         <span class="sec_name">인원 선택: </span>
         <br>
         &nbsp;&nbsp;&nbsp;&nbsp;<span class="peopleName">성인 / 만12세이상</span> &nbsp;&nbsp; <span class="peopleName">아동 / 만12세미만</span> &nbsp;&nbsp; <span class="peopleName">유아 / 24개월미만 </span>
         <br>
         <select id="adt" name="adt" class="peopleNum">
            <option value="1">성인1명</option>
            <option value="2">성인2명</option>
            <option value="3">성인3명</option>
            <option value="4">성인4명</option>
            <option value="5">성인5명</option>
            <option value="6">성인6명</option>
            <option value="7">성인7명</option>
            <option value="8">성인8명</option>
            <option value="9">성인9명</option>
            <option value="0">성인0명</option>
         </select>
   
         <select id="chi" name="chi" class="peopleNum">
            <option value="0">아동0명</option>
            <option value="1">아동1명</option>
            <option value="2">아동2명</option>
            <option value="3">아동3명</option>
            <option value="4">아동4명</option>
            <option value="5">아동5명</option>
            <option value="6">아동6명</option>
            <option value="7">아동7명</option>
            <option value="8">아동8명</option>
            <option value="9">아동9명</option>
         </select>
   
         <select id="inf" name="inf" class="peopleNum">
            <option value="0">유아0명</option>
            <option value="1">유아1명</option>
            <option value="2">유아2명</option>
            <option value="3">유아3명</option>
            <option value="4">유아4명</option>
            <option value="5">유아5명</option>
            <option value="6">유아6명</option>
            <option value="7">유아7명</option>
            <option value="8">유아8명</option>
            <option value="9">유아9명</option>
         </select>
         
         <br><br><br>
         
         <span class="sec_name">좌석 선택: </span>
   
         <select name="seat_select" id="seat_select">
            <option>일반석</option>
            <option>비즈니스석</option>
            <option>일등석</option>
         </select>
   </form>
   
         <br><br>
   
         <span class="sec_name">총가격: </span>
   
         <input type="text"  id="total_price" readonly="readonly">
   
         <%
            if(dto.getId().equals("")){
               %>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="notloginBtn" class="ui button">로그인을 먼저 해주세요.</button>
               
               <script type="text/javascript">
                  $(document).ready(function() {
                     $("#notloginBtn").click(function() {
                        alert("로그인을 해주세요.");
                        location.href="index.jsp?";                                                      
                     });
                  });
               </script>
               <%
            }else{
               %>
               
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="resBtn" class="ui button" 
               disabled="disabled" onclick="parameter(<%=getP_num%>)">예약</button>
               
               <script type="text/javascript">	
				//만약 1순위로 출력할 쿠키에 이미 값이 저장되어있다면 1순위를 2순위로 밀어내고, 1순위에 새로운 쿠키값을 저장한다. -----(1)
				//하지만 1순위에 저장할쿠키값이 이미 같다면 밀어내지않는다. 하지만 같은 값이라도 시간을 갱신해주기위해  값을저장하도록한다. ----(2)
				//접근방식은 상품 검색시, 또는 상품예약시 해당하는 p_num 을 parameter값으로 넘겨주도록한다. 아래 방식참고
				
				function parameter(name) {
				   alert("parameter"+name);
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
               
				
               <script type="text/javascript">
                  
                  $(function() {
                     $("[name='StartDate']").blur(function() {
                        process();
                     });
                     $("[name='EndDate']").click(function() {
                        process();
                     });
                     $("[name='air_select']").click(function() {
                        process();
                     });
                     $("[name='product_select']").click(function() {
                        process();
                     });
                  });
                  
                  function process() {
                     //alert("발생완료");
                     //모든 입력창이 입력이 됐는지 확인
                  
                     if($("[name='StartDate']").val() !=""){
                        if($("[name='EndDate']").val() !=""){
                           if($("[name='air_select']").val() != "x"){
                              if($("#product_select").val() !="x"){
                                    $("#resBtn").removeAttr("disabled");
                              }
                              else{
                                 $("#resBtn").prop('disabled','disabled');
                              }
                           }
                           else{
                              $("#resBtn").prop('disabled','disabled');
                           }
                        }
                        else{
                           $("#resBtn").prop('disabled','disabled');
                        }
                     }
                     else{
                        $("#resBtn").prop('disabled','disabled');
                     }
                  }
                  
                  
                  $("#resBtn").click(function() {
                     $("[name='frm']").submit();
                  });
               </script>
               <%
            }                        
         %>
         
         <br><br>
         
         
         참고사항!<br>
         &nbsp;&nbsp;&nbsp;&nbsp;<font color="red">반드시 로그인을 해주세요.</font><br>
         &nbsp;&nbsp;&nbsp;&nbsp;1. 총가격에 로그인을 하게 되면 등급별로 자동 할인이 적용 됩니다.<br>
         &nbsp;&nbsp;&nbsp;&nbsp;2. 성인은 원가, 아동은 성인의 80%, 유아는 성인의 50% 가격이 적용됩니다.<br>
         &nbsp;&nbsp;&nbsp;&nbsp;3. 일반석은 원가 / 비즈니스석은 일반석의 20%추가 / 일등석은 일반석의 50% 추가<br>

   </div>
               
   
   
   <div id="body_2">
      <%-- 지금 뜨는 여행 --%>
      <div class="slideshow-container">
      	
      	<div class="mySlides fade">
          <img src="../image/now/test5.jpg">
        </div>
      	
      	<div class="mySlides fade">
          <img src="../image/now/test6.jpg">
        </div>      	
      
        <div class="mySlides fade">
          <img src="../image/now/test.jpg">
        </div>
        
        <div class="mySlides fade">
          <img src="../image/now/test4.jpg">
        </div>
      
        <div class="mySlides fade">
          <img src="../image/now/test2.jpg">
        </div>
        
        <div class="mySlides fade">
          <img src="../image/now/test3.jpg">
        </div>
        
        <div class="mySlides fade">
          <img src="../image/now/test7.jpg">
        </div>
      </div>
      
      <script>
      var slideIndex = 0;
      showDivs();

      function showDivs() {
         var i;
          var x = document.getElementsByClassName("mySlides");
          for (i = 0; i < x.length; i++) {
             x[i].style.display = "none";  
          }
          slideIndex++;
          if (slideIndex > x.length) {slideIndex = 1}    
          x[slideIndex-1].style.display = "block";  
          setTimeout(showDivs, 5000); // Change image every 2 seconds
      }
      </script>      
   </div>
   
         
         
   <%-- Main 달력 --%>
   <div id="body_3">
         <jsp:include page="main_calendar.jsp"/>
      </div>
         
         
         
   <%-- Main 순위 --%>      
   <div id="body_4">
      <jsp:include page="reserve_rank.jsp"/>
   </div>
 
 
 
    <%-- Main 최근 본 상품 --%>
   <div id="body_5">
      <div>
         <jsp:include page="recent.jsp"/>
      </div>
   </div>
   
   </div>
   
   <script type="text/javascript">
      $(document).ready(function() {
         $("[name='product_select']").change(function() {
            
            var pd_select = document.getElementById("product_select");
            
            //alert("상품 선택: " + pd_select.options[pd_select.selectedIndex].value);

         
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); //change End 
         
         $("[name='adt']").change(function() {
            var adt_num = document.getElementById("adt");
            
            //alert("성인 인원: " + adt_num.options[adt_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         $("[name='chi']").change(function() {
            var chi_num = document.getElementById("chi");
            
            //alert("아동 인원: " + chi_num.options[chi_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         
         $("[name='inf']").change(function() {
            var inf_num = document.getElementById("inf");
            
            //alert("유아 인원: " + inf_num.options[inf_num.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val(),
                  "inf_num":$("[name='inf']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
         
         $("[name='seat_select']").change(function() {
            var seat = document.getElementById("seat_select");
            
            //alert("선택 좌석: " + seat.options[seat.selectedIndex].value);
            
            $.ajax({
               type:"GET",
               data:{
                  "Sdate":$("[name='StartDate']").val(),
                  "Edate":$("[name='EndDate']").val(), 
                  "eLocation":$("[name='air_select']").val(),
                  "product":$("[name='product_select']").val(),
                  "adt_num":$("[name='adt']").val(),
                  "chi_num":$("[name='chi']").val(),
                  "inf_num":$("[name='inf']").val(),
                  "seat":$("[name='seat_select']").val()
               },
               url:"../booking/main_booking_price.jsp",
               success:function(data){
                  $("#total_price").val(data);
               },
               error:function(xhr, status, error){
                  $("#total_price").val("상품을 선택해주세요!");
               }
            }); // ajax end
         }); // change end
         
      });
   </script>
   
   <script type="text/javascript">
        $.datepicker.setDefaults({
           duration: 'normal',
           dateFormat: 'yy-mm-dd',
           prevText: '이전 달',
           nextText: '다음 달',
           monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           dayNames: ['일', '월', '화', '수', '목', '금', '토'],
           dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
           dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
           showMonthAfterYear: true,
           yearSuffix: '년',
           minDate: 0
       });
        
        $( function() {
          $('#datepicker').datepicker();
          $('#datepicker2').datepicker();
        } );
     </script>
   
   </body>
</html>