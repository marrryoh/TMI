package com.ezen.tmi.manager;

import java.util.ArrayList;

import com.ezen.tmi.member.MemberBoardDTO;
import com.ezen.tmi.member.MemberDTO;

public interface MgService {
	public int mvCheck(String mvName, String mvDir);//영화등록 중 중복확인
	public void movin(String m1, String m2, String m3, String m4, String m6, int m5, String m7, String m8, String m9,
	         int m10, String m11, String m12);//영화등록 db저장하기
	public int movPageCnt();//등록영화 관리 out page에서 페이징처리를 위한 페이지 카운팅용 메소드
	public ArrayList<MgMovie_DTO> movout(PageDTO pd);//페이징처리시킨 채로 전부 가져오기
	public MgMovie_DTO movDetail(String movie_code);//영화코드 받아서 그 영화 코드 값의 전체 데이터 가져오기(영화 상세보기 출력용)
	public void movDel(String movie_code);//등록된 영화 삭제
	public void movUpdate(String m1, String m2, String m3, String m4, String m5, int m6, String m7, String m8,
			String m9, int m10,String m12,String m13,int m11);//영화 수정 되시겠습니다 :D
	public int dirCheck(String dirName, String dirBirthday);// 영화감독 중복검사
	public void dirin(String d1, String d2, String d3, String d4, String d5, String d6);//감독 등록
	public ArrayList<MgDirector_DTO> dirout(PageDTO pd);//감독출력
	public MgDirector_DTO dirDetail(String dir_code);//감독 상세보기
	public void dirDel(String dir_code);//감독 삭제
	public void dirUp(String d1, String d2, String d3, String d4, String d5, String d6, int d7);//감독 수정
	public int dirMe(String dirCode);//감독 수정시 이름 변경했는지 여부 파악
	public int dirChck(String dirName, String dirBirthday, String dirCode);//동일인물 이미 있는지 중복검사
	public int mvChkMe(String mvCode);//영화 수정시 이름 변경 여부 파악
	public int mvMcheck(String mvName, String mvDir, String mvCode);//영화 중복검사
	
	//회원 정보 페이징 처리
	public int cntnotice();
	public ArrayList<MemberDTO> selectnotice(PageDTO dto);
	
	//회원 강퇴
	public String memdelete(String id);
	public String memdelck(String id);
	
	//문의글 전체 페이징 처리
	public int cntboard();
	public ArrayList<MemberBoardDTO> selectboard(PageDTO dto);
	
	//문의글 자세히 보기
	public MemberBoardDTO boarddetail(int num);
	
	//문의글 댓글 저장
	public void replyinsert(int bo_num, String re_content);
	//문의글 댓글 불러오기
	public ArrayList<ReplyDTO> replyout(int bo_num);
	//댓글 증가
	public int oxcnt(int bo_num);
}
