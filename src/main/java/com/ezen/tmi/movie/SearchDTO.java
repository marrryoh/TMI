package com.ezen.tmi.movie;

public class SearchDTO {
	String search_value;
	int search_cnt;
	
	public SearchDTO(String search_value, int search_cnt) {
		super();
		this.search_value = search_value;
		this.search_cnt = search_cnt;
	}
	public SearchDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getSearch_value() {
		return search_value;
	}
	public void setSearch_value(String search_value) {
		this.search_value = search_value;
	}
	public int getSearch_cnt() {
		return search_cnt;
	}
	public void setSearch_cnt(int search_cnt) {
		this.search_cnt = search_cnt;
	}

}
