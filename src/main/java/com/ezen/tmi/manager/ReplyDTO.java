package com.ezen.tmi.manager;

public class ReplyDTO {
	int re_num, bo_num;
	String re_content,re_day;

	public ReplyDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReplyDTO(int re_num, int bo_num, String re_content, String re_day) {
		super();
		this.re_num = re_num;
		this.bo_num = bo_num;
		this.re_content = re_content;
		this.re_day = re_day;
	}
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public int getBo_num() {
		return bo_num;
	}
	public void setBo_num(int bo_num) {
		this.bo_num = bo_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_day() {
		return re_day;
	}
	public void setRe_day(String re_day) {
		this.re_day = re_day;
	}
	
	
}
