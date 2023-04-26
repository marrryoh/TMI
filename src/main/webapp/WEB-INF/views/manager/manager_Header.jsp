<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title></title>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script type="text/javascript">
         function adminLogout() {
            $('body').fadeOut(1000);
            if(confirm("관리자모드를 종료합니다")){
               sessionStorage.clear();
               setTimeout(function(){location.href='manager_Logout'},1000);
            }else {
               location.href='manager_Mainpage';
               }//no 클릭 시   
            
           }//로그아웃 함수 끝
           
           //상단바 토글 함수
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
      </script>
      <style type="text/css">
       *{
          box-sizing: border-box;
       }
      </style>
   </head>
   <header class="managerPage_header">
      <nav class="navbar">
         <div class="mgNav_Area">
            <div class="leftNav">
               <div class="navHead">
                  <a class="navHome" href="home">HOME</a>
               </div><!-- 홈키 -->
               <ul class="navDropdown">
                  <li class="non_dd">
                     <a href="manager_Mainpage" style="font-weight: bold;">관리자홈</a>
                  </li>
                  <li class="dd"><a class="dd_toggleArea" data-toggle="dd" href="#">영화관리<span class="dd_Button"></span></a><!-- 메뉴상단바 -->
                     <ul class="dd_Menu">
                        <li><a href="movie_Input">영화등록</a></li>
                        <li><a href="movie_Output">영화관리</a></li>
                        <li><a href="movieDir_Input">감독등록</a></li>
                        <li><a href="movieDir_Output">감독관리</a></li>
                     </ul><!-- 메뉴 하단 메뉴 -->
                  </li><!-- 토글 li -->
                  <li class="dd"><a class="dd_toggleArea" data-toggle="dd" href="#">회원관리<span class="dd_Button"></span></a><!-- 메뉴상단바 -->
                     <ul class="dd_Menu">
                        <li><a href="member_Output">회원 정보 보기</a></li>
       				    <li><a href="manager_QnA_Out">게시판 관리</a></li>
                     </ul><!-- 메뉴 하단 메뉴 -->
                  </li><!-- 토글 li -->
                 
               </ul><!-- 드롭다운 기능 ul -->
            </div><!-- 좌측 영역 -->
            <div class="rightNav">
               <ul class="navDropdown">
                  <c:choose>
                     <c:when test="${administrator_only==true}">
                        <li class="non_dd">
                           <a href="#" style="font-size: 13px;" onclick="adminLogout()">
                              <span class="glyphicon glyphicon-log-in"></span>
                              <span class="glyphicon glyphicon-user" style="color:#59A1BC;"></span>
                               관리자모드 종료
                           </a>
                        </li>                  
                     </c:when>
                  </c:choose>
               </ul>
            </div><!-- 우측 영역 -->
         </div><!-- 네비바 전체 영역 -->
      </nav>
   </header>      
</html>