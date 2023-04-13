<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
#container {
   border: 1px slid #bcbcbc;
}
#header {
   text-align: center;
   width: 100%;
}
#nav {
   width: 100%;
}
#body {
text-align: center;
   width: 100%;
}
#footer
    {
    position: absolute;
  	left: 0;
  	right: 0;
  	height: 60px;
  	width: 100%;
  	transform : translateY(-100%);
    }      
th,td{
text-align: center;
}
caption{
text-align: center;
}
.outer_join
{
	width:60%;
	min-width : 650px;
	background: rgb(248, 249, 250);
	box-shadow: rgba(0, 0, 0, 0.06) 0px 0px 4px 0px;
	margin:auto;
	margin-top : 50px;
	margin-bottom : 50px;
}
.membertitle
{
	text-align: center;
	padding : 10px 10px 14px 10px;
}
	
#memberinput 
{
	width : 400px;
	margin: auto;
	padding: 10px;
}
	
#memberinput h1 
{
	text-align:center;
}
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
    flex: row;
    
}	

.btnArea {
	text-align:center;
	padding : 50px;
}

div.mebertt_1 button
{
	flex: row;
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

#submit {
	width : 100px;
	height : 35px;
	border : 0px;
	color:white;
	background:#282A35;
	margin : 5px;
	border-radius: 10px;
}

	/* 푸터 */
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
	a
    {
     text-decoration-line: none;
     color: #5F3016;
    }	
    
    /* 검색 키워드 버튼 */
   .btn_keyword
   {
  	color: white;
  	background-color: #7fb1bf; 
  	padding: 15px 25px;
  	display: inline-block;
  	border: 1px solid rgba(0,0,0,0.21);
  	border-bottom-color: rgba(0,0,0,0.34);
  	text-shadow:0 1px 0 rgba(0,0,0,0.15);
  	box-shadow: 0 1px 0 rgba(255,255,255,0.34) inset, 
              	0 2px 0 -1px rgba(0,0,0,0.13), 
              	0 3px 0 -1px rgba(0,0,0,0.08), 
             	 0 3px 13px -1px rgba(0,0,0,0.21);
	}	
	.btn_keyword:active 
	{
 	 top: 1px;
  	 border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
 	 box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
 	 position: relative;
	}
	 #wrap 
    {
    min-height: calc(100vh - 60px);
  	position: relative;
  	padding-bottom: 60px;
	}
</style>
<meta charset="UTF-8">
<title><t:insertAttribute name="title"/></title>
</head>
<body>
   <div id="container">
      <div id="body">
         <t:insertAttribute name="body"/>
      </div>
      <div id="footer">
         <t:insertAttribute name="footer"/>
      </div>
   </div>
</body>
</html>