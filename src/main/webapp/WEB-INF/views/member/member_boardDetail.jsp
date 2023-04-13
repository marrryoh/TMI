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

<div class="QnAouter">
 <div id="QnA_Area">
   
   <div id="QnA_Area_top"><h2>Q n A</h2></div>
	
	 <div id="QnA_Area_title">
		<span id="QnA_spanArea"> ${myb.bo_type} &emsp;|&emsp;<b>${myb.bo_title}</b></span>
		<span id="QnA_spanArea"> 날짜 &emsp;|&emsp; ${myb.bo_day}</span>
	 </div>
	<hr> 
	 <div id="QnA_Area_cont">${myb.bo_content}</div>
	<hr>
	<c:choose>
	<c:when test="${myb.bo_img!='N'}">
	<div id="QnA_Area_file">첨부파일 &emsp;|&emsp;
	<a href="imgdownlod?bo_img=${myb.bo_img}">&#128190; ${myb.bo_img}</a>
	</div>
 		<hr>
 	</c:when>
 	</c:choose>
 </div>	
 
 <div id="QnA_Area_mg">
		<c:forEach items="${reply}" var="reply">
				<div>
				<fmt:parseDate value="${reply.re_day}" var="rday" pattern="yyyy-MM-dd HH:mm:ss"/>
					<div >
						<span id="QnA_spanArea"><b>관리자 답변</b> &emsp;|&emsp; <fmt:formatDate value="${rday}" pattern="yy.MM.dd"/>
						</span>
					</div>
					<div id="QnA_Area_cont">${reply.re_content}</div>
				</div>	
				<hr>

		</c:forEach>
  </div>
 	  <button type="button" onclick="location.href='member_MyQnA_Out'">목록으로</button>
</div>
</body>
</html>


