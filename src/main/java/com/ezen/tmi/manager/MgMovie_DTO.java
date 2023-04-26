package com.ezen.tmi.manager;

import java.time.LocalDate;

public class MgMovie_DTO {
	
		String movie_code, movie_name, movie_poster, movie_director, movie_actor, movie_rday;
		int movie_rtime;
		String movie_jenre, movie_keyword, movie_plot;
		int movie_group;
		String movie_link, movie_reserve;
		int movie_pop;
		String movie_new,movie_state,movie_day;
		
		public MgMovie_DTO() {}
		
		public MgMovie_DTO(String movie_name, String movie_director) {
			super();
			this.movie_name = movie_name;
			this.movie_director = movie_director;
		}


		public MgMovie_DTO(String movie_code, String movie_name, String movie_poster, String movie_director,
				String movie_actor, String movie_rday, int movie_rtime, String movie_jenre, String movie_keyword,
				String movie_plot, int movie_group, String movie_link, String movie_reserve, int movie_pop) {
			super();
			this.movie_code = movie_code;
			this.movie_name = movie_name;
			this.movie_poster = movie_poster;
			this.movie_director = movie_director;
			this.movie_actor = movie_actor;
			this.movie_rday = movie_rday;
			this.movie_rtime = movie_rtime;
			this.movie_jenre = movie_jenre;
			this.movie_keyword = movie_keyword;
			this.movie_plot = movie_plot;
			this.movie_group = movie_group;
			this.movie_link = movie_link;
			this.movie_reserve = movie_reserve;
			this.movie_pop = movie_pop;
		}

		public String getMovie_code() {
			return movie_code;
		}

		public void setMovie_code(String movie_code) {
			this.movie_code = movie_code;
		}

		public String getMovie_name() {
			return movie_name;
		}

		public void setMovie_name(String movie_name) {
			this.movie_name = movie_name;
		}

		public String getMovie_poster() {
			return movie_poster;
		}

		public void setMovie_poster(String movie_poster) {
			this.movie_poster = movie_poster;
		}

		public String getMovie_director() {
			return movie_director;
		}

		public void setMovie_director(String movie_director) {
			this.movie_director = movie_director;
		}

		public String getMovie_actor() {
			return movie_actor;
		}

		public void setMovie_actor(String movie_actor) {
			this.movie_actor = movie_actor;
		}

		public String getMovie_rday() {
			return movie_rday;
		}

		public void setMovie_rday(String movie_rday) {
			this.movie_rday = movie_rday;
		}

		public int getMovie_rtime() {
			return movie_rtime;
		}

		public void setMovie_rtime(int movie_rtime) {
			this.movie_rtime = movie_rtime;
		}

		public String getMovie_jenre() {
			return movie_jenre;
		}

		public void setMovie_jenre(String movie_jenre) {
			this.movie_jenre = movie_jenre;
		}

		public String getMovie_keyword() {
			return movie_keyword;
		}

		public void setMovie_keyword(String movie_keyword) {
			this.movie_keyword = movie_keyword;
		}

		public String getMovie_plot() {
			return movie_plot;
		}

		public void setMovie_plot(String movie_plot) {
			this.movie_plot = movie_plot;
		}

		public int getMovie_group() {
			return movie_group;
		}

		public void setMovie_group(int movie_group) {
			this.movie_group = movie_group;
		}

		
		
		public String getMovie_link() {
			return movie_link;
		}

		public void setMovie_link(String movie_link) {
			this.movie_link = movie_link;
		}

		public String getMovie_reserve() {
			return movie_reserve;
		}

		public void setMovie_reserve(String movie_reserve) {
			this.movie_reserve = movie_reserve;
		}

		public int getMovie_pop() {
			return movie_pop;
		}

		public void setMovie_pop(int movie_pop) {
			this.movie_pop = movie_pop;
		}

		public String getMovie_new() {
			 LocalDate ld=LocalDate.now().minusMonths(1);
	         LocalDate rday = LocalDate.parse(getMovie_rday().substring(0, 10));
	         if (rday.isAfter(ld)) {
	            movie_new="상영중";
	         }
	         return movie_new;
		}
		
		public String getMovie_state() {
			switch(getMovie_group()) {
				case 1: movie_state="한국영화"; break;
				case 2: movie_state="아시아"; break;
				case 3: movie_state="유럽"; break;
				case 4: movie_state="아메리카"; break;
				case 5: movie_state="중동"; break;
				case 6: movie_state="아프리카"; break;
				case 7: movie_state="오세아니아"; break;

				default : movie_state="[코딩오류]1-7외의 값이 출력되었습니다.";
				break;
			}//switch문 끝!
			return movie_state;
		}
		
		public String getMovie_day() {
			movie_day=getMovie_rday().substring(0, 10);
			return movie_day;
		}
}
