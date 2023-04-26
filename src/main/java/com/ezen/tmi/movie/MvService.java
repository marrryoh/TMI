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
	
	public ArrayList<MgMovie_DTO> stateSearch(int state);//국가별 영화검색
	public int searchtt(int state);//국가별 영화검색했을 때 영화 개수
	public MgMovie_DTO mvDetail(int a);//영화상세보기
	public String mvUserNic(String login_id);//로그인아이디로 로그인한 사람 닉네임 찾기
	public int mvStarCnt(int a);//(별점게시판 페이징용)총 후기 가져오기
	public ArrayList<MvStarDTO> starOutNEW(int a, PageDTO pd);//별점 후기 게시판(최신순)
	public ArrayList<MvStarDTO> starOutGOOD(int a, PageDTO pd);//별점 후기 게시판(추천순)
	public MvStarDTO starOutME(int a, PageDTO pd);//별점 후기(내꺼)
	public int mvD_JimCheck(String login_id, int a);//이 영화 찜여부 파악
	public int jenreNkey(String movie_jenre, String movie_keyword);//장르 키워드 일치 영화 있어?
	public ArrayList<MgMovie_DTO> ccMovie(String movie_jenre, String movie_keyword, int a);//추천영화
	public ArrayList<MgMovie_DTO> jORk(String movie_jenre, String movie_keyword, int a);//장르 or 키워드
	public int doubleStar(int code, String login_id);//영화 평점 중복으로 남기진 않았는지 한 번 체크합시다.
}
