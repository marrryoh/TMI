package com.ezen.tmi.manager;

import java.util.ArrayList;

import com.ezen.tmi.member.MemberBoardDTO;
import com.ezen.tmi.member.MemberDTO;

public interface MgService {
	public int mvCheck(String mvName, String mvDir);//��ȭ��� �� �ߺ�Ȯ��
	public void movin(String m1, String m2, String m3, String m4, String m6, int m5, String m7, String m8, String m9,
	         int m10, String m11, String m12);//��ȭ��� db�����ϱ�
	public int movPageCnt();//��Ͽ�ȭ ���� out page���� ����¡ó���� ���� ������ ī���ÿ� �޼ҵ�
	public ArrayList<MgMovie_DTO> movout(PageDTO pd);//����¡ó����Ų ä�� ���� ��������
	public MgMovie_DTO movDetail(String movie_code);//��ȭ�ڵ� �޾Ƽ� �� ��ȭ �ڵ� ���� ��ü ������ ��������(��ȭ �󼼺��� ��¿�)
	public void movDel(String movie_code);//��ϵ� ��ȭ ����
	public void movUpdate(String m1, String m2, String m3, String m4, String m5, int m6, String m7, String m8,
			String m9, int m10,String m12,String m13,int m11);//��ȭ ���� �ǽðڽ��ϴ� :D
	public int dirCheck(String dirName, String dirBirthday);// ��ȭ���� �ߺ��˻�
	public void dirin(String d1, String d2, String d3, String d4, String d5, String d6);//���� ���
	public ArrayList<MgDirector_DTO> dirout(PageDTO pd);//�������
	public MgDirector_DTO dirDetail(String dir_code);//���� �󼼺���
	public void dirDel(String dir_code);//���� ����
	public void dirUp(String d1, String d2, String d3, String d4, String d5, String d6, int d7);//���� ����
	public int dirMe(String dirCode);//���� ������ �̸� �����ߴ��� ���� �ľ�
	public int dirChck(String dirName, String dirBirthday, String dirCode);//�����ι� �̹� �ִ��� �ߺ��˻�
	public int mvChkMe(String mvCode);//��ȭ ������ �̸� ���� ���� �ľ�
	public int mvMcheck(String mvName, String mvDir, String mvCode);//��ȭ �ߺ��˻�
	
	//ȸ�� ���� ����¡ ó��
	public int cntnotice();
	public ArrayList<MemberDTO> selectnotice(PageDTO dto);
	
	//ȸ�� ����
	public String memdelete(String id);
	public String memdelck(String id);
	
	//���Ǳ� ��ü ����¡ ó��
	public int cntboard();
	public ArrayList<MemberBoardDTO> selectboard(PageDTO dto);
	
	//���Ǳ� �ڼ��� ����
	public MemberBoardDTO boarddetail(int num);
	
	//���Ǳ� ��� ����
	public void replyinsert(int bo_num, String re_content);
	//���Ǳ� ��� �ҷ�����
	public ArrayList<ReplyDTO> replyout(int bo_num);
	//��� ����
	public int oxcnt(int bo_num);
}
