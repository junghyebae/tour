<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
--%>
<%@ page import="java.*" %>    
    
<!DOCTYPE html>
<html ng-app="calendar">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<%-- Angular Calendar --%>
		<script src="../Angular_Calendar/angular.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
	    <link rel="stylesheet" type="text/css"  href="../Angular_Calendar/calendar.css"> 		
 		<script  src="../Angular_Calendar/moment.min.js"></script>
	    <script type="text/javascript">
		    moment.locale('kr', {
		        months : "1월_2월_3월_4월_5월_6월_7월_8월_9월_10월_11월_12월".split("_"),
		        monthsShort :  "1월_2월_3월_4월_5월_6월_7월_8월_9월_10월_11월_12월".split("_"),
		        weekdays : "일요일_월요일_화요일_수요일_목요일_금요일_토요일".split("_"),
		        weekdaysShort : "일._월._화._수._목._금_토.".split("_"),
		        weekdaysMin :"일._월._화._수._목._금_토.".split("_"),
		        ordinal : function (number) {
		            return number + '일'
		        }
	    });
	    </script>	    
	    <script  src="../Angular_Calendar/calendar.js"></script>
	    
	</head>
	
	<body>
		<div ng-controller="calendarWidget">
	    	<calendar selected="day"></calendar>	    	
		</div>
		
		
		
	</body>
</html>