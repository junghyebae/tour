<%@page import="admin.ChartDao"%>
<%@page import="admin.ChartDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
ChartDao dao = new ChartDao();
ChartDto dto = dao.getGradeChart();

// System.out.println(dto.toString());


String grade = "[{ name:'Bronze회원', y:" + dto.getBronze() + " }, " + 
				"{ name:'Silver회원', y:" + dto.getSilver() + " }, " +
				"{ name:'Gold회원', y:" + dto.getGold() + " }, " +
				"{ name:'Platinum회원', y:" + dto.getPlatinum() + " }, " +
				"{ name:'Diamond회원', y:" + dto.getDiamond() + " }] ";
				
request.setAttribute("grade", grade);
%>



<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>


<script type="text/javascript">
Highcharts.chart('container', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: '회원 등급 차트'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
            }
        }
    },
    series: [{
        name: 'Brands',
        colorByPoint: true,
        data: <%=request.getAttribute("grade") %>
    }]
});
</script>

</body>
</html>