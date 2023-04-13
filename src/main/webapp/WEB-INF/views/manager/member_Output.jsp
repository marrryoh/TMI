<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	function delchk(user_id){
			console.log("a");
			console.log(user_id);
			if(confirm("이 회원 정보를 삭제 하겠습니까?"))
			{
				$.ajax({
					type:"post",
					async:true,
					dataType:"text",
					url:"mg_Delete",
					data:{"user_id":user_id}				
				});//ajax
				alert("회원정보 삭제가 완료 되었습니다");
				location.href="member_Output";																						
			}//if문
	}//종료
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
<div class="board">
<div class="board_top"><h3>회원 정보 현황</h3></div>
<table border="1" align="center" width="900">
<tr height="40">
	<th>회원번호</th> <th>아이디</th> <th>비밀번호</th>
	<th>닉네임</th> <th>생년월일</th> <th>성별</th>
	<th>주소</th> <th>비고</th>
</tr>
<c:forEach items="${list}" var="my">
<tr height="30">
		<td>${my.user_num}</td>
		<td>${my.user_id}</td>
		<td>${my.user_pw}</td> <td>${my.user_nic}</td>		
		<fmt:parseDate value="${my.user_birth}" var="user_birth" pattern="yyyy-MM-dd HH:mm:ss"/>
		<td><fmt:formatDate value="${user_birth}" pattern="yyyy년 MM월 dd일"/> </td>
		<td>${my.sb}</td>
		<td>${my.user_address}</td> 
		<td><input type="button" id="delchk" class="delbtn" onclick="delchk('${my.user_id}')" value="회원삭제"></td>		
</tr>
</c:forEach>
<!-- 페이징처리 666666  -->
<tr style="border-left: none;border-right: none;border-bottom: none">
	<td colspan="8" style="text-align: center;" height="30">
	
	 <c:if test="${paging.startPage!=1 }">
      <a href="member_Output?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a>
   </c:if>
   
      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
         <c:choose>
            <c:when test="${p == paging.nowPage }">
               <b><span style="color: red;font-family: bold">${p}</span></b>
            </c:when>   
            <c:when test="${p != paging.nowPage }">
               <a href="member_Output?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
            </c:when>   
         </c:choose>
      </c:forEach>
      
      <c:if test="${paging.endPage != paging.lastPage}">
      <a href="member_Output?nowPage=${pageing.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
   </c:if>
   </td>
</tr>
</table>
</div>
</div>
</body>
</html>