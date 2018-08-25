<%@page import="mem.MemberDao"%>
<%@page import="mem.IMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String id = request.getParameter("id");
IMemberDao dao = MemberDao.getInstance();
boolean isS = dao.checkId(id);
if(isS){
	out.print("yes");
}else{
	out.print("no");
}
%>
