<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script type="text/javascript">
         $('.mgTitle_img> #mgMain_img').css('width','20%');
      </script>
      <style type="text/css">
         /* 전체 */
         #body {
            text-align: center;
            width: 100%;
            min-height: 100%;
            height: 100%
         }
         th{text-align: center;}
         
         /*헤더*/
         nav.navbar {
            display: flex;
            align-items: center;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            padding: 10px;
         }
         div.mgNav_Area{
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
            overflow: hidden;
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
            left: 0;
            z-index: 999;
            min-width: 150px;
            background-color: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            padding: 10px;
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
            padding: 5px;
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
            vertical-align: middle;
         }

         /* 영화등록 */
         div.mg_movInpt_form_area{
            align-content: center;
            margin-top: 10px;
         }
         div.mg_movInpt_form_area th{
            font-size: 17px;
            border: solid silver;
            margin: 2px;
            padding-left: 3px;
         }
         div.mg_movInpt_form_area td{
            font-size: 14px;
            border: solid silver;
            margin: 2px;
         }
         div.mg_movInpt_form_area input:not([type=button]){
            border: none;
         }
         div.mg_movInpt_form_area caption{
            font-size: 20px;
            text-align: center;
         }
         div.mg_movInpt_form_area td.button_td{
            font-size: 14px;
            border: none;
            margin: 2px;
         }
         table.mvInput_table input([type=button]) {
            width : 100px;
            height : 35px;
            border : 0px;
            color:white;
            background:#282A35;
            margin : 5px;
         }
         
         /* 관리자 메인 홈 */
         div.mgTitle_text{
            width: 100%;
            display: flex;
            align-self: center;
         }
         div.mgMain_title1{
            flex-direction: row;
            width: 28%;
            margin-left: 30px;
            margin-bottom: 30px;
            margin-top: 50px;
            margin-right:20px;
            opacity: 0.8;
         }
         div.mgMain_title1:hover{
            opacity: 1.0;
         }
         div.mgMain_title2{
            flex-direction: row;
            width: 28%;
            margin-left: 20px;
            margin-bottom: 30px;
            margin-top: 50px;
            margin-right:10px; 
            opacity: 0.8;
         }
         div.mgMain_title2:hover{
            opacity: 1.0;
         }
         div.mgMain_title3{
            flex-direction: row;
            width: 28%;
            margin-left: 20px;
            margin-bottom: 30px;
            margin-top: 50px;
            margin-right:30px; 
            opacity: 0.8;
         }
         div.mgMain_title3:hover{
            opacity: 1.0;
         }
         div.mgTitle_img{
            flex-direction: column;
            width: 100%;
            
         }
         span.mgTitle{
            font-size: 22px;
            font-family: hanna;
         }
         div.mgTitle_img img{
            width: 100%;
            border-radius: 8px;
         }
         
      
         /* 영화관리 */
         div.movOut_area{
            margin-top: 10px;
            margin-left: 20px;
            margin-right: 20px;
            margin-bottom: 10px;
            padding-top: 3%;
            padding-bottom: 4%;
            padding-left: 5%;
            padding-right: 5%;
            border-radius: 10;
            background-color: rgba(200,200,200,0.6);
         }
         div.movOut_area table{
            border: 1px solid #ddd;
            background-color: #DCE4E3;
         }
         
         div.movOut_area table tr:hover{
            background-color: rgba(242,242,242,0.7);
         }
         div.movOut_area table th{
            text-align: center;
            align-content: center;
            align-items: center;
            align-self: center;
            padding-bottom: 4px;
            border: none;
            position: relative;
            font-size: 15px;
            padding: 5px;
         }
         div.movOut_area table td{
            border: none;
            font-family: 돋움;
            padding: 3px;
            padding-left: 6px;
            padding-right: 6px;
            margin-left: 2px;
            margin-right: 2px;
         }
         
         
         /* 등록영화 상세보기 */
         div.movie{
            display: block;
            margin-top: 10px;
            margin-left: 50px;
            margin-right: 50px;
            padding-top: 5px;
            padding-bottom: 2px;
            padding-left: 2px;
            padding-right: 2px;
            background-color: rgba(244,244,244,0.5);
         }
         div.movie-info{
            margin-left: 120px;
            margin-right: 100px;
            display: flex;
         }
         div.img-banner{
            margin: 30px;
            display:block;
         }
         div.text-banner{
            flex: 1 1 auto;
         }
         div.movie-text-banner-top{
         padding-bottom: 10px;
         margin-bottom: 5px;
         padding-right: 10 px;
         margin-right: 5px; 
         }
         div.movie-text-banner-button{
            display: inline-block;
            flex: 1 1 auto;
            bottom: 10px;
            margin-top: 50px;
         }
         div.movie-text-banner-button li{
            margin: 10px;
         }
         h2#movie-info-title{
            font-family: 궁서;
            display: block;
            align-items: center;
            text-align: center;
         }
         div.movie-text-banner-bottom{
            margin-bottom: 20px;
         }
         div.movie-text-banner-bottom ul{
            margin: 10px;
            margin-bottom: 20px;
            border: 200px;
         }
         div.movie-text-banner-bottom li{
            font-family: 돋움;
            font-size: 12px;
            text-align: left;
            font-weight: 200;
            padding-bottom: 5px;
            display: flex;
            flex-direction: row;            
         }
         div.movie-info-text{
            align-items: center;
            display: block;
            text-align: center;
            align-content: center;
            margin-top: 10px;
            margin: 10%;
            padding-top: 10px;
            padding-bottom: 2%;
            width: 100%;
            font-size: 15px;
         }
         ul.movie-text-ul{
            height: 60px;
            flex-direction: row;
         }  
         p.movie-detail-txt{
            font-weight: bold;
            flex-direction: row;
         }
         
         
         

         div.outer{
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
         div.membertitle{
            text-align: center;
         }
         form#memberinput {
            width : 400px;
            margin: auto;
            padding: 10px;
         }
         form#memberinput h1 {
            text-align:center;
            color: gray;
         }
         select.input_area {
             border: solid 1px #dadada;
             padding : 10px 10px 14px 10px;
             background : white;
         }
         select.radio_area {
             border: solid 1px #dadada;
             padding : 10px 10px 14px 10px;
             vertical-align: middle;
             background : white;
         }
         span.radio_area input{
              flex: row;   
              vertical-align: middle;
         }
         select.input_area input {
            width : 250px;
            height : 30px;
            border: 0px;
         }         
         span.input_area input {
            width : 250px;
            height : 30px;
            border: 0px;
            
         }
         span.input_id_area{
            border: solid 1px #dadada;
             padding : 10px 5px 14px 10px;
             background : white;
         }
         span.input_id_area input{
             width : 180px;
            height : 30px;
            border: 0px;
         }
         div.btnArea {
            text-align:center;
            padding : 50px;
         }
         button#idCheck{
            flex: row;
            width : 65px;
            height : 35px;
            border : 0px;
            color:white;
            background:#282A35;
            font-size: 11px;
            margin : 3px;
            margin-left: 2px;
         }
         button#joinBtn {
            width : 100px;
            height : 35px;
            border : 0px;
            color:white;
            background:#282A35;
            margin : 5px;
         }
     	 a
  	{
     text-decoration-line: none;
     color: #5F3016;
    }  
    
    /* 푸터 */
    #footer
    {
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
 		position: absolute;
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
	/* 게시판 출력 */
  	table, td, th 
  	{
  	border-collapse : collapse;
	};
	
	a
    {
     text-decoration-line: none;
     color: #5F3016;
    }
    
    .delbtn
    {
      width : 100px;
      height : 35px;
      border : 0px;
      color:white;
      background:#282A35;
      margin : 5px;
    }
    
    /*게시판*/    
    #wrap 
    {
    min-height: calc(100vh - 60px);
  	position: relative;
  	padding-bottom: 60px;
	}
    .board
	{
  	display: flex;
  	justify-content: center;
  	align-items: center;
  	flex-direction: column;
	}
	.board_top
	{
	margin-top: 20px;
	}
    .QnAouter
    {
     width:60%;
     min-width : 650px;
     margin:auto;
     margin-top : 130px;
     margin-bottom : 130px;
    }
    #QnA_Area_top
    {
    	margin-bottom: 60px;
    }
     #QnA_Area_Re
    {
    	margin-top: 20px;
    	margin-bottom: 20px;
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
    #QnA_spanArea_ty
    {
   		display: flex;
        width : 270px;
        height: 30px;
        padding : 5px 5px 5px 5px;
    }
    #QnA_spanArea_da
    {
   		display: flex;
        height: 30px;
        padding : 5px 5px 5px 5px;
        font-size: 13px;
    }
    #QnA_Area_cont
    {
    	width : 900px;
        height: 200px;
        display: flex;
        align-items: center;
		margin-left: 10px;
		text-align: left;
    }
    #QnA_Re_cont
    {
    	width : 900px;
        height: 100px;
        display: flex;
        align-items: center;
		margin-left: 10px;
		text-align: left;
    }
    #QnA_Area_file
    {
    	display: flex;
        align-items: center;
        margin: 10px;
        justify-content: center;
        height: 60px;
    }
    #QnA_Area_mg
    {
    	margin: 50px 5px 30px 5px;
    	padding: 5px; 
    }
    #QnA_Area_tt
    {
    display: flex;
    justify-content: space-between;
    }
    #submit {
	width : 100px;
	height : 35px;
	border : 0px;
	color:white;
	background:#282A35;
	margin : 5px;
	}
	button {
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
         <div id="manager_Header">
            <t:insertAttribute name="manager_Header"/>
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