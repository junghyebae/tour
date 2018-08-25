<%@page import="main.BookingDto"%>
<%@page import="java.util.List"%>
<%@page import="main.BookingDao"%>
<%@page import="main.IBookingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
--%>
<%@ page import="java.*" %>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<meta charset='utf-8' />
		
		<link href='../Full_Calendar/fullcalendar.min.css' rel='stylesheet' />
		<link href='../Full_Calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
		<script src='../Full_Calendar/lib/moment.min.js'></script>
		<script src='../Full_Calendar/lib/jquery.min.js'></script>
		<script src='../Full_Calendar/fullcalendar.min.js'></script>
		<script>
		
			$(document).ready(function() {
				
				var NowDate = new Date();
				
				var month = NowDate.getMonth();
					month = Number(month) + 1;

				if(month.lengh = 1){
					month = String(month);
					month = "0" + month;
				}


				var setDate = NowDate.getFullYear();
					setDate += '-' + month;
					setDate += '-' + NowDate.getDate();

				$('#calendar').fullCalendar({
					header: {
						left: 'prev,next today',
						center: 'title',
						right: 'month,listWeek'
					},
					defaultDate: setDate,
					navLinks: true, // can click day/week names to navigate views
					editable: true,
					eventLimit: true, // allow "more" link when too many events
					events: [
						<%
						IBookingDao bdao = BookingDao.getInstance();
						
						List<BookingDto> airlist = bdao.getAirList();
						
						for(int i = 0; i < airlist.size(); i++){
							
							String stemp = airlist.get(i).getA_time_s();							
							String stime = stemp.substring(0, 4) + "-" + stemp.substring(4,6) + "-" + stemp.substring(6,8) + "T" + stemp.substring(8,10) + ":" + stemp.substring(10,12) + ":00";
							
							String etemp = airlist.get(i).getA_time_e();
							String etime = etemp.substring(0, 4) + "-" + etemp.substring(4,6) + "-" + etemp.substring(6,8) + "T" + etemp.substring(8,10) + ":" + etemp.substring(10,12) + ":00";
							
							%>
							{
								title: '<%=airlist.get(i).getA_location_s() + "->" + airlist.get(i).getA_location_e()%>',
								start: '<%=stime%>',
								end: '<%=etime%>'
							},
							<%
						}
						%>

						{
							title: 'Google로 이동',
							url: 'http://google.com/',
							start: '2017-09-01'
						}
					]
				});
				
			});
		
		</script>
		<style>

			#calendar {
				max-width: 777px;
				/*margin: 0 30px;*/
				font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
				font-size: 14px;
				display: table; 
				margin-top: 33px;
				margin-left: auto; 
				margin-right: auto;
			}
		
		</style>
	</head>
	
	<%-- style="background-image: url('http://www.telegraph.co.uk/content/dam/video_previews/x/5/x5cgi0ode66q6vuxezqmehmexwer6bt-xlarge.jpg');" --%>
	<body>	
		<div id='calendar'></div>		
	</body>
</html>