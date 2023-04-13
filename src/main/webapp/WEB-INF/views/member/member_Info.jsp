<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
<div class="outer">
	<div id="memberinputArea"> 
		<form id="memberinput" action="member_Modify1" method="post">
			<h1>My Info</h1>
			<br><br>								
			<div class="membertitle">아이디</div>
			<span class="input_area">
			<input type="text" value="${list.user_id}" readonly></span>			
			<br><br>
			
			<div class="membertitle">닉네임</div>		
			<span class="input_area">
			<input type="text" value="${list.user_nic}" readonly></span>
			<br><br>
										
			<div class="membertitle">생년월일</div>
			<span class="input_area_birth">				 		
				<fmt:parseDate value="${list.user_birth}" var="birth" pattern="yyyy-MM-dd HH:mm:ss"/>
 				<fmt:formatDate value="${birth}" pattern="yyyy년 MM월 dd일" /> 				
 			</span>		
			 <br><br>
				
			<div class="membertitle">성별</div>
			 <span class="input_area">
			  <input type="text" value="${list.sb}" readonly></span>
			   <br><br>
				
			<div class="membertitle">주소</div>
			 <span class="input_area">
			 <input type="text" value="${list.user_address}" readonly></span>
			 
			<div class="btnArea">
	 			<input type="submit" value="수정하기">
			</div>
			
		 </form>
	</div>
  </div>
</div>  
</body>
</html>