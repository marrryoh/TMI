package com.ezen.tmi.member;

import java.util.ArrayList;

import com.ezen.tmi.manager.PageDTO;
import com.ezen.tmi.manager.ReplyDTO;

public interface MemService {
	
	//입력
	public void memberinsert(String user_id, String user_pw, String user_nic, String user_birth, String user_gender,
			String user_address);
	//중복검사
	public int idCheck(String user_id);
	public int nicCheck(String user_nic);

	//회원 로그인
	public MemberDTO member_Login(String login_id, String login_pw);

	//회원 정보 불러오기
	public MemberDTO member_Info(String loginid);
	
	//회원정보 수정 시 세션 아이디로 현재 닉네임 확인하기
	public String myid(String user_id); 
	
	//회원 수정 저장
	public void modify(String user_id, String user_pw, String user_nic, String user_birth, String user_gender,
			String user_address);
	
	//회원 탈퇴
	public String memberdelete(String user_id);
	
	//QnA 작성
	public void QnAinsert(String bo_id, String bo_type, String bo_title, String bo_content, String fname);
	
	//내 문의글 페이징 처리
	public int cntmyboard(String id);
	public ArrayList<MemberBoardDTO> selectmyboard(String id, PageDTO dto);
	
	//내 문의글 다 불러오기
	public ArrayList<MemberBoardDTO> member_myboard(String id);
	
	//문의글 자세히 보기
	public MemberBoardDTO boarddetail(int num);
	//문의글 댓글 불러오기
	public ArrayList<ReplyDTO> replyout(int bo_num);
}
