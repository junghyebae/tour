<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
String id = request.getParameter("id");
String email = request.getParameter("email");
String email_ad = request.getParameter("email_ad");

IMemberDao dao = MemberDao.getInstance();
String pwd = dao.findPwd(id, email+"@"+email_ad);

if(pwd != null && !pwd.equals("")){
	out.print("ã���ô� ��й�ȣ�� '" + pwd + "' �Դϴ�.");
}else{
	out.print("ã���ô� ��й�ȣ�� �����ϴ�");
}
%>