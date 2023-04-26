<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title>평점 남기기</title>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,minimum-scale=1.0, user-scalable=no">
      <style type="text/css">
      div.StarBody_area{
      }
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
      }*{padding: 0; margin: 0;}
      #pop_container{
         font-family: 'NotoSans','맑은 고딕', 'Malgun Gothic',"돋움", dotum, arial, sans-serif;
         text-align: center;
         position: relative;
      }.popup_top {
         position: relative;
         display: flex;
         justify-content: space-between;
         padding: 0.5rem 1.4rem;
         background-color: #fdd000;
         vertical-align: middle;
      }span.popup_tit {
         font-size: 20px;
         color:#ffffff;
      }div.starBox_right{
         line-height: 1.8em;
         display: flex;
         flex-direction: column;
         max-width:500px; 
      }textarea#starText{
         margin: 1.5em 1.8em;
         font-size: 1.1em;
         font-weight: 200;
      }div.star-rating-buttonArea {
         position: absolute;
         bottom: 0;
         width: 100%;
         background-color: #dddddd;
         padding: 0.5rem 0 0.7rem;
         display: flex;
         justify-content: center;
      }div.countbox{
         display: flex;
         justify-content: space-around;
      }
      div.restB_area, div.saveB_area{
         margin: 20px;
         padding-left: 10px;
         padding-right: 10px;
      }
      button#resetButton,button#saveButton{
         width: 30px;
         height: 20px;
      }div.star-rating-starArea{
         margin: 15px;
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
         });//글자수 카운팅 함수
         
         $("#saveButton").on("click", function() {
            const $selectStar = $("input[name='rating']:checked");
            const $starText = $("#starText");
            const fStar = $selectStar.val();
            const text = $starText.val();
            if (fStar === undefined) {
               alert("'별점'을 선택해주세요");
               return false;
            }
            if (text === "") {
               alert("'내용'이 공백입니다");
               $starText.select();
               return false;
            }
            $.ajax({
               type: "POST",
               url: "memStarSave",
               data: {
                  rating: fStar,
                  starText: text,
                  mvCode: $("#mvCode").val()
               }, success: function(response) {
                  alert("평점이 등록되었습니다. \n 비슷한 영화를 보려면 추천영화를 이용해주세요!");
                  window.close();
               }, error: function(xhr, status, error) {
                  console.error("별점 등록 실패:ajax와 이클립스 확인", error);
                  alert("별점 등록에 실패했습니다. \n 오류가 계속 발생하면 관리자에게 문의해주세요");
                }
            });//ajax
            // form의 기본 동작인 submit을 막기.
            return false;
         });//서브밋 역할하는 ajax :세이브버튼
      }//윈도우 리셋
      </script>
   </head>
<!-- memStarSave -->
   <body>
      <div class="StarBody_area">
         <header class="popup_top">
            <span class="popup_tit">' ${mvName} '평가하기</span>
         </header>
         <div class="star-rating_Area">
            <form action="memStarSave" id="star_form" method="post">
               <div class="starBox_left">
                  <input type="hidden" id="mvCode" value="${mvCode}"><!-- 영화코드 -->
                  <input type="hidden"><!-- 작성자 아이디 --> <!-- 없어도 됨 -->
                  <input type="hidden"><!--  -->
               </div>
               <hr>
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
                     <textarea rows="15" cols="60" id="starText" name="starText" placeholder="댓글 입력"></textarea>
                     <div class="countbox">
                        <input type="text" placeholder="0/500" id="byteCheck" readonly="readonly">
                     </div>
                     <br>
                     <hr>
                  </div><!-- 댓글 입력줄 -->
                  <div class="star-rating-buttonArea">
                     <div class="restB_area">
                        <input type="button" id="resetButton" value="취소">
                     </div>
                     <div class="saveB_area">
                        <input type="button" id="saveButton" value="등록">
                     </div>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </body>
</html>