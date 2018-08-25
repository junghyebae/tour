<%@page import="admin.PackageDao"%>
<%@page import="admin.IPackageDao"%>
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

IPackageDao packDao = PackageDao.getInstance();


boolean isS = false;
boolean isSS = false;
if(reDto !=null){
   //System.out.println("넘버값="+reDto.getR_num());
   if(reDto.getR_state()==0){
      //취소상태에선 대기상태로 변경
      isS = reDao.updateState(reDto, 1);
      isSS = true;
   }
   else if(reDto.getR_state()==1){
      //대기상태에선 완료상태로 변경
      isS = reDao.updateState(reDto, 2);
      //상품구매수 증가
      isSS = packDao.addBuycount(reDto.getR_pack_name());
   }
   else if(reDto.getR_state()==2){
      //완료상태에선 접근이 불가능
      //isS = reDao.updateState(reDto, 1);
      isS = true;
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