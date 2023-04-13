package com.ezen.tmi.movie;

import java.util.ArrayList;

import com.ezen.tmi.manager.MgMovie_DTO;
import com.ezen.tmi.manager.PageDTO;

public interface MvService {
	
	//메인화면 검색 후 출력
	public int getTotal(String svalue); //검색 된 모든 정보 수
	public ArrayList<MgMovie_DTO> pagePerList(String svalue); //검색 된 모든 정보
	public int searchcnt(String svalue); //검색수 증가, 검색어 추가
	public ArrayList<SearchDTO> sresult(); 
}
