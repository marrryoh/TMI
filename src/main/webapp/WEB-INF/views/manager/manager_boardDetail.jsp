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
<div class="QnAouter">
   <div id="QnA_Area">
	 
	 <div id="QnA_Area_top"><h2>Q n A 관리</h2></div>
	 	<div id="QnA_Area_title">
	 		<span id="QnA_spanArea">작성자 &emsp;|&emsp; <b>${myb.bo_id}</b> </span>
		  <div id="QnA_Area_tt">
			<span id="QnA_spanArea_ty">${myb.bo_type} &emsp;|&emsp; ${myb.bo_title}</span>
			<span id="QnA_spanArea_da">${myb.bo_day}</span>
		  </div>	
		</div>
 	<hr>
		<div id="QnA_Area_cont">${myb.bo_content}</div>
	<hr>
	<c:choose>
	<c:when test="${myb.bo_img!='N'}">
	<div id="QnA_Area_file">첨부파일 &emsp;|&emsp;<a href="imgdownlod?bo_img=${myb.bo_img}">&#128190; ${myb.bo_img}</a>
	</div>
	<hr>
 	</c:when>
 	</c:choose>
 	
 	</div>	
  <div id="QnA_Area_mg">
 	  <div id="QnA_Area_top"><h3>R e p l y</h3></div>
		<c:forEach items="${reply}" var="reply">
				<div>
				<fmt:parseDate value="${reply.re_day}" var="rday" pattern="yyyy-MM-dd HH:mm:ss"/>
					<span id="QnA_spanArea"><b>관리자</b> &emsp;|&emsp; <fmt:formatDate value="${rday}" pattern="yy.MM.dd"/>
					</span>
					<div id="QnA_Re_cont">${reply.re_content}</div>
				</div>
				<hr>	
		</c:forEach>
		
	<div id="QnA_area_All">		 	
 		<form id="QnAreply" action="replysave">
	 		<div id="QnA_area">
	 			<div id="QnA_Area_Re"><h3>답변 남기기</h3></div>
	 		 	<textarea rows="5" cols="120" name="re_content"></textarea>
	 		<input type="hidden" name="bo_num" value="${myb.bo_num}">		
 			<input type="submit" value="저장" id="submit">
  			<button type="button" onclick="location.href='manager_QnA_Out'">목록으로</button>
 			</div>
 		</form>
 	</div>	  
  </div> 
</div>
</div>
</body>
</html>