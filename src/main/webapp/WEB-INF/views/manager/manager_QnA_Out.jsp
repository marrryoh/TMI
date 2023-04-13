<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
<div class="board">
   <div class="board_top"><h3>문의 게시판</h3></div>
<table border="1" align="center" width="800">
<tr height="30">
	<th>글번호</th> <th>ID</th> <th>분류</th>
	<th>제목</th> <th>날짜</th> <th>HIT</th>
</tr>
<c:forEach items="${list}" var="my">
<tr height="50">
		<td>${my.bo_num}</td> <td>${my.bo_id}</td>
		<td>${my.bo_type}</td> <td width="45%"><a href="mg_boardDetail?bo_num=${my.bo_num}">${my.bo_title}</a></td>		
		<fmt:parseDate value="${my.bo_day}" var="wday" pattern="yyyy-MM-dd HH:mm:ss"/>
		<td><fmt:formatDate value="${wday}" pattern="yy-MM-dd"/> </td>
		<c:choose>
			<c:when test="${my.bo_ox!='0'}">
				<td>&#128491;</td>
			</c:when>
			<c:otherwise>
				<td>&#128448;</td>
			</c:otherwise>
		</c:choose>
</tr>
</c:forEach>
<!-- 페이징처리 -->
<tr style="border-left: none;border-right: none;border-bottom: none">
	<td colspan="6" style="text-align: center;">
	
	 <c:if test="${paging.startPage!=1 }">
      <a href="manager_QnA_Out?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a>
   </c:if>
   
      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
         <c:choose>
            <c:when test="${p == paging.nowPage }">
               <b><span style="color: red;font-family: bold">${p}</span></b>
            </c:when>   
            <c:when test="${p != paging.nowPage }">
               <a href="manager_QnA_Out?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
            </c:when>   
         </c:choose>
      </c:forEach>
      
      <c:if test="${paging.endPage != paging.lastPage}">
      <a href="manager_QnA_Out?nowPage=${pageing.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
   </c:if>
   </td>
</tr>
</table>
</div>
</div>
</body>
</html>