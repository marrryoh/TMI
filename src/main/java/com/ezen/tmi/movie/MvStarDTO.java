package com.ezen.tmi.movie;

public class MvStarDTO {
	int mr_num, movie_code;
	String mr_id;
	int mr_star;
	String mr_content;
	int mr_like, mr_bad;
	String mr_day;
	String mday;
	String user_nic;
	String star;
	
	public MvStarDTO() {}

	public MvStarDTO(int mr_num, int movie_code, String mr_id, int mr_star, String mr_content, int mr_like, int mr_bad,
			String mr_day) {
		super();
		this.mr_num = mr_num;
		this.movie_code = movie_code;
		this.mr_id = mr_id;
		this.mr_star = mr_star;
		this.mr_content = mr_content;
		this.mr_like = mr_like;
		this.mr_bad = mr_bad;
		this.mr_day = mr_day;
	}

	public int getMr_num() {
		return mr_num;
	}

	public void setMr_num(int mr_num) {
		this.mr_num = mr_num;
	}

	public int getMovie_code() {
		return movie_code;
	}

	public void setMovie_code(int movie_code) {
		this.movie_code = movie_code;
	}

	public String getMr_id() {
		return mr_id;
	}

	public void setMr_id(String mr_id) {
		this.mr_id = mr_id;
	}

	public int getMr_star() {
		return mr_star;
	}

	public void setMr_star(int mr_star) {
		this.mr_star = mr_star;
	}

	public String getMr_content() {
		return mr_content;
	}

	public void setMr_content(String mr_content) {
		this.mr_content = mr_content;
	}

	public int getMr_like() {
		return mr_like;
	}

	public void setMr_like(int mr_like) {
		this.mr_like = mr_like;
	}

	public int getMr_bad() {
		return mr_bad;
	}

	public void setMr_bad(int mr_bad) {
		this.mr_bad = mr_bad;
	}

	public String getMr_day() {
		return mr_day;
	}

	public void setMr_day(String mr_day) {
		this.mr_day = mr_day;
	}

	public String getMday() {
		mday=getMr_day().substring(0, 10);
		mday=mday.replace("-",".");
		return mday;
	}

	public String getUser_nic() {
		return user_nic;
	}

	public void setUser_nic(String user_nic) {
		this.user_nic = user_nic;
	}
	
	public String getStar() {
		switch (getMr_star()) {
		case 1: star="¡Ú";break;
		case 2: star="¡Ú¡Ú";break;
		case 3: star="¡Ú¡Ú¡Ú";break;
		case 4: star="¡Ú¡Ú¡Ú¡Ú";break;
		case 5: star="¡Ú¡Ú¡Ú¡Ú¡Ú";break;
		default:
			break;
		}
		return star;
	}
}
