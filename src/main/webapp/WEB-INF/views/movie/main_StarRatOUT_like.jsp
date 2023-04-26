<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.*, org.json.simple.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title>평점(추천순)</title>
      <style type="text/css">
         /*팝업창*/
      #popup {
         display: none;
         position: fixed;
         top: 50%;
         left: 50%;
         width: 300px;
         height: 120px;
         transform: translate(-50%, -50%);
         background-color: #fff;
         border: 1px solid #ccc;
         padding: 20px;
         box-shadow: 2px 2px 5px rgba(0,0,0,0.3);
         z-index: 9999;
      }
      /*하나의 평점 div 기준 css*/
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
      .star-rating span {
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
      
      div.mainB_Area{
         display: flex;
         flex-direction: column;
         align-items: stretch;
         width: 100%;
      }div.starRating_Board{
         width: 100%;
         display: flex;
         flex-wrap: wrap;
         justify-content: flex-start;
         padding: 10px;
         flex-direction: row;
         align-content: stretch;
         align-items: baseline;
      }div.starBox{
         width: 45%;
         display: flex;
         flex-direction: column;
         margin: 10px;
         padding: 10px;
      }div.starRating_paging{
         display: flex;
         flex-direction: row;
         margin: 2px;
         padding: 2px;
         width: 100%;
         align-items: center;
      }div.sb_TextArea{
         display: flex;
         flex-direction: row;
         justify-content: flex-start;
         align-items: center;
         margin: 3px;
      }div.sb_TextArea span{
         font-family: monospace;
         font-size: 1em;
         color:#DADEDF;
         text-shadow: 0.2px 0.2px 1px #65625D;
         font-weight: 500;
         margin: 1px 5px 5px 1px;
      }div.sb_TextArea span#spannic{
         font-size: 1.2em;
         font-weight: 800;
         font-family: fantasy;
         color: #9EA4A5;
         text-shadow: 0.1px 0.1px 0.5px #65625D;
         margin-right: 10px;
      }div.sb_TextArea span.recommendation-button{
         color: #FC1965;
         font-family: fantasy;
         font-size: 0.8em;
      }div.sb_contentArea{
         display: flex;
         flex-direction: column;
         justify-content: flex-start;
         margin: 1px;
         font-size: 1em;
         font-weight: 800;
         color: #65625D;
      }span.starrating-star{
         color: #FFD500;
         text-shadow: 1px 1px 1px #241E02;
         font-size: 1.8em;
         margin-bottom: 10px;
      }span.starrating-cntnt{
         color: #65625D;
         margin: 3px 1px 20px 1px;
      }div.starRating_paging p{
         color: #9EA4A5;
         font-size: 1.6em;
         margin: 8px;
         padding: 8px;
      }
      </style>
   </head>
<!-- memStarSave -->
   <body>
      <div class="mainB_Area"><!-- body -->
         <div class="starRating_Board"><!-- 별점 댓글창 범위 -->
            <c:forEach items="${star}" var="s">
               <div class="starBox">
                  <div class="sb_TextArea">
                     <input type="hidden" name="mr_num" class="starRating_numbercode" value="${s.mr_num}"><!-- 번호 -->
                     <input type="hidden" name="mr_id" class="mr_id" id="mr_id" value="${s.mr_id}"><!-- 번호 -->
                     <span id="spannic">${s.user_nic}</span><!-- 닉네임 -->
                     <span>${s.mr_day}</span><!-- 날짜 -->
                     <span class="recommendation-button" id="joayo"  onclick="joayo('${s.mr_num}','${s.mr_like}')"style="cursor:pointer;">　&#128077; ${s.mr_like}</span><!-- 추천버튼 -->
                     <div id="popup">
                        <h3>이미 추천하셨습니다.</h3>
                        <button onclick="closePopup()">확인</button>
                     </div>
                  </div><!-- 닉네임, 날짜, 추천 -->
                  <div class="sb_contentArea">
                     <span class="starrating-star">${s.star}</span>
                     <span class="starrating-cntnt">${s.mr_content}</span>
                  </div><!-- 댓글내용 -->
               </div><!-- 댓글1개 -->
            </c:forEach><!-- 별점 게시판 -->
         </div><!-- 별점 댓글창 범위 -->
         <div class="starRating_paging">
            <p style="cursor:pointer;" id="ejurnPage" onclick="sendData('ejurnPage')">🢔&emsp;</p>
            <p style="cursor:pointer;" id="ehouPage" onclick="sendData('ehouPage')">&emsp;🢖</p>
            
         </div><!-- 평점게시판 페이징-->
      </div><!-- body -->
   </body>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script type="text/javascript">
   
   var id=$("#mr_id").val();
   var login_id= "${login_id}";
   var birthday=$("#mgDir_day").val();
   var dir_check={"a":name,"b":birthday};
   var dir_check=JSON.stringify(dir_check);
   if (login_id == id) {
      $("#spannic").css("color", "#EE6939");
   }
            var type="new";
            
            function joayo(mr_num,mr_like) {
               var scode=mr_num;
               var joAyo=mr_like;
               console.log("나!!"+scode+"클릭됐어!");
               window.parent.postMessage({ scode: scode,joAyo: joAyo }, window.location.origin);
            }//좋아요 클릭시 불려갈 준비 완료!
      
            function closePopup() {
               document.getElementById("popup").style.display = "none";
            }//좋아오 이미 눌렀습니다 확인 창

         var now = ${pg.pageNow};
         console.log(now);
         var pic = 4;
         var type="new";
         
         function sendData(id) {
            if (id === 'ejurnPage') {//이전페이지
               now=now-1;
               if(now<1){
                  now=1;
                  alert("첫 페이지입니다");
               }
            } else if (id === 'ehouPage') {//이후페이지
               now=now+1;
               $.ajax({
                  url: "starPaging",
                  method: "POST",
                  data: { now:now,x:type },
                  success: function(data) {
                     var lastPage = parseInt(data, 10);
                     if(now>lastPage){
                        now=now-1;
                        console.log("잘받았니?"+now);
                        alert('마지막 페이지 입니다');
                     }//최대페이지 넘지 마
                   },
                     error: function(jqXHR, textStatus, errorThrown) {
                         console.log("AJAX Error:", textStatus, errorThrown);
                       }
               });//ajax;
            }//이후페이지
            console.log("부모창에 데이터 보내자");
            // 현재 창으로 객체 2개 전달
            console.log("now="+now+"//type=?"+type);
            window.parent.postMessage({ now: now, type: type }, window.location.origin);
         }//onclick 함수
      </script>
</html>