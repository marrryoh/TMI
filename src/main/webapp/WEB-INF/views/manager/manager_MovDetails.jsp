<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
			<div class="movie">
				<div class="movie-info">
					<div class="img-banner">
						<p>관리번호:${mto.movie_code}</p>
						<img src="imgsave/movieImg/${mto.movie_poster}" width="220px">
					</div>
					<div class="text-banner">
						<div class="movie-text-banner-top">
							<h2 id="movie-info-title">${mto.movie_name }</h2>　${mto.movie_new}
							<hr style="border-bottom: 1px solid black;">
						</div>
						<div class="text-banner">
							<div class="movie-text-banner-bottom">
								<ul>
									<li>국가:<p class="movie-detail-txt">${mto.movie_state}</p></li>
									<li>
										감독:<p class="movie-detail-txt"><a href="#">${mto.movie_director}</a></p>
									</li>
									<li>배우:<p class="movie-detail-txt">${mto.movie_actor}</p></li>
									<li>장르:<p class="movie-detail-txt">${mto.movie_jenre}</p></li>
									<li>개봉일:<p class="movie-detail-txt">${mto.movie_day}</p></li>
									<li>러닝타임:<p class="movie-detail-txt">${mto.movie_rtime}분</p></li>
									<li>키워드:<p class="movie-detail-txt">${mto.movie_keyword}</p></li>
								</ul>
							</div>
						</div>
						<div class="movie-text-banner-button">
								<ul class="movie-text-ul">
									<li style="list-style-type: none;">
										<a href="movie_Output">
											<button>&#128072; 뒤로</button>
										</a>
									</li>
									<li style="list-style-type: none; display: flex;">
										<a href="movie_Modi?a=${mto.movie_code}">
											<button>&#127902; 수정/삭제</button>
										</a>				
									</li>
								</ul>
							</div>
					</div>
				</div>
				<hr>
				<div class="movie-info">
					<div class="movie-info-text">
						${mto.movie_plot}
					</div>
				</div>
			</div>
		</div>
	</body>
</html>