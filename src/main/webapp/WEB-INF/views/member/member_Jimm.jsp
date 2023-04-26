<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@  taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <style type="text/css">
         div.mvJim{
            display: flex;
            flex-direction:column;
            margin: 10px;
            padding: 10px;
         }div.mvJimHead{
            overflow: hidden;
         }div.mvJimBody{
            display: flex;
            flex-wrap: wrap;
            flex-direction: row;
            align-items: center;
         }div.myMovie{
            display: flex;
            flex-direction: column;
            margin: 10px;
            padding: 5px;
         }div.jimPoster{
            padding-bottom: 5px;
         }div.jimText{
            margin: 10px;
            display: flex;
            flex-direction: column;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
         }div.jimText span{
            display: block;
            font-family: fantasy;
            font-size: 1em;
            color:#65625D;
         }div.jimText span.jimMvjenre{
            font-size: 0.88em;
            margin-top: 10px;
            margin-bottom: 20px;
         }
      </style>
   </head>
   <body>
    <div id="wrap">  
      <div class="mainBody_area">
         <div class="mvJim">
            <div class="mvJimHead">
               <h2>찜목록</h2>
               <hr>
            </div>
            <div class="mvJimBody">
               <c:forEach items="${jim}" var="my">
                  <div class="myMovie">
                     <div class="jimPoster">
                        <a href="main_MovDetails?a=${my.like_code}">
                           <img id="a" src="imgsave/movieImg/${my.movie_poster}" width="350">
                        </a>
                     </div><!-- 포스터영역 -->
                     <div class="jimText">
                        <span class="jimMvtit">
                           <a href="main_MovDetails?a=${my.like_code}">${my.movie_name}</a>
                        </span><!-- 제목 -->
                        <span class="jimMvjenre">${my.movie_jenre}</span><!-- 장르 -->
                     </div><!-- 텍스트영역 -->
                  </div><!-- 반복될 div -->
               </c:forEach>
            </div>
         </div><!-- 찜영역 -->
      </div>
    </div>  
   </body>
</html>