package com.ezen.tmi.movie;

import java.util.ArrayList;

import com.ezen.tmi.manager.MgMovie_DTO;
import com.ezen.tmi.manager.PageDTO;

public interface MvService {
	
	//����ȭ�� �˻� �� ���
	public int getTotal(String svalue); //�˻� �� ��� ���� ��
	public ArrayList<MgMovie_DTO> pagePerList(String svalue); //�˻� �� ��� ����
	public int searchcnt(String svalue); //�˻��� ����, �˻��� �߰�
	public ArrayList<SearchDTO> sresult(); 
	
	public ArrayList<MgMovie_DTO> stateSearch(int state);//������ ��ȭ�˻�
	public int searchtt(int state);//������ ��ȭ�˻����� �� ��ȭ ����
	public MgMovie_DTO mvDetail(int a);//��ȭ�󼼺���
	public String mvUserNic(String login_id);//�α��ξ��̵�� �α����� ��� �г��� ã��
	public int mvStarCnt(int a);//(�����Խ��� ����¡��)�� �ı� ��������
	public ArrayList<MvStarDTO> starOutNEW(int a, PageDTO pd);//���� �ı� �Խ���(�ֽż�)
	public ArrayList<MvStarDTO> starOutGOOD(int a, PageDTO pd);//���� �ı� �Խ���(��õ��)
	public MvStarDTO starOutME(int a, PageDTO pd);//���� �ı�(����)
	public int mvD_JimCheck(String login_id, int a);//�� ��ȭ �򿩺� �ľ�
	public int jenreNkey(String movie_jenre, String movie_keyword);//�帣 Ű���� ��ġ ��ȭ �־�?
	public ArrayList<MgMovie_DTO> ccMovie(String movie_jenre, String movie_keyword, int a);//��õ��ȭ
	public ArrayList<MgMovie_DTO> jORk(String movie_jenre, String movie_keyword, int a);//�帣 or Ű����
	public int doubleStar(int code, String login_id);//��ȭ ���� �ߺ����� ������ �ʾҴ��� �� �� üũ�սô�.
}
