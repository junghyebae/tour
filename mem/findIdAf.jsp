<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String email = request.getParameter("email");
String email_ad = request.getParameter("email_ad");
String phone1 = request.getParameter("phone1");
String phone2 = request.getParameter("phone2");
String phone3 = request.getParameter("phone3");

IMemberDao dao = MemberDao.getInstance();
String id = dao.findId(email+"@"+email_ad, phone1+"-"+phone2+"-"+phone3);

if(id != null && !id.equals("")){
	out.print("찾으시는 아이디는 '" + id + "' 입니다.");
}else{
	out.print("찾으시는 아이디가 없습니다");
}
%>