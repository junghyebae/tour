<%@page import="admin.AirplainDao"%>
<%@page import="admin.IAirplainDao"%>
<%@page import="admin.ReserveDto"%>
<%@page import="admin.ReserveDao"%>
<%@page import="admin.IReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int r_num = Integer.parseInt(request.getParameter("r_num"));
System.out.println("r_num= "+r_num);
IReserveDao reDao = ReserveDao.getInstance();
ReserveDto reDto = reDao.getreserve(r_num);

IAirplainDao airDao = AirplainDao.getInstance();


boolean isS = false;
boolean isSS = false;
if(reDto !=null){
	
	if(reDto.getR_state()==0){
		//취소상태에선 기록삭제 실행
		isS = reDao.deleteReserve(r_num);
		isSS = true;
	}
	else if(reDto.getR_state()==1){
		//대기상태에선 취소상태로 변경
		isS = reDao.updateState(reDto, 0);
		//좌석수 증가시키기
		if(reDto.getR_pple_seat().equals("일등석")){
			isSS = airDao.cancelSeat(reDto.getR_pple_num_adt()+reDto.getR_pple_num_chi()+reDto.getR_pple_num_inf(),
					1, reDto.getR_info_num());
		}
		else if(reDto.getR_pple_seat().equals("비즈니스석")){
			isSS = airDao.cancelSeat(reDto.getR_pple_num_adt()+reDto.getR_pple_num_chi()+reDto.getR_pple_num_inf(),
					2, reDto.getR_info_num());
		}
		else if(reDto.getR_pple_seat().equals("일반석")){
			isSS = airDao.cancelSeat(reDto.getR_pple_num_adt()+reDto.getR_pple_num_chi()+reDto.getR_pple_num_inf(),
					3, reDto.getR_info_num());
		}
	}
	else if(reDto.getR_state()==2){
		//완료상태에선 기록삭제 실행
		isS = reDao.deleteReserve(r_num);
		isSS = true;
	}
}
if(isS && isSS){
	%>
	<script type="text/javascript">
	alert("처리 성공");
	location.href = "index.jsp?showPage=admin_reserveList";
	</script>
	<%
}
else{
	%>
	<script type="text/javascript">
	alert("처리 실패");
	location.href = "index.jsp?showPage=admin_reserveList";
	</script>
	<%
}
%>
</body>
</html>