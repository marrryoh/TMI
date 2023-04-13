package com.ezen.tmi.manager;

public class MgDirector_DTO {
	int dir_code;
	String dir_name, dir_birth, dir_aff, dir_debut, dir_info, dir_pic;
	String dir_day;
	
	public MgDirector_DTO(int dir_code, String dir_name, String dir_birth, String dir_aff,
			String dir_debut, String dir_info, String dir_pic) {
		super();
		this.dir_code = dir_code;
		this.dir_name = dir_name;
		this.dir_birth = dir_birth;
		this.dir_aff = dir_aff;
		this.dir_debut = dir_debut;
		this.dir_info = dir_info;
		this.dir_pic = dir_pic;
	}
	public MgDirector_DTO() {}
	public int getDir_code() {
		return dir_code;
	}
	public void setDir_code(int dir_code) {
		this.dir_code = dir_code;
	}
	public String getDir_name() {
		return dir_name;
	}
	public void setDir_name(String dir_name) {
		this.dir_name = dir_name;
	}
	public String getDir_birth() {
		return dir_birth;
	}
	public void setDir_birth(String dir_birth) {
		this.dir_birth = dir_birth;
	}
	public String getDir_aff() {
		return dir_aff;
	}
	public void setDir_aff(String dir_aff) {
		this.dir_aff = dir_aff;
	}
	public String getDir_debut() {
		return dir_debut;
	}
	public void setDir_debut(String dir_debut) {
		this.dir_debut = dir_debut;
	}
	public String getDir_info() {
		return dir_info;
	}
	public void setDir_info(String dir_info) {
		this.dir_info = dir_info;
	}
	public String getDir_pic() {
		return dir_pic;
	}
	public void setDir_pic(String dir_pic) {
		this.dir_pic = dir_pic;
	}
	
	public String getDir_day() {
		dir_day=getDir_birth().substring(0, 10);
		return dir_day;
	}
}
