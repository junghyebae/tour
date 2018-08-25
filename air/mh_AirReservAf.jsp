<%@page import="main.BookingDto"%>
<%@page import="main.IBookingDao"%>
<%@page import="main.BookingDao"%>
<%@page import="admin.PackageDao"%>
<%@page import="admin.PackageDto"%>
<%@page import="admin.IPackageDao"%>
<%@page import="mem.MemberDto"%>
<%@page import="air.AirPlainDTO"%>
<%@page import="air.AirTotalInfoDTO"%>
<%@page import="air.AirReserveDAO"%>
<%@page import="air.IAirReserveDAO"%>
<%@page import="air.AirReserveDTO"%>
<%@page	import="air.AirProductDTO"%>
<%@page	import="air.AirProudctDAO"%>
<%@page	import="air.IAirProductDAO"%>
<%@	page	language="java"	contentType="text/html;	charset=UTF-8"
				pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
	MemberDto mem = null;
	mem = (MemberDto)ologin;
	
	if(mem == null){
		mem = new MemberDto("", "", "", "", "", "", 0, 0, 0,0);
	}
	
	String StartDate = request.getParameter("Sdate"); 
	String EndDate = request.getParameter("Edate");
	String air_select = request.getParameter("eLocation");
	String product_select = request.getParameter("product");
	String adt = request.getParameter("adt");
	String chi = request.getParameter("chi");
	String inf = request.getParameter("inf");
	String seat_select = request.getParameter("Air_seat");
	
	// 도착지 도시 구하기
	String select_location = "";
	int idx = air_select.indexOf(">");
	
	String temp_select = air_select.substring(idx+1);
	// ex) temp_select: 방콕(10:00/10:00)
	
	// 시간을 구하기 위해서 temp_select를 복제
	String temp_select2 = temp_select;
	
	idx = temp_select.indexOf("(");
	select_location = temp_select.substring(0, idx);
	// ex) select_location: 방콕
	
	// 출발지 구하기
	int sLoIdx = air_select.indexOf("-");
	air_select = air_select.substring(0, sLoIdx);

	// 출발시간 / 도착시간 구하기
	temp_select2 = temp_select2.substring(idx);
	//System.out.println("temp_select2: " + temp_select2);
	
	// 시간 구하기
	String Select_sTime = temp_select2.substring(1, 6);		
	String Select_eTime = temp_select2.substring(7, 12);		
	
	
	System.out.println("StartDate: " + StartDate);
	System.out.println("EndDate: " + EndDate);
	
	System.out.println("air_select: " + air_select);		
	System.out.println("select_location: " + select_location);
	
	System.out.println("Select_sTime: " + Select_sTime);
	System.out.println("Select_eTime: " + Select_eTime);
	
	System.out.println("product_select: " + product_select);
	
	System.out.println("adt: " + adt);
	System.out.println("chi: " + chi);
	System.out.println("inf: " + inf);
	
	System.out.println("seat_select: " + seat_select);
	
	
	// 날짜와 시간이 합쳐져 DB 데이터값과 동일하게 만드는 부분
	String info_start_date  = StartDate + Select_sTime.replace(":", "");
		//System.out.println("info_start_date: " + info_start_date);
	
	String info_end_date  = EndDate + Select_eTime.replace(":", "");
		//System.out.println("info_end_date: " + info_end_date);
	
	// pdao 생성 부분 / Package 정보를 가져오는 부분
	IPackageDao pdao = PackageDao.getInstance();
	PackageDto pdto = pdao.reservePackList(product_select);
		System.out.println("pdto: " + pdto.toString());
	
	// bdao 생성 부분 / Info 정보를 가져오는 부분
	IBookingDao bdao = BookingDao.getInstance();
	BookingDto bdto = bdao.reserveAnumList(air_select, select_location, info_start_date, info_end_date);
		System.out.println("bdto: " + bdto.toString());
	
		
	// 가격 설정 부분
	
		// 인원에 따른 분류 변수 
		int adt_num = Integer.parseInt(adt);
		int chi_num = Integer.parseInt(chi);
		int inf_num = Integer.parseInt(inf);
		
		// 인원 총원
		int total_num = adt_num + chi_num + inf_num;
		
		// 기존의 bdto의 A_price 부분의 값을 저장하는 변수
		int temp_a_price = bdto.getA_price();			
	
		// 좌석 등급에 따른 가격 조정 부분 
		if(seat_select.equals("일등석")){				
			// 남은 좌석수로 인한 에러 방지 부분
			if(bdto.getA_seat_one() >= total_num){
				bdto.setA_price(bdto.getA_price() + (int)(bdto.getA_price() * 0.5));
				System.out.println("일등석 가격(원래가격: " + temp_a_price + "): " + bdto.getA_price());
			}else{
				%>
				<script type="text/javascript">
					alert("일등석 좌석이 남아있지 않습니다. 다시 선택해주세요. (일등석 남은좌석: <%=bdto.getA_seat_one()%> / 비즈니스석 남은좌석: <%=bdto.getA_seat_two()%> / 일반석 남은좌석: <%=bdto.getA_seat_three()%>)");
					location.href="../main/index.jsp?";
				</script>
				<%
				return;
			}			
		}else if(seat_select.equals("비즈니스석")){				
			// 남은 좌석수로 인한 에러 방지 부분
			if(bdto.getA_seat_two() >= total_num){
				bdto.setA_price(bdto.getA_price() + (int)(bdto.getA_price() * 0.2));
				System.out.println("비즈니스 가격(원래가격: " + temp_a_price + "): " + bdto.getA_price());
			}else{
				%>
				<script type="text/javascript">
			     	alert("비즈니스 좌석이 남아있지 않습니다. 다시 선택해주세요. (일등석 남은좌석: <%=bdto.getA_seat_one()%> / 비즈니스석 남은좌석: <%=bdto.getA_seat_two()%> / 일반석 남은좌석: <%=bdto.getA_seat_three()%>)");
					location.href="../main/index.jsp?";						
				</script>
				<%
				return;
			}			
		}else if(seat_select.equals("일반석")) {
			// 남은 좌석수로 인한 에러 방지 부분
			if(bdto.getA_seat_three() >= total_num){
				System.out.println("일반석 가격(원래가격: " + temp_a_price + "): " + bdto.getA_price());
			}else{
				%>
				<script type="text/javascript">
					alert("일반석 좌석이 남아있지 않습니다. 다시 선택해주세요. (일등석 남은좌석: <%=bdto.getA_seat_one()%> / 비즈니스석 남은좌석: <%=bdto.getA_seat_two()%> / 일반석 남은좌석: <%=bdto.getA_seat_three()%>)");
					location.href="../main/index.jsp?";
				</script>
				<%
				return;
			}							
		}
	
		
		// 인원의 나이에 따른 할인 적용 부분 (adt = 성인은 할인X)
		int adt_price = (bdto.getA_price() + (int)pdto.getP_price()) * adt_num;
		
		int chi_price = (bdto.getA_price() + (int)pdto.getP_price()) * chi_num;
			// chi_price = Integer.parseInt(String.valueOf(chi_price * 0.8)); / 이 방법은 NumberFormatException 발생
			chi_price = (int)(chi_price * 0.8);
		
		int inf_price = (bdto.getA_price() + (int)pdto.getP_price()) * inf_num;
			//inf_price = Integer.parseInt(String.valueOf(inf_price * 0.5)); / 이 방법은 NumberFormatException 발생
			inf_price = (int)(inf_price * 0.5);
		
			
		// 총가격 변수
		int total_price = adt_price + chi_price + inf_price;
		
		
	
		
		
		// login한 user의 등급을 가져오는 부분 
		int user_grade = mem.getGrade();
		
		// % 계산을 위한 변수
		double temp_calc = 0;
		
		// 회원등급에 따른 total_price 조정 부분
		/*
		0~10 : 브론즈
		11~20: 실버
		21~30: 골드
		30~40 : 플레티넘
		41~50 : 다이아몬드
		*/
		if(user_grade > 0 && user_grade <= 10){
			temp_calc = total_price * 0.05;
			
			//total_price = total_price - Integer.parseInt(String.valueOf(temp_calc)); / 이 방법은 NumberFormatException 발생
			total_price = total_price - (int)(temp_calc);
		}else if(user_grade > 10 && user_grade <= 20){
			temp_calc = total_price * 0.1;
			
			total_price = total_price - (int)(temp_calc);
		}else if(user_grade > 20 && user_grade <= 30){
			temp_calc = total_price * 0.15;
			
			total_price = total_price - (int)(temp_calc);
		}else if(user_grade > 30 && user_grade <= 40){
			temp_calc = total_price * 0.20;
			
			total_price = total_price - (int)(temp_calc);
		}else if(user_grade > 40 && user_grade <= 50){
			temp_calc = total_price * 0.25;
			
			total_price = total_price - (int)(temp_calc);
		}else if(user_grade > 51){
			temp_calc = total_price * 0.5;
			
			total_price = total_price - (int)(temp_calc);
		}
		
		
		
		
		System.out.println("total_price: " + total_price);

	boolean isS2 = pdao.addBuycount(pdto.getP_name());
      
      // isS의 true or false값에 따라 alert창의 메시지를 출력
      if(isS2){
         System.out.println("성공적으로 예약한 상품의 BuyCount가 증가하였습니다.");
      }else{
         System.out.println("예약한 상품의 BuyCount증가가 실패 하였습니다.");
      }
	
	// reserve Table에 들어가는 부분
	boolean isS = bdao.mainBooking(mem.getId(), bdto.getA_num(), pdto.getP_name(), info_start_date, info_end_date, Integer.parseInt(adt), Integer.parseInt(chi), Integer.parseInt(inf), seat_select, total_price);
	
		// isS의 true or false값에 따라 alert창의 메시지를 출력
		if(isS){
			%>
			<script type="text/javascript">
				alert("예약에 성공하였습니다.");
				location.href="../main/index.jsp?";
			</script>
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("예약에 실패하였습니다.");
				location.href="../main/index.jsp?";
			</script>
			<%
		}
		
	bdao.decrementSeat(total_num, seat_select, bdto.getA_num());
		
	
	%>
	
	<script type="text/javascript">
		parameter(<%=pdto.getP_num()%>);	
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
</body>
</html>