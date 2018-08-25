<%@page import="admin.MemberDto_AD"%>
<%@page import="java.util.List"%>
<%@page import="admin.MemberDao_AD"%>
<%@page import="admin.IMemberDao_AD"%>
<%@page import="paging.PagingBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>memberList</title>
</head>
<body>

<%
PagingBean paging2 = new PagingBean();
if(request.getParameter("nowPage") == null){
	paging2.setNowPage(1);
}else{
	paging2.setNowPage(Integer.parseInt(request.getParameter("nowPage")));	// 페이지가 넘어오면 그 페이지 세팅
}
%>

<%
IMemberDao_AD dao = MemberDao_AD.getInstance();
// List<MemberDto_AD> list = dao.getMemberList();
List<MemberDto_AD> list = dao.getMemberListPaging(paging2);
%>

<h2 align="center">회원관리리스트</h2>
<form action="../main/index.jsp" onsubmit="return check()">
<input type="hidden" name="showPage" value="AD_update_mem">
<input type="hidden" name="send" value="not">
<input type="hidden" name="num" value="">
	<table border="1" align="center" style="border-collapse: collapse;" cellpadding="8px">
		<tr>
			<th>no.</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>핸드폰번호</th>
			<th>이메일</th>
			<th>생년월일</th>
			<th>등급</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%for(int i = 0; i < list.size(); i ++){
			MemberDto_AD dto = list.get(i);
			%>
		<tr id="<%=i %>">
			<%
		//번호정보
		if(request.getParameter("nowPage")==null){
			int nowPage = 1;
			%>
			<td><%=(i+1)+((nowPage-1)*15)%></td>
			<%
		}
		else{
			int nowPage = Integer.parseInt(request.getParameter("nowPage"));
			%>
			<td><%=(i+1)+((nowPage-1)*15)%></td>
			<%
		}
		%>
			<td>
				<input name="id<%=i %>" type="hidden" value="<%=dto.getId() %>" readonly="readonly" >
				<a href="../admin/memberRes.jsp?id=<%=dto.getId() %>" onclick="window.open(this.href,'_blank','width=800,height=600, scrollbars=yes');return false;">
					<%=dto.getId() %>
				</a>
			</td>
			<td>
				<input name="pwd<%=i %>" type="text" value="<%=dto.getPwd() %>" readonly="readonly">
			</td>
			<td>
				<input name="name<%=i %>" type="text" value="<%=dto.getName() %>" readonly="readonly">
			</td>
			<td>
				<input name="phone<%=i %>" type="text" value="<%=dto.getPhone() %>" readonly="readonly">
			</td>
			<td>
				<input name="email<%=i %>" type="text" value="<%=dto.getEmail() %>" readonly="readonly">
			</td>
			<td>
				<input name="birth<%=i %>" type="text" value="<%=dto.getBirth() %>" readonly="readonly">
			</td>	
			<td>
				<input name="grade<%=i %>" type="text" value="<%=dto.getGrade() %>" readonly="readonly">
			</td>
			<td>
				<button type="submit" id="update" onclick="update1(<%=i %>)" value="u1">수정</button>
			</td>
			<td>
				<%-- <button type="button" onclick="location.href='../main/index.jsp?showPage=delMember_AD&id=<%=dto.getId() %>'">삭제</button> --%>
				<a href="../main/index.jsp?showPage=delMember_AD&id=<%=dto.getId() %>">
					<button type="button" onclick="return confirm('회원을 삭제하시겠습니까?');">삭제</button>
				</a>
			</td>
		</tr>
			<%
		}
		%>
	</table>
</form>

<!-- include(고급태그) -->
<jsp:include page="../admin/paging2.jsp">
   
   <jsp:param name="actionPath" value="../main/index.jsp" />
   <jsp:param name="nowPage" value="<%=String.valueOf(paging2.getNowPage()) %>"/>
   <jsp:param name="totalCount" value="<%=String.valueOf(paging2.getTotalCount()) %>" />
   <jsp:param name="countPerPage" value="<%=String.valueOf(paging2.getCountPerPage()) %>" />
   <jsp:param name="blockCount" value="<%=String.valueOf(paging2.getBlockCount()) %>" />

</jsp:include>


<script type="text/javascript">

// update
function update1(num) {
	if($("#update").val() == "u1"){
//		alert("u1");
		// readonly 풀어주기
		$("#" + num + " td input").removeAttr("readonly");		
		// 다시 readonly 세팅
		$("#" + num + " td input[name='id"+num+"']").attr("readonly", "readonly");
		$("#" + num + " td input[name='email"+num+"']").attr("readonly", "readonly");
		// value값 바꿔주기
		$("#update").val("u2");
	}else{
//		alert("u2");
		// readonly세팅
		$("#" + num + " td input").attr("readonly", "readonly");		
		// value값 바꿔주기
		$("#update").val("u1");		
		// num..?
		$("[name='num']").val(num);		
		//	submit되도록
		$('[name="send"]').val("ok");
	}	
};

function del(num) {
	alert(num);
}

// form action 막아주기
function check() {
	if($('[name="send"]').val() != "ok"){
		return false;
	}
}

</script>


</body>
</html>
