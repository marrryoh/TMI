<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<style type="text/css">
		.star-rating {
			display: flex;
			flex-direction: row-reverse;
			font-size: 2.25rem;
			line-height: 2.5rem;
			justify-content: space-around;
			padding: 0 0.2em;
			text-align: center;
			width: 5em;
		}
		.star-rating input {
			display: none;
		}
		.star-rating label {
			-webkit-text-fill-color: transparent;
			-webkit-text-stroke-width: 2.3px;
			-webkit-text-stroke-color: #2b2a29;
			cursor: pointer;
		}
		.star-rating :checked ~ label {
			-webkit-text-fill-color: gold;
		}
		.star-rating label:hover, .star-rating label:hover ~ label {
			-webkit-text-fill-color: #fff58c;
		}
		</style>
		<script type="text/javascript">
		window.onload = function() {
			$("#starText").keyup(function(e) {
				var content = $(this).val();
				var mxl= 500;
				$("#byteCheck").val( (mxl - (content.length)) + " 자"); //실시간 글자수 카운팅
				if (content.length > mxl) {
					content = content.slice(0, mxl);
				    alert("최대 500자까지 입력 가능합니다.");
				    $(this).val(content.substring(0, 500));
					$('#byteCheck').html("0자");
				}
				if(content.length >489){
					$("#byteCheck").css("color", "red");
				}else{
					$("#byteCheck").css("color", "skyblue");
				}
			});
			}
			$(function(){
				$("#resetButton").click(function(){
					var f=document.star_form;
					const div = document.getElementById('star-rating_Area');
					div.hidden();
					f.reset();
				});//리셋버튼
				
				$("#saveButton").click(function(){
					var f=document.star_form;
					var fStar=$("#1-star").val();
					var text=$("#starText").val();
						if(fStar == ""){
							alert("'별점' 을 입력해주세요");
							f.rating.select();
							return false;
						}
						if(text == ""){
							alert("'내용' 이 공백입니다");
							f.starText.select();
							return false;
						}
						f.submit();
				});//영화등록
			});//함수 끝
		</script>
	</head>
<!-- memStarSave -->
	<body>
		<div class="mainBody_area">
			<div class="star-rating_Area">
				<form action="memStarSave" id="star_form" method="post">
					<div class="starBox_left">
						별점 박스 좌측 위치
					</div>
					<div class="starBox_right">
						<div class="star-rating-starArea">
							<div class="star-rating space-x-4 mx-auto">
								<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
								<label for="5-stars" class="star pr-4">★</label>
								<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
								<label for="4-stars" class="star">★</label>
								<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
								<label for="3-stars" class="star">★</label>
								<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
								<label for="2-stars" class="star">★</label>
								<input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
								<label for="1-star" class="star">★</label>
							</div>
						</div><!-- 평점 줄 -->
						<div class="star-rating-inputArea">
							<textarea rows="8" cols="50" id="starText" name="starText" placeholder="댓글 입력"></textarea>
							<div class="글자수세기">
								<input type="text" placeholder="0/500" id="byteCheck" readonly="readonly">
							</div>
							<hr>
						</div><!-- 댓글 입력줄 -->
						<div class="star-rating-buttonArea">
							<input type="button" id="resetButton" value="취소">
							<input type="button" id="saveButton" value="등록">
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>