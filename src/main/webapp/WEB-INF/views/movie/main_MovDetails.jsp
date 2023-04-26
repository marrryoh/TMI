<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,minimum-scale=1.0, user-scalable=no">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script type="text/javascript">
      $(document).ready(function() {
           $('.dd_toggleArea').click(function() {
             var dropdownMenu = $(this).next('.dd_Menu');// 클릭한 토글 버튼의 드롭다운 메뉴 찾기
             $('.dd_Menu').not(dropdownMenu).hide();//다른 드롭다운 메뉴 닫기
             dropdownMenu.toggle();//드롭다운 토글
           });

           $('.dd_Menu').mouseleave(function() {
             $(this).hide();
           });//마우스 나가면 숨기기

           $('.navDropdown > li').not('.dd').click(function() {
             $('.dd_Menu').hide();
           });//이전 거 메뉴 닫기
         });//nav 토글 함수
         
        const menuAllDiv = document.querySelector('.menuAll_div');
        const ddALl = document.querySelector('.ddALl');

        ddALl.addEventListener('click', function() {
          if (menuAllDiv.classList.contains('active')) {
            menuAllDiv.classList.remove('active');
          } else {
            menuAllDiv.classList.add('active');
          }
        });

        menuAllDiv.addEventListener('mouseleave', function() {
          if (menuAllDiv.classList.contains('active')) {
            menuAllDiv.classList.remove('active');
          }
        });
      
      
      
      
         window.onload = function(){
            var now=1;
            $('c\\:when[test=new]').addClass('active');
            $('#includedContent').load('main_StarRatOUT_new.jsp');
            //기본적으로 최신순 평점보기로 새로고침된다.
            
            $(document).ready(function() {
               // 최신순 버튼 클릭 시
               $(".starRating_New").click(function() {
                  sendRequest("new");
               });
               // 추천순 버튼 클릭 시
               $(".starRating_like").click(function() {
                  sendRequest("like");
               });
              
               // 초기 로딩 시 최신순 버튼 클릭한 것과 동일한 효과를 내기 위해
               $(".starRating_New").trigger("click");
            });
            // Ajax 요청 보내는 함수
            function sendRequest(type) {
               $.ajax({
                  url: "main_StarRatOUT",
                  data: { now:now, check: type },
                  type: "POST",
                  success: function(response) {
                      $("#starRatings").html(response);
                  },error: function(response) {
                     console.log(response);
                  }
               });
            }//평점게시판 ajax
            
            window.addEventListener("message", receiveMessage, false);
            //데이터를 받자! 자식 페이지에게서 받자!
            function receiveMessage(event) {
               var data = event.data;
               console.log("scode"+data.scode);
               console.log("likeSu"+data.joAyo);
               console.log("now"+data.now);
               var scode= data.scode;
               var scode= parseInt(scode, 10);
               console.log(scode+"없으면 좀 제발 눌리지 좀 마라");
               if (!Number.isInteger(scode)) {
                  if (data.now && data.type) {
                     var now = data.now;
                     var type = data.type;
                     receiveClickEvent(now, type);
                     console.log("설마 여기도 오고 저기도 가니?");
                  }
               }else if(scode >0) {
                  var scode = data.scode;//댓글고유번호
                  var likeSu = data.joAyo;//좋아요수
                  console.log(scode+"제대로 받음");
                  receiveClickEvent(scode,likeSu);
               }
               
               
            }
            function receiveClickEvent(scode,likeSu) {
               console.log("좋아요!");
               console.log(likeSu);
               if(scode>0){
                  $.ajax({
                     type: "POST",
                     url: "star_checkLogin",
                     success: function(a) {
                        if (a === "success") {
                           $.ajax({
                              type: "POST",
                              url: "star_recommendation",
                              async:true,
                              dataType:"text",
                              data:{"aa":scode}, //aa라는 String 객체로 codenumber를 던질거야.
                              success: function(result) {
                                    if (result === "OK") {//추천 성공
                                       var targetElement = document.getElementById("joayo");
                                          targetElement.innerHTML = "&#128077;" + likeSu;
                                    } else { //추천 실패 : 이미 추천한 경우
                                       document.getElementById("popup").style.display = "block";
                                    }
                                 }, error: function(xhr, status, error) {
                                    alert("추천실패 오류났음. 확인 하자.");
                                 }
                              });//ajax
                        } else {
                           if(confirm("로그인 후 이용 가능합니다. 로그인 창으로 이동하시겠습니까?")){
                              window.location.href = "member_Login";
                           } else {
                              location.reload();
                           }
                        }//성공 함수 내부의 첫 if문의 else 닫힘   
                     }, error: function(xhr, status, error) {//로그인 여부 파악 ajax 에러부문
                        alert("[ERR404Jc]추천에 실패했습니다. \n오류가 계속될 경우 관리자에게 문의해주세요. ");
                        console.log("좋아요 코딩에 오류가 발생했습니다. 좋아요 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                        //ERR404jc 이 오류표시는 좋아요를 처리하는 과정에서 발생하는 오류로, 좋아요 리스폰바디 메소드를 확인하거나 이클립스 콘솔을 확인.
                     }
                  });//ajax;
               }//시작 if문
            }//좋아요 누르기
            
            function receiveClickEvent(now,type) {
               console.log("왜와 자꾸??"+now);
               console.log("이거 문자라고"+type);
               if(!isNaN(parseInt(type))){
                  var scode=now;
                  $.ajax({
                     type: "POST",
                     url: "star_checkLogin",
                     success: function(a) {
                        if (a === "success") {
                           $.ajax({
                              type: "POST",
                              url: "star_recommendation",
                              async:true,
                              dataType:"text",
                              data:{"aa":scode}, //aa라는 String 객체로 codenumber를 던질거야.
                              success: function(result) {
                                    if (result === "OK") {//추천 성공
                                       var targetElement = document.getElementById("joayo");
                                    } else { //추천 실패 : 이미 추천한 경우
                                       document.getElementById("popup").style.display = "block";
                                    }
                                 }, error: function(xhr, status, error) {
                                    alert("추천실패 오류났음. 확인 하자.");
                                 }
                              });//ajax
                        } else {
                           if(confirm("로그인 후 이용 가능합니다. 로그인 창으로 이동하시겠습니까?")){
                              window.location.href = "member_Login";
                           } else {
                              location.reload();
                           }
                        }//성공 함수 내부의 첫 if문의 else 닫힘   
                     }, error: function(xhr, status, error) {//로그인 여부 파악 ajax 에러부문
                        alert("[ERR404Jc]추천에 실패했습니다. \n오류가 계속될 경우 관리자에게 문의해주세요. ");
                        console.log("좋아요 코딩에 오류가 발생했습니다. 좋아요 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                        //ERR404jc 이 오류표시는 좋아요를 처리하는 과정에서 발생하는 오류로, 좋아요 리스폰바디 메소드를 확인하거나 이클립스 콘솔을 확인.
                     }
                  });//ajax;
               }else{
                  $.ajax({
                     url: "main_StarRatOUT",
                     data: { now:now, check: type },
                     type: "POST",
                     success: function(response) {
                         $("#starRatings").html(response);
                     },error: function(response) {
                        console.log(response);
                        alert("서버 오류가 발생했습니다. \n오류가 계속될 경우 관리자에게 문의하세요");
                     }
                  });
               }//시작 if문
            }//평점게시판 페이징 
            
            $(document).ready(function() {
               //찜하기 버튼 누른 후에 발동하는 코딩이 아래 있어.
               $('.mvJimm').click(function() {
                  $.ajax({
                     type: "POST",
                     url: "star_checkLogin", //로그인 여부 확인하기 위한 ajax로, mvcntroller로 연결
                     success: function(a) {
                        if (a == "success") {
                           console.log('찜 시작');
                           var mvCode = "${mvDTO.movie_code}";
                           $.ajax({
                              type: "POST",
                              url: "mvJimm", // 찜여부 확인
                              async:true,
                              dataType:"text",
                              data:{"aa":mvCode},
                              success: function(jjim) { //찜 여부에 따른 찜하기/찜취소하기 기능 중 하나 진행
                                 if (jjim == "yes") {
                                    console.log('자,어디까지가능한지 체크해보자');
                                    if(confirm("찜했습니다. \n 찜목록 보러 가시겠습니까?")){
                                       window.location.href = "member_Jimm";//찜목록 출력 페이지(아이디 기준)
                                    } else {
                                       location.reload();
                                    }
                                 } else if(jjim == "no") {
                                    if(confirm("이 영화는 이미 찜한 영화입니다. \n 찜목록에서 제거하시겠습니까?")){
                                       $.ajax({
                                          type: "POST",
                                          url: "mvJimm_Delete",//찜 취소 메소드
                                          async:true,
                                          dataType:"text",
                                          data:{"aa":mvCode},
                                          success: function(bye) {
                                             if (jjim == "yes") {
                                                alert("찜목록에서 삭제하였습니다.");
                                                location.reload();
                                             }
                                          }, error: function(xhr, status, error) {
                                             alert("[ERR404Jjim]찜하기 취소에 실패했습니다. \n 오류가 계속될 경우 관리자에게 문의해주세요. ");
                                             console.log("찜 취소 ajax에서 오류 발생. 찜 취소 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                                             //ERR404Jjim 이 오류표시는 찜을 처리하는 과정에서 발생하는 오류로, 찜 취소 리스폰바디 메소드를 확인하거나 이클립스 콘솔을 확인.
                                          }
                                       });//ajax
                                    }//찜 안된 경우에 질문
                                 }else{   location.reload();}//찜여부 체크에서 yes나 no가 아닌 경우
                              }, error: function(xhr, status, error) {
                                 alert("[ERR404Jjim]찜하기에 실패했습니다. \n 오류가 계속될 경우 관리자에게 문의해주세요. ");
                                 console.log("찜하는 코딩에 오류가 발생했습니다. 찜 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                                 //ERR404Jjim 이 오류표시는 찜을 처리하는 과정에서 발생하는 오류로, 찜 리스폰바디 메소드를 확인하거나 이클립스 콘솔을 확인.
                              }
                           });//ajax
                        } else {//엘스
                           if(confirm("로그인 후 이용 가능합니다. 로그인 창으로 이동하시겠습니까?")){
                              window.location.href = "member_Login";
                           } else {
                              location.reload();
                           }
                        }
                     }, error: function(xhr, status, error) {
                        alert("[ERR404CheckID]알 수 없는 오류가 발생했습니다. \n 오류가 계속될 경우 관리자에게 문의해주세요. ");
                        console.log("로그인아이디를체크하는 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                        //ERR404CheckID 이 오류표시는 로그인 여부 확인하는 리스폰바디 에이젝스 코딩에서 메소드로 넘어간 후에 발생하는 오류
                     }//엘스
                  });//로그인 ajax
               });//찜하기
               
               //평점남기기
               $('.starRating_span').click(function() {
                  $.ajax({
                     type: "POST",
                     url: "star_checkLogin",
                     success: function(a) {
                        if (a === "success") {
                           var mvCode = "${mvDTO.movie_code}";
                           $.ajax({
                              type: "POST",
                              url: "star_checkAgain",
                              data:{"cd":mvCode},
                              success: function(a) {
                                 if (a === "success") {
                                    var mvCode = "${mvDTO.movie_code}";
                                    window.open("member_StarRating?a="+mvCode, "StarRating", 
         "top=140, left=300, width=500, height=650, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');");//윈도우오픈
                                 } else {
                                    document.getElementById("starRating_pop").style.display = "block";
                                 }//별점 중복 체크 성공 함수 내부의 if문의 else 닫힘
                              }, error: function(xhr, status, error) {//로그인 여부 파악 ajax 에러부문
                                 alert("[ERR404Star]평점 등록에 실패했습니다. \n 오류가 계속될 경우 관리자에게 문의해주세요. ");
                                 console.log("평점 여부 체크에서 ajax에서 오류 발생. 평점 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                              }
                           });//중복 별점 체크 ajax
                        } else {
                           if(confirm("로그인 후 이용 가능합니다. 로그인 창으로 이동하시겠습니까?")){
                              window.location.href = "member_Login";
                           } else {
                              location.reload();
                           }
                        }//성공 함수 내부의 첫 if문의 else 닫힘
                        
                        
                     }, error: function(xhr, status, error) {//로그인 여부 파악 ajax 에러부문
                        alert("[ERR404Jjim]찜하기에 실패했습니다. \n오류가 계속될 경우 관리자에게 문의해주세요. ");
                        console.log("찜하는 코딩에 오류가 발생했습니다. 찜 리스폰바디 메소드를 서블릿 자바 클래스에서 확인하세요.");
                        //ERR404Jjim 이 오류표시는 찜을 처리하는 과정에서 발생하는 오류로, 찜 리스폰바디 메소드를 확인하거나 이클립스 콘솔을 확인.
                     }
                  });//ajax
               });//별점입력 버튼 클릭 함수: 평점남기기
            });//도큐먼트 레디 함수

            
            
            document.addEventListener("DOMContentLoaded", () => {
               const outsideDiv = document.querySelector(".MvF_contentOutside");
               const leftButton = document.querySelector(".left-button");
               const rightButton = document.querySelector(".right-button");
               leftButton.addEventListener("click", () => {
                  outsideDiv.scrollBy({
                     left: -300, behavior: "smooth",
                  });
               });
               rightButton.addEventListener("click", () => {
                  outsideDiv.scrollBy({
                     left: 300, behavior: "smooth",
                  });
               });  
            });//횡스크롤 용 버튼 함수
            //예고편 자동재생용
            const video = document.getElementById("myVideo");

            // 페이지 스크롤 이벤트 처리
            window.addEventListener("scroll", () => {
              const videoRect = video.getBoundingClientRect();
              const videoBottom = videoRect.top + videoRect.height;
              const windowHeight = window.innerHeight;

              // 화면에서 bottom 40% 지점에 도달하면 자동으로 재생
              if (videoBottom - windowHeight * 0.4 <= windowHeight) {
                video.play();
              }
            });
            
            // 마우스 오버 이벤트 처리
            video.addEventListener("mouseover", () => {
               video.play();
            });
            function handleMouseOver() {video.controls = true;}// 비디오 컨트롤러 표시
            function handleMouseOut() {video.controls = false;}// 비디오 컨트롤러 숨기기
            // 비디오 요소에 마우스 오버/아웃 이벤트 핸들러 등록
            video.addEventListener("mouseover", handleMouseOver);
            video.addEventListener("mouseout", handleMouseOut);

            
            //우측 네비게이션만들기
         /*   $(window).scroll(
               function(){
                  //스크롤의 위치가 상단에서 450보다 크면  
               }
                       if($(window).scrollTop() > 450){ 
                           $('엘리먼트').addClass("fix");  
                           //위의 if문에 대한 조건 만족시 fix라는 class를 부여함  
                       }else{  
                           $('엘리먼트').removeClass("fix");  
                           //위의 if문에 대한 조건 아닌경우 fix라는 class를 삭제함  
                       }  
                   }  
               );  */
               var $nav = $('.nav_include');
               var $fdiv = $('.MvDetail_foot');
               $(window).on('scroll', function(){
                 var $window = $(window), anchor = $window.scrollTop() + $window.height();
                 var ff = $fdiv.offset().top;
                 if (anchor > ff) $nav.removeClass('fixed');
                 else $nav.addClass('fixed');
               });
         }//윈도우
      </script>

   </head>

   <body>
     <div class="mainBody_area" style="background-image: url('imgsave/movieImg/${mvDTO.movie_poster}');background-size: cover; background-repeat: no-repeat;width:100vw; min-width: 360px;">
         <div class="MvDetail_head">
            <div class="MvDetail_text">
               <div class="MvDetail_txtTitle">
                  <h1 class="MvDtxt_tit" id="movieName">${mvDTO.movie_name}</h1><!-- 영화제목 -->                  
                  <c:choose>
                     <c:when test="${nowNew== true }">
                     
                        <p class="MvDtxt_new">&#127910;</p><!-- 상영중 -->
                     </c:when>
                     <c:otherwise/>
                  </c:choose><!-- 상영여부 -->
                  <c:choose>
                     <c:when test="${like == 0 }"/>
                     <c:when test="${like == 1}">
                        <p class="MvDtxt_like">&#128159;</p><!-- 찜여부 -->
                     </c:when>
                  </c:choose>
               </div><!-- 영화제목란 -->
               <ul>
                  <li class="mvDetail_txtInfo"><a href="#" style="color: white;">${mvDTO.movie_director}</a></li><!-- 감독 -->
                  <li class="mvDetail_txtInfo">${mvDTO.movie_actor}</li><!-- 배우 -->
               </ul><!-- 헤더:감독/배우 -->
            </div><!-- 헤더:제목 -->
         </div><!-- 헤더:공간 -->
         <div class="MvDetail_body" style="background-color: white;">
            <div class="EmptyArea"></div>
            <div class="Mvbody_contentArea">
               <div class="mvDetail_ulArea">
                  <ul class="mvDetail_ul">
                     <li>국가　
                        <span class="mv_txt">${mvDTO.movie_state}</span>　
                     </li>
                     <li>　│　개봉일　 
                        <span class="mv_txt">${mvDTO.movie_day}</span>　
                     </li>
                     <li>　│　러닝타임　
                        <span class="mv_txt">${mvDTO.movie_rtime}분</span>　
                     </li><!-- 찜하기 | CGV 예매하기 -->
                     <li>　│　<span class="mvJimm" style="cursor: pointer; color: #B7357F;font-family: monospace;font-size: 1.2em;   font-weight: 800;">찜하기</span></li>
                     <li>　│　<a class="reserveA" href="${mvDTO.movie_reserve}">CGV예매하기</a></li>
                  </ul><!-- 바디:정보1 -->
                  <ul class="mvDetail_ul">
                     <li><span class="mv_txt">${mvDTO.movie_jenre}</span></li>
                     <li>　│　<span class="mv_txt">${mvDTO.movie_keyword}</span></li>
                  </ul><!-- 바디:장르/키워드 -->
                  <hr>
               </div><!-- 바디: ul/li 구역 -->
               <div class="mvDetail_Mvtxt">
                  ${mvDTO.movie_plot}
               </div><!-- 줄거리 -->
               <div class="mvDetail_YOUTUBE">
                  <c:choose>
                     <c:when test="${empty mvDTO.movie_link}"></c:when>
                     <c:when test="${mvDTO.movie_link.endsWith('.mp4')}">
                        <video src="${mvDTO.movie_link}" id="myVideo" autoplay controls></video>
                     </c:when>
                     <c:otherwise>
                        <iframe src="${mvDTO.movie_link}" id="myiframe" width="720px;" height="405px;"></iframe>
                     </c:otherwise>
                  </c:choose>
               </div><!-- 유튜브 -->
               <div class="board_header"><!-- 윗면 -->
                  <span class="starRating_span">평점남기기</span>
                  <div id="starRating_pop">
                     <h3>이미 평점을 남기셨습니다</h3>
                     <button onclick="closePop()">확인</button>
                  </div>
                  <button class="starRating_New">최신순<!-- 최신순 --></button>
                  <button class="starRating_like">추천순<!-- 최신순 --></button>
                  <button class="starRating_ME">내평점<!-- 내평점 --></button>
               </div><!-- 댓글창 위 버튼 -->
               <div class="starRatings" id="starRatings">   </div><!-- 평점창 인클루드 -->
            </div><!-- 바디:영역 //컨텐츠영역 -->
        
         </div><!-- 바디:공간 -->
         <div class="MvDetail_foot">
            <div class="MvFooter_head">
               <h2>추천영화</h2>
               <div class="MvF_buttonArea">
                  <a href="mainSearchsave?svalue="><span class="starRating_span">전체영화</span></a>
                  <button class="leftB"><span class="CCbutton">🢔</span></button>
                  <button class="rightB"><span class="CCbutton">🢖</span></button>
               </div><!-- 좌우버튼 -->
            </div><!-- 하단 영화추천 말머리 -->
            <div class="MvF_contentOutside">
               <c:forEach items="${chuchen}" var="cc">
               <div class="MvF_contentArea">
                  <div class="MvfC_poster">
                     <a href="main_MovDetails?a=${cc.movie_code}">
                        <img alt="추천영화" src="imgsave/movieImg/${cc.movie_poster}" width="100%" height="auto">
                     </a>
                  </div>
                  <div class="MvfC_text">
                     <a href="main_MovDetails?a=${cc.movie_code}">
                        <span id="ccMovieName">${cc.movie_name}</span>
                        <span class="ccJenre">${cc.movie_jenre}</span>
                     </a>
                  </div><!-- 텍스트 영역 -->
               </div><!-- 추천영화1개당 범위 -->
               </c:forEach><!-- 추천영화 출력 -->
            </div><!-- 추천영화 컨텐츠 범위 -->         
         </div><!-- 푸터:공간 -->
      </div><!-- body -->
   </body>
   <head>
   </head>
   <script type="text/javascript">
    function closePop() {
         document.getElementById("starRating_pop").style.display = "none";
      }//이미 평점을 납기셨습니다 확인 창
      document.addEventListener("DOMContentLoaded", () => {
         const outsideDiv = document.querySelector(".MvF_contentOutside");
         const leftButton = document.querySelector(".leftB");
         const rightButton = document.querySelector(".rightB");
         leftButton.addEventListener("click", () => {
            console.log("좌");
            outsideDiv.scrollBy({
               left: -300, behavior: "smooth",
            });
         });
         rightButton.addEventListener("click", () => {
            console.log("우");
            outsideDiv.scrollBy({
               left: 300, behavior: "smooth",
            });
         });  
      });//횡스크롤 용 버튼 함수
   </script>

</html>