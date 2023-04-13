<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript">
		window.onload = function() {
			$(function(){
				$("#mgDic_Check").click(function(){
					var f=document.din_form;
					
					var name=$("#mgDir_name").val();
					var birthday=$("#mgDir_day").val();
					var dir_check={"a":name,"b":birthday};
					var dir_check=JSON.stringify(dir_check);
					
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
					$.ajax({
						type:"post",
						async:true,
						url:"MgDirCheck",
						data:{dirChck:dir_check}, //servlet에서 request로 받을 이름
						success:function(fixDir){   
							if(fixDir=="0"){
								alert("등록 가능합니다.");
								$("#nn").attr("value","0");
							}else if(fixDir==1){
								var dirResult = confirm("[중복]입력하신  '"+name+"'은(는) 이미 등록된 감독 이름입니다. \n  다른 감독으로 추가 하시겠습니까?");
								if(dirResult){
				                    $("#nn").attr("value","0");
								}
								else {
									$("#mgMovie").val('');
									$("#mgPoster").val('');
									$("#mgDirector").val('');
				                    $("#nn").attr("value","1");
									}//no 클릭 시	
							}else if(fixDir==2){
								var dirResult = confirm("' "+name+" '(으)로 등록된 감독이 2명 이상입니다. \n 정말 등록하시겠습니까?");
								if(dirResult){
									$("#nn").attr("value","0");
								}
								else {
									mov='';
									return;
								}
							}
						},//성공 시,
						error:function(fixDir){
							alert("[오류] 전송에 실패하였습니다. 코딩을 확인해주세요")
						}//실패시
					});//ajax
				});//영화 중복검사
				
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
				});//영화등록
			});//함수 끝
		}
		</script>
	</head>
	<body>
		<div class="mainBody_area">
			<div class="mg_movInpt_form_area">
				<form action="MgDirSave" method="post" name="din_form" enctype="multipart/form-data">
					<table class="mvInput_table" align="center">
						<caption>감독등록</caption>
						<tr>
							<th>이　름 *</th>
							<td><input type="text" name="mgDir_name" id="mgDir_name"></td>
							<th>생년월일 *</th>
							<td><input type="date" name="mgDir_day" id="mgDir_day"></td>
							<td>
								<input type="button" value="확인" id="mgDic_Check" name="mgDic_Check">
							</td>
						</tr>
						<tr>
							<th>소　속 </th>
							<td><input type="text" name="mgDir_aff" id="mgDir_aff"></td>
							<th>데뷔작 *</th>
							<td colspan="2"><input type="text" name="mgDir_debut" id="mgDir_debut"></td>
						</tr>
						<tr>
							<th>포스터 *</th>
							<td colspan="4"><input type="file" name="mgDir_pic" id="mgDir_pic"></td>
						</tr>
						
						<tr>
							<th>정　보</th>
							<td colspan="4"><textarea rows="6" cols="60" name="mgDir_info" id="mgDir_info"></textarea></td>
						</tr>
						<tr>
							<td class="button_td" colspan="5">
								<input type="reset" value="리셋">
								<input type="hidden" id="nn">
								<input type="button" value="등록" id="mgDir_submit">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>