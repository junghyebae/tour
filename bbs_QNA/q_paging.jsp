<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String actionPath = request.getParameter("actionPath");

String sNowPage = request.getParameter("nowPage"); //현재 페이지

String sTotalCount = request.getParameter("totalCount"); // 올린 글의 수

String sCountPerPage = request.getParameter("countPerPage"); // 10

String sBlockCount = request.getParameter("blockCount"); //블록의 갯수(10)

System.out.println("sNowPage:"+sNowPage);
System.out.println("sTotalCount:"+sTotalCount);
System.out.println("sCountPerPage:"+sCountPerPage);
System.out.println("sBlockCount:"+sBlockCount);

//제일첫번째 들어왔을경우 nowPage 에다 1을 넣도록한다.
int nowPage = (sNowPage ==null || sNowPage.trim().equals(""))?1:Integer.parseInt(sNowPage);

//totalCount
int totalCount = (sTotalCount ==null || sTotalCount.trim().equals(""))?0:Integer.parseInt(sTotalCount);

//countPerPage
int countPerPage = (sCountPerPage ==null || sCountPerPage.trim().equals(""))?1:Integer.parseInt(sCountPerPage);

//countPerBlock
int countPerBlock = (sBlockCount ==null || sBlockCount.trim().equals(""))?1:Integer.parseInt(sCountPerPage);

//페이지 갯수구하기
int totalPage = (int)((totalCount - 1)/countPerPage)+1; // 12개의 글이 있다면 2개의 페이지를 만들도록한다
	//(12-1)10 = 1이나오게 되고 1+1을 해서 2개의 페이지가 나오게된다
System.out.println("totalPage:"+totalPage);	

//블록 갯수구하기
int totalBlock = (int)((totalPage - 1) / countPerBlock);
int nowBlock = (int)((nowPage -1)/countPerBlock); //현재블록갯수구하기

int firstPage = 0; //첫번째 페이지
int prevPage = 0;  //이전 페이지
int nextPage = 0; //다음페이지
int lastPage = 0; //마지막 페이지
// [첫페이지][이전페이지] [1][2][3][4][5] [다음페이지][마지막페이지]

//적어도 블록이 1개이상이라면
if(nowBlock >0){
	firstPage = 1;
}
if(nowPage >1){
	prevPage = nowPage-1; //이전페이지 버튼 입력시 현재페이지에서 -1 한 값으로 이동
}
int startPage = nowBlock * countPerBlock + 1; //현재 페이지가 1페이지고 countPerBlock= 10이니 1*10+1= 11

int endPage = countPerBlock * (nowBlock+1); //10 * (0+1) 현재블록이0번째라면 endPage는 10페이지가 된다.

//최대 페이지보다 끝 페이지가 큰 경우(넘어가면안되기때문에)
if(endPage > totalPage){
	endPage = totalPage;
}
//페이지숫자를 넘어간경우
if(nowPage < totalPage){
	nextPage = nowPage+1;
}

//현재 페이지가 총 블록보다 작은경우, 마지막 페이지에 총 페이지를 대입함
if(nowBlock <totalBlock){
	lastPage = totalPage;
}

System.out.println("totalBlock:"+totalBlock);
System.out.println("nowBlock:"+nowBlock);

//리스트타입 가져오기(notice)
String listType = request.getParameter("listType");
String button_group = request.getParameter("button_group");

%>

<script>
function gotoPage(pageNum) {
	var objForm = document.frmPaging;
	objForm.nowPage.value = pageNum;
	objForm.submit(); //action실행(form의 action실행되도록 하는 함수)
}

 
</script>

<form name ="frmPaging" method="get" action="<%=actionPath%>">

	<%
	if(listType.equals("notice")){
		%>
		<input type="hidden" name="showPage" value="notice">
		<%
	}else if(listType.equals("qna")){
		System.out.println("q_paging.jsp  버튼번호 :  " + button_group);
		%>
		<input type="hidden" name="showPage" value="qna">
		<input type="hidden" name="button_group" value="<%=button_group%>"> 
		<% 
	}else{
		%>
		<input type="hidden" name="showPage" value="c">
		<%
	}
	%>
	<input type="hidden" name="nowPage">
	
	<div align = "center">
	<!-- 조건이없으면 링크가 다나오게됨 -->
		<!-- 처음페이지표현 [처음]-->
		<%
		if(firstPage >0){
			%>
			<a href="#" onclick="gotoPage('<%=firstPage %>')">[처음]</a>
			<%
		}
		%>
		
		<!-- 이전페이지표현 [이전] -->
		<%
		if(prevPage >0){
			%>
			<a href="#" onclick="gotoPage('<%=prevPage %>')">[이전]</a>
			<%
		}
		%>
		
		<!-- [1] [2] [3] [4] .. 페이지 표현 -->
		<%
		for(int i=startPage; i<=endPage; i++){
			//현재페이지와 같을때 즉 1페이지면 [1] [2] [3] -> 1 [2] [3]
			if(i == nowPage){
				%>
				<%=i %>
				<%
			}
			else{
				%>
				<a href ="#" onclick="gotoPage('<%=i %>')">[<%=i %>]</a>
				<%
			}
		}
		%>
		
		<!-- 다음페이지표현 [다음] -->
		<%
		if(nextPage >0){
			%>
			<a href="#" onclick="gotoPage('<%=nextPage %>')">[다음]</a>
			<%
		}
		%>
		
		<!-- 마지막페이지표현 [끝] -->
		<%
		if(lastPage >0){
			%>
			<a href="#" onclick="gotoPage('<%=lastPage %>')">[끝]</a>
			<%
		}
		
		%>
	
	
	</div>

</form>







