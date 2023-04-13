<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
	
		<title></title>
		<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
	<style type="text/css">
         div.mainBody_area{
            width: 100%;
            align-self: center;
         }
         div.header_searchBar{
            margin-left: 30px;
            margin-right: 30px;
            display: flex;
            align-items: center;
            flex-wrap: nowrap;
            max-width: 1200px;
            flex-direction: column;
    		justify-content: flex-start;
    		padding-top: 25px;
         }
         div.header_searchBar span.search_span input#header_search_input{
            min-width: 180px;
            width : 550px;
            height : 200px;
            max-width: 80%;
            height: 30px;
            border: 0px;
         }
         span.search_span{
            padding : 10px 10px 10px 20px;
            border: solid 1px #CCD4D7;
            border-radius: 20px;
         }
         div.tmiLogo{
            width: 100%;
            max-width: 2000px;
            min-width:360px;
            height: 20%;
            min-height: 200px;
            display: flex;
            justify-content: center;
            margin: 0;
         }
         div.header_logo_area{
            width: 100%;
         }
         div.tmiLogo img{
            max-width: 600px;
            min-width: 360px;
            width: 100%;
            height: auto;
            min-height: 240px;
            max-height: 400px;
         }
         form#mainSearchbar{
            size=
         }
         
         .searchAll
         {
          display: flex;
  		  justify-content: center;
         }
         .search_keyword_All
         {
          margin-top: 30px;
         }
      </style>
   </head>
   <body>
   <div id="wrap">
      <div class="mainBody_area">
        <div class="header_area">
            <div class="header_logo_area">
               <div class="tmiLogo">
                  <img alt="mainImg_TMI" src="imgsave/logoImg/mainImg.gif">
               </div>
            </div>
            
          <div class="searchAll">  
            <div class="header_searchBar" style="min-height: 80px;">
               <form id="mainSearchbar" name="mainSearchbar_form" action="mainSearchsave">
                  <span class="search_span">
                     <input type="text" name="svalue" placeholder="검색어를 입력하세요" id="header_search_input">
                  </span>
                  <input type="submit" id="submit" value="&#128269;">
               </form>
               <div class="search_keyword_All">      
                  <span class="search_keyword">
                  	<a href="mainSearchsave?svalue=액션" class="">액션</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=SF" class="">SF</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=판타지" class="">판타지</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=드라마" class="">드라마</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=코미디" class="">코미디</a>
                  </span>
                  <br>
                  <span class="search_keyword">
                  	<a href="mainSearchsave?svalue=애니" class="">애니</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=로맨스" class="">로맨스</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=음악" class="">음악</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=무성영화" class="">무성영화</a>
                  </span>
                  <br>
                  <span class="search_keyword">
                  	<a href="mainSearchsave?svalue=리마스터" class="">리마스터</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=공포" class="">공포</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=스릴러" class="">스릴러</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=마블" class="">마블</a> &emsp;|&emsp;
                  	<a href="mainSearchsave?svalue=디즈니" class="">디즈니</a>
                  </span>
               </div> 
            </div>
         </div>   
        </div>
      </div>
    </div>  
   </body>
</html>