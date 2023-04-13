<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript">
		window.onload = function() {
			$(function(){
				$("#mgDic_Chck").click(function(){
					var f=document.din_form;
					var code=$("#mgDir_code").val();
					var name=$("#mgDir_name").val();
					var birthday=$("#mgDir_day").val();
					
					if(name == ""){
						alert("'이름' 입력란이 공백입니다");
						f.mgDir_name.select();
						return false;
					}
					if(birthday == ""){
						alert("'생년월일' 입력란이 공백입니다");
						f.mgDir_day.select();
						return false;
					}
					
					var dir_check={"a":name,"b":birthday,"c":code};
					var dir_check=JSON.stringify(dir_check);
					
					
					$.ajax({
						type:"post",
						async:true,
						url:"mgDic_Chck",
						data:{dirChck:dir_check}, //servlet에서 request로 받을 이름
						success:function(fixDir){   
							if(fixDir=="0"){
								alert("등록 가능합니다.");
								$("#nn").attr("value","0");
							}else if(fixDir==1){
								var dirResult = confirm("[중복]입력하신  '"+name+"'의 동명이인(생일)이 있습니다. \n  새 추가 하시겠습니까?");
								if(dirResult){
				                    $("#nn").attr("value","0");
								}
								else {
				                    $("#nn").attr("value","1");
									}//no 클릭 시	
							}else if(fixDir==2){
								var dirResult = confirm("' "+name+" '의 동명이인(생일) 감독이 2명 이상입니다. \n 새 추가 하시겠습니까?");
								if(dirResult){
									$("#nn").attr("value","0");
								}
								else 
									$("#mgDirector").val('');
				                    $("#nn").attr("value","1");
									return;
								}
							}else if(fixDir=="ME"){
								var dirResult = confirm("' 이름 '이 변경되지 않았습니다. \n 그대로 등록하시겠습니까?");
								if(dirResult){
									$("#nn").attr("value","0");
								}
								else {
				                    $("#nn").attr("value","1");
									return;
								}
							}
						},//성공 시,
						error:function(fixDir){
							alert("[오류] 전송에 실패하였습니다. 코딩을 확인해주세요")
						}//실패시
					});//ajax
				});//감독 중복검사
				
				$("#mgDir_submit").click(function(){
					var result = $("#nn").val();
					if(result !== "0"){
						alert("영화 중복 확인을 먼저 해주세요.");
						return false;
					}
					else{
						var f=document.din_form;
						var name=$("#mgDir_name").val();
						var day=$("#mgDir_day").val();
						var debut=$("#mgDir_debut").val();
						var pic=$("#mgDir_pic").val();
						
						if(name == ""){
							alert("'이름' 입력란이 공백입니다");
							f.mgDir_name.select();
							return false;
						}
						if(day == ""){
							alert("'생년월일' 입력란이 공백입니다");
							f.mgDir_day.select();
							return false;
						}
						if(debut == ""){
							alert("'데뷔작' 입력란이 공백입니다");
							f.mgPoster.select();
							return false;
						}
						if(pic==""){
							alert("'이미지' 가 등록되지 않았습니다");
							f.mgDir_pic.select();
							return false;
						}
						f.submit();
					}
				});//감독수정
			});//함수 끝
		}
		</script>
	</head>
	<body>
		<div class="mainBody_area">
			<div class="mg_movInpt_form_area">
				<form action="MgDirUpdate" method="post" name="din_form" enctype="multipart/form-data">
					<table class="mvInput_table" align="center">
						<caption>감독등록</caption>
						<tr>
							<th>이　름 *</th>
							<td><input type="text" name="mgDir_name" id="mgDir_name" value="${modi.dir_name}"></td>
							<th>생년월일 *</th>
							<td><input type="date" name="mgDir_day" id="mgDir_day" value="${modi.dir_day}"></td>
							<td>
								<input type="button" value="확인" id="mgDic_Chck" name="mgDic_Chck">
							</td>
						</tr>
						<tr>
							<th>소　속 </th>
							<td><input type="text" name="mgDir_aff" id="mgDir_aff" value="${modi.dir_aff}"></td>
							<th>데뷔작 *</th>
							<td colspan="2">
								<input type="text" name="mgDir_debut" id="mgDir_debut" value="${modi.dir_debut}">
								<input type="hidden" name="mgDir_code" id="mgDir_code" value="${modi.dir_code}">
							</td>
						</tr>
						<tr>
							<th>포스터 *</th>
							<td colspan="3"><input type="file" name="mgDir_pic" id="mgDir_pic" value="${modi.dir_pic}"></td>
							<td><img src="imgsave/dirImg/${modi.dir_pic}" height="80"></td>
						</tr>
						
						<tr>
							<th>정　보</th>
							<td colspan="4"><textarea rows="6" cols="60" name="mgDir_info" id="mgDir_info">${modi.dir_info}</textarea></td>
						</tr>
						<tr>
							<td class="button_td" colspan="5">
								<input type="reset" value="리셋">
								<input type="hidden" id="nn">
								<input type="button" value="수정" id="mgDir_submit">
								<a href="movieDir_Del?a=${modi.dir_code}"><input type="button" value="삭제"></a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>