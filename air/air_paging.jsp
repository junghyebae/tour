<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String actionPath = request.getParameter("actionPath");   // bbslist.jsp

String sNowPage = request.getParameter("nowPage"); // 현재 페이지
String sTotalCount = request.getParameter("totalCount"); // 올린 글수
String sCountPerPage = request.getParameter("countPerPage");   // 10 
String sBlockCount = request.getParameter("blockCount");   // 10

System.out.println("sNowPage:" + sNowPage);
System.out.println("sTotalCount:" + sTotalCount);
System.out.println("sCountPerPage:" + sCountPerPage);
System.out.println("sBlockCount:" + sBlockCount);

int nowPage = (sNowPage == null || sNowPage.trim().equals(""))?1:Integer.parseInt(sNowPage);
// 현재의 페이지 [1] 2 [3] -> 2 
int totalCount = (sTotalCount == null || sTotalCount.trim().equals(""))?0:Integer.parseInt(sTotalCount);
int countPerPage = (sCountPerPage == null || sCountPerPage.trim().equals(""))?1:Integer.parseInt(sCountPerPage);
int countPerBlock = (sBlockCount == null || sBlockCount.trim().equals(""))?1:Integer.parseInt(sBlockCount);

int totalPage = (int)((totalCount - 1)/countPerPage) + 1;
//       2    =            12      - 1 / 10  + 1
System.out.println("totalPage:" + totalPage);

int totalBlock = (int)((totalPage - 1) / countPerBlock);   // ([1] [2] ~ [10]) -> 0 ([11] [12] ~ [20]) -> 1 
int nowBlock = (int)((nowPage - 1) / countPerBlock);   // ([1] [2] ~ [10]) -> 0 현재 블록

int firstPage = 0;
int prevPage = 0;
int nextPage = 0;
int lastPage = 0;   //   [첫페이지][이전페이지][1][2][3][다음페이지][끝페이지]    

if(nowBlock > 0){
   firstPage = 1;
}
if(nowPage > 1){
   prevPage = nowPage - 1;
}

int startPage = nowBlock * countPerBlock + 1;
//   11      =    1     *      10      +     1 
int endPage = countPerBlock * (nowBlock + 1);
//  10      =      10      *         0   +    1           
       
// 최대 페이지보다 끝 페이지가 큰 경우
if(endPage > totalPage) endPage = totalPage;

if(nowPage < totalPage){
   nextPage = nowPage + 1;
}

// 현재 페이지가 총 블록보다 작은 경우, 마지막 페이지에 총 페이지를 대입
if(nowBlock < totalBlock){
   lastPage = totalPage;
}

System.out.println("totalBlock:" + totalBlock);
System.out.println("nowBlock:" + nowBlock);

%>

<script>
function gotoPage(pageNum) {
   var objForm = document.frmPaging;
   objForm.nowPage.value = pageNum;
   objForm.submit();   // form 의 Action을 실행되도록 하는 함수
}
</script>    
<% String listType = request.getParameter("listType");%>

<form name="frmPaging" method="get" action="<%=actionPath %>">
   <input type="hidden" name="nowPage">
   
   <%
   if(listType.equals("shSimpleAirList")){
      %>
      <input type="hidden" name="showPage" value="shSimpleAirList">
      <%
   }%>
   
   <div align="center">
      <!-- 처음페이지 [처음]-->
      <%if(firstPage > 0){ %>
         <a href="#" onclick="gotoPage('<%=firstPage %>')">[처음]</a>
      <%} %>
      <!-- 이전페이지 [이전]-->
      <%if(prevPage > 0){ %>
         <a href="#" onclick="gotoPage('<%=prevPage %>')">[이전]</a>
      <%} %>
      <!-- [1] 2 [3]-->
      <%
      for(int i = startPage; i <= endPage; i++){
         if(i == nowPage){  %>
            <%=i %>
         <%         
         }else{
         %>
            <a href="#" onclick="gotoPage('<%=i %>')">[<%=i %>]</a>
         <%      
         }
      }      
      %>      
      <!-- 다음페이지 [다음]-->
      <%
      if(nextPage > 0){
      %>
         <a href="#" onclick="gotoPage('<%=nextPage %>')">[다음]</a>
      <%
      }
      %>
   
      <!-- 끝페이지 [마지막]-->
      <%
      if(lastPage > 0){
      %>
         <a href="#" onclick="gotoPage('<%=lastPage %>')">[끝페이지]</a>
      <%
      }
      %>
   </div>
</form>