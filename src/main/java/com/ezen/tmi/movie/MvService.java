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
}
