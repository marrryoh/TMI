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
            text-align: center;
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
            z-index: 15;
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
            margin-left: 10px;
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
     text-align: center;
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
        width : 350px;
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
	text-align: center;
	}
	#submit {
	width : 100px;
	height : 35px;
	border : 0px;
	color:white;
	background:#282A35;
	margin : 5px;
	}

         /*별점버튼 외각 박스 삭제 혹은 수정*/
         span.starRating_span{
            border: #555555 solid 1px;
            border-radius: 40px;
            color: #000000;
            padding: 18px 28px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 600;
         }span.btn_popup:hover{
            border: #fdd000 solid 2px;
            background-color: #fdd000;
            border-radius: 40px;
            color: #000000;
            padding: 18px 28px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 600;
         }
         
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
         #starRating_pop {
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
         
         
         /*헤드라인 : MvDetail_headLine*/
         div.MvDetail_head{/* 디테일 페이지 영화제목란 전체 공간*/
            height: 95vh;
            display: flex;
            position: static;
            flex-direction: column;
            justify-content: flex-end;
         }div.MvDetail_text{/*제목, 상영중, 감독 등, 영화제목란 중 하단 부분 텍스트 영역*/
            width: 100%;
            position: absolute;
            display: flex;
            flex-direction: column;
            margin: 10px;
         }div.MvDetail_txtTitle{/*제목 라인 영역*/
            width: 100%;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            border-style: none;
            align-items: center;
            padding: 10px;
         }h1.MvDtxt_tit{/*제목*/
            max-width: 100%;
            color: white;
            font-size: 400%;
            font-weight: 800;
            white-space : nowrap;
            text-overflow: clip;
            margin-left: 5px;
            margin-right: 20px;
            text-shadow: 2px 2px 4px #30260F;/*제목그림자*/
         }p.MvDtxt_new{/*상영중*/
            margin: 7px;
            font-size: 1.4em;
         }p.MvDtxt_like{/*찜*/
            margin: 7px;
            font-size: 1.6em;
         }li.mvDetail_txtInfo{/*바디:헤더 텍스트 영역 - 감독, 배우*/
            list-style-type: none;
            font-size: 1.4em;
            color: white;
            padding: 3px;
            margin: 2px;
            text-shadow: 1px 1px 3px #7C5436;
            font-family: 고딕;
            overflow: auto;
         }
         /*바디구역 : MvDetail_body*/
         div.MvDetail_body{/*컨텐츠 바디 전체*/
            padding: 0.4em;
            display: flex;
            flex-direction: row;
            position: relative;
         }div.Mvbody_contentArea{/*네비 제외한 컨텐츠 영역*/
            margin: 1px 10px 1px 1px;
            padding: 5px;
            display: flex;
            flex-direction: column;
            width: 75%;
         }div.EmptyArea{/*좌측빈칸용*/
            width: 5%;
         }div.rightNav_Area{/*우측 네브 영역*/
            position: relative;
            overflow: hidden;
            width: 15%;
            float: right;
         }div.mvDetail_ulArea{/*바디:정보-*/
            display: flex;
            flex-direction: column;
            margin-top: 20px;s
         }ul.mvDetail_ul{
            display: flex;
            flex-direction: row;
            list-style-type: none;
            padding-inline-start: 0;
            margin-block-start: 0;
            padding: 1em 0em 0.8em 0em;
         }ul.mvDetail_ul li{
            display: flex;
            flex-direction: row;
            list-style-type: none;
            color: #9EA4A5;
            align-items: flex-end;
         }div.mvDetail_ulArea hr{
            display: initial;
            unicode-bidi: initial;
            margin-block-start: initial;
            margin-block-end: initial;
            margin-inline-start: initial;
            margin-inline-end: initial;
            overflow: visible;
            border-style: solid;
            border-width: 0.3px;
            border-color: #DADEDF;
            margin: 25px 0px 25px 0px;
         }span.mv_txt{
            color: #26160C;
            font-family: monospace;
            font-size: 1.2em;
            font-weight: 800;
         }div.mvDetail_Mvtxt{
            margin: 35px 1px 30px 0px;
            padding: 15px 1px 15px 0px;
            color: #65625D;
            font-family: fantasy;
            font-size: 1.07em;
            font-weight: 500;
            line-height:1.7; 
         }div.mvDetail_Mvtxt b{
            font-weight: 700;
            font-size: 1.1em;
         }div.mvDetail_YOUTUBE{
            display: flex;
            width: 100%;
            position: relative;
            max-width: 960px;
            min-width: 100px;
            margin: 5px 5px 20px 0px;
         }div.mvDetail_YOUTUBE video#myVideo{
            width: 100%;
         }div.board_header{
            width: 100%;
            margin: 30px 0px 30px 0px;
            display: flex;
            flex-direction: row;
            align-items: center;
         }span.starRating_span{
            border: #555555 solid 1px;
            border-radius: 40px;
            color: #282A35;
            padding: 12px 18px;
            text-decoration: none;
            font-size: 0.8em;
            font-weight: 600;
            margin : 0px 20px 0px 10px;
         }button.starRating_New,.starRating_like,.starRating_ME{
            width: 5.3em;
            height: 2.4em;
            border: 0px;
            color: white;
            background: #282A35;
            margin: 3px 5px 3px 5px;
            border-radius: 8px;
         }
      /*영화추천 횡스크롤용 버튼*/
         div.MvF_contentOutside {
            display: flex;
            flex-direction: row;
            overflow-x: scroll;
            white-space: nowrap;
            scroll-behavior: smooth;
            margin: 15px;
         }div.MvF_contentOutside::-webkit-scrollbar {
            height: 0; /* 숨김 처리 */
            width: 0;
            background-color: transparent;
         }
         div.MvF_contentArea{
            display: flex;
            flex-direction: column;
            height: 520px;
            width: 290px;
            margin: 10px;
            padding: 5px;
         }div.MvfC_poster{
            padding-bottom: 5px;
         }div.MvfC_text{
            margin-top: 15px;
            width: 100%;
            display: flex;
            flex-direction: column;
         }div.MvfC_text span{
            display: block;
            white-space: pre-wrap;
            font-family: fantasy;
            font-size: 1em;
            color:#65625D;
         }div.MvfC_text span.ccJenre{
            font-size: 0.88em;
            margin-top: 10px;
            margin-bottom: 20px;
         }
         div.MvDetail_foot{
            width: 100%;
            display: flex;
            flex-direction: column;
            padding: 23px;
            background-color: white;
         }div.MvFooter_head{
            display: flex;
            flex-direction: column;
            margin: 1px 1px 10px 10px;
         }div.MvFooter_head h2{
            color: #26160C;
            margin-bottom: 10px;
         }div.MvF_buttonArea{
            display: flex;
            flex-direction: row;
            padding: 1px 2px 1px 2px;
            align-items: center;
            justify-content: flex-start;
         }button.left-button, button.right-button{
            margin: 1px 8px 1px 8px;
            width: 3em;
            height: 3em;
            background: #282A35;
            border-radius: 30px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            color : #282A35;
         }span.CCbutton{
            font-size: 1em;
            font-weight: 700;
            color: white;
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