<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
<div id="QnA_w"> 

<h3>Q & A</h3><br><br>

<form id="QnAinput" action="member_MyQnA_Save" method="post" enctype="multipart/form-data">
	<table align="center" border="1" width="700">
		<tr>
			<th width="30%" height="30">제목</th>
			
			<td><select  name="bo_type">
			      <option value="문의">문의하기</option>
			      <option value="영화추천">영화추천</option>
			      <option value="오류신고">오류신고</option>
			      <option value="기타">기타</option>
			    </select>
			    <input type="text" name="bo_title" size="30">		    
			    </td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="bo_content" cols="80" rows="20"></textarea></td>
		</tr>
		<tr>
			<th height="30">첨부파일</th>
			<td align="left">
				<input type="file" name="bo_img" id="bo_img" />					
 			</td>
		</tr>
	</table>
	<br>	<button type="button" onclick="location.href='member_MyQnA_Out'">목록으로</button>
	 		<input type="submit" id="submit" value="저장">
</form>
</div>
</div>
</body>
</html>