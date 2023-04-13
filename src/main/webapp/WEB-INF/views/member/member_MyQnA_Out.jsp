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

<table border="1" align="center" width="800">
<caption><h2>My Board</h2></caption>
<tr height="30">
	<th>글번호</th> <th>분류</th>
	<th>제목</th> <th>날짜</th> <th>HIT</th>
</tr>
<c:forEach items="${list}" var="my" varStatus="status" >
<tr height="50">
		<td>${status.index + 1}</td>
		<td>${my.bo_type}</td> <td width="45%"><a href="mem_boardDetail?bo_num=${my.bo_num}"><strong>${my.bo_title}</strong></a></td>		
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
</table>
</div>
</div>
</body>
</html>








