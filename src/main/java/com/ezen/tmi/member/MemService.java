package com.ezen.tmi.member;

import java.util.ArrayList;

import com.ezen.tmi.manager.PageDTO;
import com.ezen.tmi.manager.ReplyDTO;

public interface MemService {
	
	//�Է�
	public void memberinsert(String user_id, String user_pw, String user_nic, String user_birth, String user_gender,
			String user_address);
	//�ߺ��˻�
	public int idCheck(String user_id);
	public int nicCheck(String user_nic);

	//ȸ�� �α���
	public MemberDTO member_Login(String login_id, String login_pw);

	//ȸ�� ���� �ҷ�����
	public MemberDTO member_Info(String loginid);
	
	//ȸ������ ���� �� ���� ���̵�� ���� �г��� Ȯ���ϱ�
	public String myid(String user_id); 
	
	//ȸ�� ���� ����
	public void modify(String user_id, String user_pw, String user_nic, String user_birth, String user_gender,
			String user_address);
	
	//ȸ�� Ż��
	public String memberdelete(String user_id);
	
	//QnA �ۼ�
	public void QnAinsert(String bo_id, String bo_type, String bo_title, String bo_content, String fname);
	
	//�� ���Ǳ� ����¡ ó��
	public int cntmyboard(String id);
	public ArrayList<MemberBoardDTO> selectmyboard(String id, PageDTO dto);
	
	//�� ���Ǳ� �� �ҷ�����
	public ArrayList<MemberBoardDTO> member_myboard(String id);
	
	//���Ǳ� �ڼ��� ����
	public MemberBoardDTO boarddetail(int num);
	//���Ǳ� ��� �ҷ�����
	public ArrayList<ReplyDTO> replyout(int bo_num);
	
	public void starin(int movie, String id, int star, String text);//���� ���
	public void mvJimm(String myid, int mv);//���ϱ�
	public int mJimCheck(String myid, int mv);//�򿩺�Ȯ���ϱ�
	public void mvJimmDel(String myid, int mv);//�� �����ϱ�
	public ArrayList<JimDTO> memberJjim(String login_id);//����
	public int countlike(int aa, String id);//��� ��õ����
	public void ilikeit(int aa, String login_id);//��� ��õ�ϱ�
	public void joayoUP(int aa);//��õ���� ����� ���ƿ䰡 �ö󰩴ϴ�
}
