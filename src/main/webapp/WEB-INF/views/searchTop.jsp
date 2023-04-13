<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script type="text/javascript">
      window.onload = function() {
         function logout() {
            $('body').fadeOut(1000);
            if(confirm("로그아웃하시겠습니까?")){
               sessionStorage.clear();
               setTimeout(function(){location.href='manager_Logout'},1000);
            }else {
               return;
               }//no 클릭 시   
           }//로그아웃 함수 끝

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
      }; //윈도우~!
      </script>
      <c:set var="result" value="${param.result}"/>
      <c:set var="result2" value="${param.result2}"/>
      <c:choose>
         <c:when test="${result=='loginfail' }">
            <script type="text/javascript">
               alert("로그인 후 사용하세요 :P");
            </script>
         </c:when>
         <c:when test="${result2=='loginfail' }">
            <script type="text/javascript">
               alert("아이디 또는 비밀번호를 확인하세요");
            </script>
         </c:when>
      </c:choose>
   </head>
   <header class="mainPage_header">
      <nav class="navbar">
         <div class="mainNav_Area">
            <div class="leftNav">
               <div class="navHead">
                  <a class="navHome" href="home">HOME</a>
               </div><!-- 홈키 -->
               <div class="blank_Area_searchTop"></div>
               <ul class="navDropdownALl">
                  <li class="ddALl"><a class="dd_toggleArea" data-toggle="ddALl" href="#"></a><!-- 메뉴상단바 -->
                     <div class="menuAll_div">
                        <ul class="dd_Menu_all">
                           <li><span class="menu_li">국가</span></li>
                           <li><span class="menu_li">장르</span></li>
                           <li><span class="menu_li">　　</span></li>
                           <li><span class="menu_li">　　</span></li>
                           <li><span class="menu_li">　　</span></li>
                        </ul><!-- 첫 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">한국영화</a></li>
                           <li><a href="#">액션</a></li>
                           <li><a href="#">스릴러</a></li>   
                           <li><a href="#">뮤지컬</a></li>
                           <li><a href="#">흑백</a></li>
                        </ul><!-- 둘째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">아시아</a></li>
                           <li><a href="#">로맨스</a></li>
                           <li><a href="#">드라마</a></li>   
                           <li><a href="#">미스터리</a></li>
                           <li><a href="#">무성</a></li>
                        </ul><!-- 셋째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">유럽</a></li>
                           <li><a href="#">다큐</a></li>
                           <li><a href="#">가족</a></li>   
                           <li><a href="#">어드밴처</a></li>
                           <li><a href="#">리메이크</a></li>
                        </ul><!-- 넷째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">아메리카</a></li>
                           <li><a href="#">애니메이션</a></li>
                           <li><a href="#">판타지</a></li>   
                           <li><a href="#">스포츠</a></li>
                           <li><a href="#">리마스터</a></li>
                        </ul><!-- 닷째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">중동</a></li>
                           <li><a href="#">SF</a></li>
                           <li><a href="#">역사</a></li>   
                           <li><a href="#">로맨스코미디</a></li>
                           <li><a href="#">전체보기</a></li>
                        </ul><!-- 엿째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">아프리카</a></li>
                           <li><a href="#">코미디</a></li>
                           <li><a href="#">재난</a></li>   
                           <li><a href="#">전쟁</a></li>
                           <li><span class="menu_li"></span></li>
                        </ul><!-- 일곱째 하단 메뉴 -->
                        <ul class="dd_Menu_all">
                           <li><a href="#">오세아니아</a></li>
                           <li><a href="#">공포</a></li>
                           <li><a href="#">범죄</a></li>   
                           <li><a href="#">종교</a></li>
                           <li><span class="menu_li"></span></li>
                        </ul><!-- 마지막 하단 메뉴 -->
                     </div>
                  </li><!-- 토글 li -->
                  <li class="non_dd">
                     <div class="header_search_area">
                        <div class="header_searchbar_area">
                           <form id="header_searchbar" name="header_searchbar_form" action="mainSearchsave">
                              <span class="searchbar_span">
                                 <input type="text" name="svalue" placeholder="검색어를 입력하세요" id="header_searchbar_input">
                              </span>
                              <input type="submit" id="header_search_submit" value="&#128269;">
                           </form>
                        </div><!-- 검색바 -->
                     </div><!-- 헤더 서치 에리어 -->
                  </li><!-- 토글 li -->
               </ul><!-- 드롭다운 기능 ul -->
            </div><!-- 좌측 영역 -->
            <div class="rightNav">
               <ul class="navDropdown">
                  <c:choose>
                     <c:when test="${memberloginOrNot==true}">
                        <li class="dd"><a class="dd_toggleArea" data-toggle="dd" href="#">&#127775;</a><!-- 메뉴상단바 -->
                           <ul class="dd_Menu">
                              <li><a href="member_Info">환영합니다! ${member.user_nic}님</a></li>
                              <li><a href="#">찜목록</a></li>
                              <li><a href="member_MyQnA">문의</a></li>
                              <li><a href="member_MyQnA_Out">내 게시판</a></li> 
                              <li>
                                 <a href="logout" onclick="logout()">
                                    <span class="glyphicon glyphicon-log-in" style="color:#59A1BC;"></span>
                                 로그아웃</a>
                              </li>
                           </ul><!-- 메뉴 하단 메뉴 -->
                        </li><!-- 토글 li -->   
                        <li></li>         
                     </c:when>
                     <c:otherwise>
                        <li class="non_dd">
                           <a href="member_Login">로그인</a>
                        </li>
                        <li class="non_dd">
                           <a href="member_Input">회원가입</a>
                        </li>
                     </c:otherwise>
                  </c:choose>
               </ul>
            </div><!-- 우측 영역 -->
         </div><!-- 네비바 전체 영역 -->
      </nav>
   </header>
</html>