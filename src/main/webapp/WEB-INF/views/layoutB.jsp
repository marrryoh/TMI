<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE html>
<html>
   <head>
      <style type="text/css">
         #searchTop {
            text-align: center;
            position:static;
            display:flex;
            width: 100%;
         }
         #wrap 
   		 {
   		 	min-height: calc(100vh - 140px);
  			position: relative;
		 }
         #body {
            text-align: center;
            width: 100%;
            height: 100%
            z-index:10;
            display: flex;
 			flex-direction: column;
         }
         th,td{text-align: center;}
         caption{text-align: center;}
         
         .outer{
            width:60%;
            min-width : 650px;
            background: rgb(248, 249, 250);
            box-shadow: rgba(0, 0, 0, 0.06) 0px 0px 4px 0px;
            margin:auto;
			margin-top: 10px;
			display: flex;
			justify-content: center;
    		align-items: center;
         }
         /*회원창*/         
         .membertitle{
            text-align: center;
            padding : 10px 10px 14px 10px;
         }
         #memberinput{
            width : 400px;
            margin: auto;
            padding: 10px;
         }
         #memberinput h1{text-align:center;}
         div.id-span-area{
            display: flex;
            width : 270px;
            height: 45px;
            border: solid 1px #dadada;
            padding : 10px 10px 14px 10px;
            background : white;
            margin-left: 55px;
         }
         .input_area {
            border: solid 1px #dadada;
            padding : 10px 10px 14px 10px;
            background : white;
         }
         .my_area {
            text-align: center;
            padding : 10px 10px 14px 10px;
         }
         .radio_area {
            border: solid 1px #dadada;
            padding : 10px 10px 14px 10px;
            vertical-align: middle;
            background : white;
         }
         [type="radio"] {
            flex: row;
            vertical-align: middle;
         }
         .input_area input:not([type=checkbox]) {
            width : 250px;
            height : 30px;
            border: 0px;
         }
         .input_1_area input:not([type=checkbox]) {
            width : 170px;
            height : 30px;
            border: 0px;
         }
         span.input_1_area{
            border: solid 1px #dadada;
            padding : 10px 10px 14px 10px;
            background : white;
         }
         .btnArea {
            text-align:center;
            padding : 50px;
         }
         div.mebertt_1 button{
            width : 70px;
            height : 35px;
            border : 0px;
            color:white;
            background:#282A35;
            margin : 3px;
         }
         button {
            width : 100px;
            height : 35px;
            border : 0px;
            color:white;
            background:#282A35;
            margin : 5px;
         }
         span.input_area_birth
         {
         	display: inline-block;
         	width : 250px;
            height : 20px;
            border: 0px;
            border: solid 1px #dadada;
            padding : 10px 10px 14px 10px;
            background : white;
            font-size: 15px;
            text-align: left;
         }
         
         /*헤더*/
         header.mainPage_header{
         	width: 100%;
         }
         nav.navbar {
            display: flex;
            align-items: center;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            padding: 10px;
            width: 100%;
         }
         div.mainNav_Area{
            display: flex;
            flex-wrap: wrap-reverse;
            justify-content: space-between;
            width: 100%;
         }
         div.navHead {
            display: flex;
            align-items: center;
            padding-right: 2px;
            margin-left: 15px;
            margin-right: 10px;
         }
         div.leftNav{
            display: flex;
            flex-direction: row;
         }
         div.rightNav{
            display: flex;
            flex-direction: row-reverse;
         }
         div.navHead a.navHome {
            font-size: 1.5em;
            font-weight: bold;
            color: #8D8E8E;
            text-decoration: none;
         }
         ul.navDropdown {
            display: flex;
            align-items: center;
            list-style: none;
            margin: 0;
            padding: 0;
         }
         ul.navDropdown li {
            position: relative;
            margin-right: 20px;
         }
         ul.navDropdown li a {
            font-size: 15px;
            color: #8D8E8E;
            text-decoration: none;
         }
         ul.navDropdown li.active a {
            color: #fff;
            background-color: #333;
         }
         .navbar .navDropdown li .dd_Menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            min-width: 150px;
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            padding: 8px;
         }
         ul.navDropdown li .dd_Menu li {
            margin: 0;
            padding: 0;
            list-style: none;
         }
         .navbar .navDropdown li .dd_Menu li a {
            display: block;
            font-size: 15px;
            color: #666B6E;
            text-decoration: none;
            padding: 4px;
         }
         .navbar .navDropdown li .dd_Menu li a:hover {
            color: #fff;
            background-color: #333;
         }
         .navbar .rightNav {
            display: flex;
            align-items: center;
         }
         .navbar .navDropdown li .dd_toggleArea .dd_Button {
            display: inline-block;
            margin-left: 5px;
            width: 0;
            height: 0;
            border-top: 5px solid #328DAE;
            border-right: 5px solid transparent;
            border-left: 5px solid transparent;
            vertical-align: top;
            border-radius: 5px; 
         }
         /*전체 토글*/
         ul.navDropdownALl {
            display: flex;
            align-items: center;
            list-style: none;
            margin: 0;
            padding: 0;
         }
         /*ul 시작 첫*/
         li.ddALl {
            position: relative;
            flex-direction: row;
         }
         /*메뉴버튼 li */
         div.menuAll_div {
            position: absolute;
            display: none;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: space-between;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
         }
         div.menuAll_div.active {
            display: flex;
         }/*active일 때를 위한 경우의 수*/
         li.ddALl ul.dd_Menu_all {
            min-width: 150px;
            background-color: #fff;
            border-bottom:1px solid #ccc;
            border-top:1px solid #ccc;
            padding: 5px;
            list-style: none;
         }
         ul.navDropdown li .dd_Menu_all li {
            flex: 1;
            padding: 5px;
            list-style: none;
            flex-direction: column;
         }
         ul.navDropdown li:hover .dd_Menu_all {
            display: block;
            position: absolute;
            top: 100%;
            left: 0;
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: flex-start;
            align-items: flex-start;
         }
         .dd_Menu_all li a {
            display: block;
            font-size: 15px;
            color: #666B6E;
            text-decoration: none;
            padding: 4px;
         }
         .dd_Menu_all li a:hover {
            color: #fff;
            background-color: #333;
         }
         .dd_Menu_all li span.menu_li {
            display: block;
            font-size: 15px;
            color: #666B6E;
            text-decoration: none;
            padding: 4px;
         }
         .dd_Menu_all li span.menu_li:hover {
            color: #fff;
            background-color: #333;
         }
         ul.navDropdownALl li a, span.menu_li {
            font-size: 15px;
            color: #8D8E8E;
            text-decoration: none;
         }
         ul.navDropdownALl li.active a {
            color: #fff;
            background-color: #333;
         }         
         /*검색창*/
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
            flex-direction: row;
            justify-content: space-around;
         }
         div.header_searchBar span.search_span input#header_search_input{
            min-width: 80%;
            width : 450px;
            height : 100px;
            max-width: 80%;
            height: 30px;
            border: 0px;
         }
         span.search_span{
            padding : 10px 10px 10px 20px;
            border: solid 1px #CCD4D7;
            border-radius: 20px;
         }
       
     /* 메인 검색 출력*/ 
     
     div.mainBody
     {
     	margin-left: 300px;
     	margin-right:300px;
     	margin-top: 50px;
     	display: flex;
     	flex-wrap: wrap;
     	width: 1200px;
  	  	min-width: 500px;
     }
     div.mainBodyTop   
     {
      display: flex;
      text-align: left;
      margin: 10px;
  	  padding: 10px;
  	  color: #887674;
  	  font-size: 20px;
  	  font-weight:700;  	      
     }
     div.searchOut_area
     {
     	display: flex;
     	flex-direction: row;
     	width: 1200px;
  	  	min-width: 500px;
     }
        
     div.searchimg_outline
     {
 	    margin: 10px;
  	  	padding: 10px;
     }    
     
     div.searchimg
     {
     	height: 100%;
     	display: flex;
    	align-items: center;
     }    
 	
 	div.search_outline
 	{
 		margin: 10px;
  	  	padding: 10px;
  	  	width: 900px;
  	  	min-width: 500px;
 	}
    div.searchtitle_outline
    {	
    	padding-top: 5px;
    	text-align: left;
    	
    	height: 60px;
    	display: flex;
    	align-items: center;
    	font-weight: bold;	
    }
    span.search_title
    {
    font-size: 32px;
    }
    div.search_All{
    	display: flex;
  	  	justify-content: center;
  	  	flex-direction: column;
  	  	height: 200px;  	
    } 
    div.search_info
    {
    	text-align: left;
    	font-size: 16px;
    	color: #320D0B;
    	font-weight:600;
    }
    div.search_keyword
    {
    	text-align: left;
    	color: #8B4F1D;
    	font-size: 20px;
    	font-weight: bold;
    }    
    a
    {
     text-decoration-line: none;
     color: #5F3016;
    }     
    div.mainBody_bottom
    { 
      margin: 5px;
      margin-left: 15px;
  	  padding: 5px;
  	  text-align: left;
  	  font-size: 16px;
  	  color: #320D0B;
  	  font-weight:500; 
  	}
  	
  	/* 게시판 출력 */
  	table, td, th 
  	{
  	border-collapse : collapse;
	};
	
	/* 푸터 */
	footer{
		position: absolute;
  		left: 0;
  		right: 0;
  		height: 60px;
  		display: flex;
  		transform : translateY(-100%);
	}
	div.footerAll 
	{
		display: flex;
		align-items: center;
		flex-direction: row;
  		bottom: 0;
  		width: 100%;
  		height: 60px;
  		line-height: 60px;
  		font-size: 15px;
  		color: #8D8E8E;
  		background-color: #fff;
 		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
 		padding: 0;
	}
	
	.footer_lono 
	{
	  margin-left: 20px;
	  display: flex;
	  flex-direction: row;
	  left: 10px;
	  align-items: center;
	}
	.footer_Logo
	{
	  display: flex;
	  align-items: center;
	}
	.footer_adminLogo 
	{
 	 margin-right: 20px;
 	 right: 10px;
 	 position: absolute;
	}
	.footerAll a
	{
	 align-items: center;
 	 display: flex;
	}
	.footer_notice
	{
		margin-left: 40px;
	}
	.footer_copy 
	{
	 position: absolute;
	 width:60%;
	 left: 40%;
	}
	
	/* 게시판 */
	.board
	{
	flex-grow: 1;
  	display: flex;
  	justify-content: center;
  	align-items: center;
  	margin-top: 10px;
	}
	/*서브밋 버튼*/
	#submit 
	{
	width : 100px;
	height : 35px;
	color:white;
	background:#282A35;
	margin : 5px;
	border: 2px solid black;
 	}
 	
 	/* 서치 탑*/
 	span.searchbar_span input#header_searchbar_input
 	{
       min-width: 180px;
       width : 550px;
       height : 200px;
       max-width: 80%;
       height: 30px;
       border: 0px;
    }
         
	span.searchbar_span
	{
       padding : 10px 10px 10px 20px;
       border: solid 1px #CCD4D7;
       border-radius: 20px;
    }
    #header_search_submit
    {
    width : 100px;
	height : 38px;
	color:white;
	background:#282A35;
	margin : 5px;
	border: 2px solid black;
	border-radius: 10px;
    }
    #header_searchbar_area
    {
    margin-left: 30px;
    }
    
    /*게시판*/
    .QnAouter
    {
     width:60%;
     min-width : 650px;
     margin:auto;
     margin-top : 80px;
     margin-bottom : 130px;
    }
    #QnA_Area_top
    {
    	margin-bottom: 60px;
    }
    #QnA_Area
    {
    	margin: 10px;
    	padding: 5px;    	
    }
    #QnA_spanArea
    {
   		display: flex;
        width : 270px;
        height: 30px;
        padding : 5px 5px 5px 5px;
    }
    
    #QnA_Area_cont
    {
    	width : 900px;
        height: 200px;
        display: flex;
        align-items: center;
		margin-left: 10px;
    }
    #QnA_Area_file
    {
    	display: flex;
        align-items: center;
        margin: 10px;
        justify-content: center;
        height: 60px;
        background: rgb(248, 249, 250);
    }
    #QnA_Area_mg
    {
    	margin: 50px 5px 30px 5px;
    	padding: 5px; 
    }
	/*QnA 입력*/
	#QnA_w
	{
	margin: 20px;
	}
	#submit {
	width : 100px;
	height : 35px;
	border : 0px;
	color:white;
	background:#282A35;
	margin : 5px;
	}
	
	
	
      </style>
      <meta charset="UTF-8">
      <title><t:insertAttribute name="title"/></title>
   </head>
   <body>
      <div id="container">
      	<div id="searchTop">
            <t:insertAttribute name="top"/>
         </div>      	
         <div id="body">
            <t:insertAttribute name="body"/>
         </div>
         <div id="footer">
            <t:insertAttribute name="footer"/>
         </div>
      </div>
   </body>
</html>