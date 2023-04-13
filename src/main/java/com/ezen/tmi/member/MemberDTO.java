package com.ezen.tmi.member;

public class MemberDTO {
	int user_num;
	String user_id,user_pw,user_nic,user_birth, user_gender,user_address;
	
	String sb;
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberDTO(int user_num, String user_id, String user_pw, String user_nic, String user_birth,
			String user_gender, String user_address) {
		super();
		this.user_num = user_num;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_nic = user_nic;
		this.user_birth = user_birth;
		this.user_gender = user_gender;
		this.user_address = user_address;
		
	}
	
	public String getSb() {
		if(user_gender.equals("1"))
		{
			sb="남자";
		}
		else
		{
			sb="여자";
		}
		return sb;
	}

	public int getUser_num() {
		return user_num;
	}

	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_nic() {
		return user_nic;
	}

	public void setUser_nic(String user_nic) {
		this.user_nic = user_nic;
	}

	public String getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	
	
}
