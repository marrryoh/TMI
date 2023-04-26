package com.ezen.tmi.member;

public class JimDTO {
	String like_id;
	int like_code;
	String movie_name,movie_poster,movie_jenre;
	
	public JimDTO() {}

	public JimDTO(String like_id, int like_code) {
		super();
		this.like_id = like_id;
		this.like_code = like_code;
	}

	public String getLike_id() {
		return like_id;
	}

	public void setLike_id(String like_id) {
		this.like_id = like_id;
	}

	public int getLike_code() {
		return like_code;
	}

	public void setLike_code(int like_code) {
		this.like_code = like_code;
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

	public String getMovie_jenre() {
		return movie_jenre;
	}

	public void setMovie_jenre(String movie_jenre) {
		this.movie_jenre = movie_jenre;
	}
	
	
}
