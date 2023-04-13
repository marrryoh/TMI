<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
	
	/*사이드바*/
	.Sidebar_outer
	{
	 position: fixed;
     top:350px;
     right:55px;
     text-align: center;
     border: 1px;
     margin: 5px;
     width: 180px;
     border: solid 1px #CCD4D7;
     border-radius: 15px;
	}
	.sidebar_area
	{
	margin: 10px;
	}
	#sidebar_R
	{
	font-weight: 500;
	display: flex;
	justify-content: center;
	margin: 10px;
	font-size: 18px;
	}
	#sidebar_title
	{
	font-weight: 600;
	font-size: 25px;
	height: 50px;
	justify-content: center;
    align-items: center;
	display: flex;
	}
	#sidebar_a
	{
	height: 50px;
	justify-content: center;
    align-items: center;
	display: flex;
	
	}
	 a
    {
     text-decoration-line: none;
     color: #5F3016;
     font-weight: 600;
    } 
    #sidebar_R_a
    {
    font-weight: 500;
	display: flex;
	flex-direction: column;
	font-size: 18px;
	margin-left: 10px;
    }
    
	</style>
	<body>
      <div id="container">
         <div id="nav">
            <t:insertAttribute name="nav"/>
         </div>
      </div>
   </body>
</head>
</html>