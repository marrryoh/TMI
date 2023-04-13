<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<nav>
	<div class="Sidebar_outer">
		<div class="sidebar_area">
			<span id="sidebar_title">검색어 순위</span>
		 <c:forEach items="${sresult}" var="s" varStatus="status">
			<span id="sidebar_R">${status.index +1}위
			<a id="sidebar_R_a" href="mainSearchsave?svalue=${s.search_value}">${s.search_value}</a></span>			
		 </c:forEach>
		</div>
		<span id="sidebar_a"> <a href="#searchTop">맨 위로</a> </span>		
	</div>
</nav>
</html>


