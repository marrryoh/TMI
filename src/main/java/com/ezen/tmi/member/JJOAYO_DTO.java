package com.ezen.tmi.member;

public class JJOAYO_DTO {
	int joa_num;
	String joa_id;
	
	public JJOAYO_DTO() {}
	
	public JJOAYO_DTO(int joa_num, String joa_id) {
		super();
		this.joa_num = joa_num;
		this.joa_id = joa_id;
	}
	public int getJoa_num() {
		return joa_num;
	}
	public void setJoa_num(int joa_num) {
		this.joa_num = joa_num;
	}
	public String getJoa_id() {
		return joa_id;
	}
	public void setJoa_id(String joa_id) {
		this.joa_id = joa_id;
	}
	
	
}
