<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div class="mainBody_area">
			<div class="movOut_area" style="text-align: center;">
				<table class="count-1" border="1" align="center">
					<tr>
						<th></th><!-- 순번 -->
						<th>관리번호</th>
						<th></th><!-- 상영중 -->
						<th>국가</th>
						<th colspan="2">영화제목</th>
						<th>감독</th>
						<th>배우</th>
						<th>개봉일</th>
						<th>상영시간</th>
						<th>장르</th>
						<th>삭제</th>
					</tr>
					<c:forEach items="${out}" var="o">
						<tr>
							<td></td><!-- 순번 -->
							<td>${o.movie_code}</td>
							<td>${o.movie_new}</td>
							<td>${o.movie_state}</td>
							<td><img src="imgsave/movieImg/${o.movie_poster}" height="100"></td>
							<td>　<a href="manager_MovDetails?a=${o.movie_code}">${o.movie_name}</a>　</td>
							<td>${o.movie_director}</td>
							<td style="font-size: 11px;">${o.movie_actor}</td>
							<td>${o.movie_day}</td>
							<td>${o.movie_rtime}분</td>
							<td>${o.movie_jenre}</td>
							<td><a href="movie_Modi?a=${o.movie_code}">&#128502</a></td>
						</tr>
					</c:forEach>
					<tr style="border-left: none;border-right: none;border-bottom: none">
						<td colspan="12" style="text-align: center;">
						<c:if test="${pg.startPage!=1 }">
								<a href="movie_Output?nowPage=${pg.startPage-1 }&cntPerPage=${pg.cntPerPage}">◀</a>
							</c:if>
							<c:forEach begin="${pg.startPage}" end="${pg.endPage}" var="p">
								<c:choose>
									<c:when test="${p == pg.nowPage }">
										<b><span style="color: #2F95D0;font-family: bold">${p}</span></b>
									</c:when>
									<c:when test="${p != pg.nowPage }">
										<a href="movie_Output?nowPage=${p}&cntPerPage=${pg.cntPerPage}">${p}</a>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:if test="${pg.endPage != pg.lastPage}">
								<a href="movie_Output?nowPage=${pg.endPage+1}&cntPerPage=${pg.cntPerPage }">▶</a>
							</c:if>
						</td>
					</tr>
				</table>
				<br>
		</div>
		</div>
	</body>
</html>