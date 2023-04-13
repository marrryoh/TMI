<%@ page language="java" contentType="text/html; chA` arset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
	
  <div class="mainBody"><div class="mainBodyTop">'${svalue}' 의 검색 결과 ${totcnt}건</div>
	
	<c:forEach items="${list}" var="o">
		<div class="mainBody_area">
			<div class="searchOut_area">
				<div class="searchimg_outline">
					<div class="searchimg">
						<img src="imgsave/movieImg/${o.movie_poster}" height="300">
					</div>
				</div>
				<div class="search_outline">
					<div class="searchtitle_outline">
					 <span class="search_title">
						<a href="main_MovDetails?a=${o.movie_code}">${o.movie_name}</a>
					 </span>
					</div>
					<br>
					<div class="search_All">
					<div class="search_info">
						${o.movie_director} &emsp;|&emsp; ${o.movie_actor}
					</div>
					<br>
					<div class="search_info">
						${o.movie_jenre} &emsp;|&emsp; ${o.movie_state}
						&emsp;|&emsp; ${o.movie_day} &emsp;|&emsp; ${o.movie_rtime}min
					</div>
					<br>
					<div class="search_keyword">
					${o.movie_keyword} 
					</div>
					<br>
					</div>
				</div>
		</div>
		<div class="mainBody_bottom">
		${o.movie_plot} 
		</div>	
	<hr>
	</div>	
	
		</c:forEach>
</div>	
<div style="margin-bottom: 100px;"></div>
							
	</body>
	 <%
      // /mainSearchRank 컨트롤러를 호출하는 코드 작성
      request.getRequestDispatcher("/mainSearchRank").include(request, response);
    %>
</html>