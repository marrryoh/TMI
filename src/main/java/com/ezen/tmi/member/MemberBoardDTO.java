package com.ezen.tmi.member;

public class MemberBoardDTO {
	int bo_num;
	String bo_id, bo_type, bo_title, bo_day, bo_content, bo_img;
	int bo_ox;
	
	public MemberBoardDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberBoardDTO(int bo_num, String bo_id, String bo_type, String bo_title, String bo_day, String bo_content,
			String bo_img, int bo_ox) {
		super();
		this.bo_num = bo_num;
		this.bo_id = bo_id;
		this.bo_type = bo_type;
		this.bo_title = bo_title;
		this.bo_day = bo_day;
		this.bo_content = bo_content;
		this.bo_img = bo_img;
		this.bo_ox = bo_ox;
	}
	public int getBo_num() {
		return bo_num;
	}
	public void setBo_num(int bo_num) {
		this.bo_num = bo_num;
	}
	public String getBo_id() {
		return bo_id;
	}
	public void setBo_id(String bo_id) {
		this.bo_id = bo_id;
	}
	public String getBo_type() {
		return bo_type;
	}
	public void setBo_type(String bo_type) {
		this.bo_type = bo_type;
	}
	public String getBo_title() {
		return bo_title;
	}
	public void setBo_title(String bo_title) {
		this.bo_title = bo_title;
	}
	public String getBo_day() {
		return bo_day;
	}
	public void setBo_day(String bo_day) {
		this.bo_day = bo_day;
	}
	public String getBo_content() {
		return bo_content;
	}
	public void setBo_content(String bo_content) {
		this.bo_content = bo_content;
	}
	public String getBo_img() {
		return bo_img;
	}
	public void setBo_img(String bo_img) {
		this.bo_img = bo_img;
	}
	public int getBo_ox() {
		return bo_ox;
	}
	public void setBo_ox(int bo_ox) {
		this.bo_ox = bo_ox;
	}
	
	
	
}








