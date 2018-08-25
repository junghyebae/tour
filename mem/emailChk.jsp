<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String email = request.getParameter("email");
String email_ad = request.getParameter("email_ad");
IMemberDao dao = MemberDao.getInstance();
boolean isS = dao.checkEmail(email+"@"+email_ad);
if(isS){
	out.print("yes");
}else{
	out.print("no");
}
%>