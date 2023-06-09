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
		<style type="text/css">
			th{text-align: center;}
			.count-1 {
				counter-increment: mycounter;
       		}
       		.count-1:not(.no-count) td:first-child:before {
       			content: counter(mycounter) " ";
       		}
       		.count-1:nth-child(1) { counter-reset: mycounter; }
		</style>
	</head>
	<body>
	<div id="wrap">
		<div class="mainBody_area">
			<div class="movOut_area" style="text-align: center;">
				<table border="1" align="center">
					<tr>
						<th></th><!-- 순번 -->
						<th>관리번호</th>
						<th>이름</th>
						<th>생년월일</th>
						<th>소속</th>
						<th>데뷔작</th>
						<th></th>
					</tr>
					<c:forEach items="${Dir}" var="o">
						<tr class="count-1" height="50">
							<td></td><!-- 순번 -->
							<td>${o.dir_code}</td>
							<td>　<a href="manager_DirDetails?a=${o.dir_code}">${o.dir_name}</a>　</td>
							<td>${o.dir_day}</td>
							<td>${o.dir_aff}</td>
							<td>${o.dir_debut}</td>
							<td><a href="movieDir_Modi?a=${o.dir_code}">&#128502</a></td>
						</tr>
					</c:forEach>
					<tr class="no-count" style="border-left: none;border-right: none;border-bottom: none">
						<td colspan="7" style="text-align: center;">
						<c:if test="${pg.startPage!=1 }">
								<a href="movieDir_Output?nowPage=${pg.startPage-1 }&cntPerPage=${pg.cntPerPage}">◀</a>
							</c:if>
							<c:forEach begin="${pg.startPage}" end="${pg.endPage}" var="p">
								<c:choose>
									<c:when test="${p == pg.nowPage }">
										<b><span style="color: #2F95D0;font-family: bold">${p}</span></b>
									</c:when>
									<c:when test="${p != pg.nowPage }">
										<a href="movieDir_Output?nowPage=${p}&cntPerPage=${pg.cntPerPage}">${p}</a>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:if test="${pg.endPage != pg.lastPage}">
								<a href="movieDir_Output?nowPage=${pg.endPage+1}&cntPerPage=${pg.cntPerPage}">▶</a>
							</c:if>
						</td>
					</tr>
				</table>
			<br>
		</div>
		</div>
	  </div>	
	</body>
</html>