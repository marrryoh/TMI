package com.ezen.tmi.movie;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.tmi.manager.MgMovie_DTO;
import com.ezen.tmi.manager.PageDTO;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.tmi.member.MemService;

//영화
@Controller
public class MovieController {
	
	@Autowired
	SqlSession ss;
	
	//영화 총 검색
	@RequestMapping(value = "/mainSearchsave")
	public String ms1(HttpServletRequest request, Model mo)
	{
		String svalue = request.getParameter("svalue");
	    MvService ms = ss.getMapper(MvService.class); 
	    ArrayList<MgMovie_DTO> list;
	    //전체 레코드 수
	    int total = ms.getTotal(svalue); 
	    mo.addAttribute("svalue", svalue);
	    mo.addAttribute("totcnt", total);
	    
	    // 검색어가 null이 아니고 빈칸이 아닌 경우에만 실행
	    if (svalue != null && !svalue.isEmpty()) { 
	        //검색수 증가, 검색어 추가
	        ms.searchcnt(svalue);
	    }
	    //영화 내용을 300자 이내로 자르고, 줄 바꿈 제거
	    list = ms.pagePerList(svalue);
	    for (MgMovie_DTO movie : list) {
	        String plot = movie.getMovie_plot();
	        if (plot != null && plot.length() > 300) {
	            plot = plot.substring(0, 300) + " ..."; // 150자까지만 출력하고 "..." 추가
	        }
	        plot = plot.replace("<br>", "").replace("\n", ""); // 줄바꿈 제거
	        movie.setMovie_plot(plot);
	    }
	    mo.addAttribute("list", list);

	    return "main_SearchOut";
	   }
	
	//검색어 출력
	@RequestMapping(value = "/mainSearchRank")
	public String ms2(Model mo)
	{
		 MvService ms = ss.getMapper(MvService.class); 
		 ArrayList<SearchDTO> sresult = ms.sresult();
		 Collections.sort(sresult,new Comparator<SearchDTO>() {
			 public int compare(SearchDTO s1, SearchDTO s2) 
			 {
				 return s2.getSearch_cnt() - s1.getSearch_cnt(); // 내림차순으로 정렬
			 }		 
		 });
		 List<SearchDTO> top5 = sresult.subList(0, Math.min(sresult.size(), 5)); // 상위 5개
		 mo.addAttribute("sresult", top5);	 
		return "main_Side";
	}
	
	@RequestMapping(value = "/movieSearchstate")
	public String movieSearchstate(HttpServletRequest request, Model mo){
		int state = Integer.parseInt(request.getParameter("svalue"));
		String svalue="한국영화";
		switch (state) {
		case 1: svalue="한국영화";	break;
		case 2: svalue="아시아";	break;
		case 3: svalue="아메리카";	break;
		case 4: svalue="유럽";	break;
		case 5: svalue="아프리카";	break;
		case 6: svalue="중동";	break;
		case 7: svalue="오세아니아";	break;
		default:
			svalue="";
			break;
		}
		MvService ms = ss.getMapper(MvService.class);
		ArrayList<MgMovie_DTO> list;
		//전체 레코드 수
		int total = ms.searchtt(state);
		mo.addAttribute("svalue", svalue);
		mo.addAttribute("totcnt", total);
		//영화 내용을 150자 이내로 자르고, 줄 바꿈 제거
		list = ms.stateSearch(state);
		for (MgMovie_DTO movie : list) {
			String plot = movie.getMovie_plot();
			if (plot != null && plot.length() > 300) {
				plot = plot.substring(0, 300) + " ..."; // 150자까지만 출력하고 "..." 추가
			}
			plot = plot.replace("<br>", "").replace("\n", ""); // 줄바꿈 제거
			movie.setMovie_plot(plot);
		}
		mo.addAttribute("list", list);
		return "main_SearchOut";
	}//국가별 검색
	
	
	//영화 상세보기
	@RequestMapping(value = "/main_MovDetails")
	   public String main_MovDetails(HttpServletRequest request, Model m) {
	      HttpSession hs=request.getSession();
	      String login_id = (String) hs.getAttribute("login_id");
	      Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");
	      
	      int a=Integer.parseInt(request.getParameter("a"));//정민님이 던져줄 코드
	      hs.setAttribute("movie_codeNum", a); //서버에 마지막 선택한 movie_codeNum을 저장하기.
	      hs.setMaxInactiveInterval(600); //로그인이 아닐 경우 그 코드를 10분만 가지고 있을 거야.
	      MvService srv=ss.getMapper(MvService.class);
	      MgMovie_DTO movie=srv.mvDetail(a);//영화전체정보 가져오고
	      m.addAttribute("mvDTO", movie);//출력할거야. 그다음에 뭐하려고했더라.
	      if(movie.getMovie_new()==null) {
	         m.addAttribute("nowNew", false);
	      }else if(movie.getMovie_new().equals("상영중")) {
	         m.addAttribute("nowNew", true);
	      }else {
	         m.addAttribute("nowNew", false);
	      }
	      int yes=0;
	      m.addAttribute("like", yes);
	      //던져줄 객체
	            /*1. movie (영화 정보 전체)
	             *2. 찜여부 
	             *3. 별점 게시판은 인클루드니까 여기 안 필요해졌어.
	             *4. 추천영화
	             * 아이디에 따른 개인정보 필요없음 */
	      int jnk=srv.jenreNkey(movie.getMovie_jenre(),movie.getMovie_keyword());
	      ArrayList<MgMovie_DTO> chuchen=srv.ccMovie(movie.getMovie_jenre(),movie.getMovie_keyword(),a);
	      //7개 출력이야, 우선순이는 jnk
	      //jnk가 7개가 안되면 나머지 애들로 채워야해.
	      if(jnk<1) {
	         ArrayList<MgMovie_DTO> jj=srv.jORk(movie.getMovie_jenre(),movie.getMovie_keyword(),a);
	         chuchen.addAll(jj);
	      }
	      m.addAttribute("chuchen", chuchen);

	      //로그인 여부에 따른 세션값
	      if(login_id == null||loginOrNot != true) {
	         hs.setAttribute("memberloginOrNot", false);
	         hs.setAttribute("login_id", "");
	         return "main_MovDetails";
	      }else if(loginOrNot == true){
	         hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", login_id);
	            hs.setMaxInactiveInterval(1200); //20분 후 로그아웃
	          //아이디로 찜여부 게시판 가져오기.
	          yes=srv.mvD_JimCheck(login_id,a);//로그인아이디랑 영화코드가지고 찜여부 파악하러가기
	          if(yes==1) {
	             yes=1;
	          }else {
	             yes=0;
	          }
	          m.addAttribute("like", yes);
	          m.addAttribute("nowID", login_id);
	            //로그인된 경우에 찜여부 가져오고
	          
	          //리턴하기전에 보내야할 것.
	          /*영화전체정보(movie) -> 완료
	           * 상영중(nowNew)      -> 완료
	           * 찜여부(yes) like  -> 완료
	           * 아이디(now-id)    -> 완료
	           * 추천영화(chuchen) -> 완료*/
	            return "main_MovDetails";
	      }else {
	         hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", "");
	         return "main_MovDetails";
	      }//로그인 여부
	   }//영화 상세보기
	
	//별점 로그인여부
	@ResponseBody
	@RequestMapping(value="/star_checkLogin")
	public String star_checkLogin(HttpSession hs) {
		String login_id = (String) hs.getAttribute("login_id");
		Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");
		if (login_id != null && loginOrNot == true ) {
			hs.setMaxInactiveInterval(1200); //20분 후 로그아웃
	        return "success";
	    } else {
	        return "fail";
	    }//로그인여부 파악 if문
	}//별점 달 권한 확인(로그인여부)
	
	//별점 입력 처음인지 확인
	@ResponseBody
	@RequestMapping(value="/star_checkAgain")
	public String star_checkAgain(HttpSession hs,HttpServletRequest hr) {
		String login_id = (String) hs.getAttribute("login_id");
		int code=Integer.parseInt(hr.getParameter("cd"));
		hs.setMaxInactiveInterval(1200); //20분 후 로그아웃
		MvService sv=ss.getMapper(MvService.class);
		int a=sv.doubleStar(code,login_id);
		if(a==0) {
	        return "success";
	    } else {
	        return "fail";
	    }//로그인여부 파악 if문
	}//별점 달 권한 확인(로그인여부)
	
	//평점 게시판
	@RequestMapping(value="/main_StarRatOUT")
	public String main_StarRatOUT(HttpSession hs,HttpServletRequest request,Model m
	,PageDTO pd,@RequestParam("now") int now,@RequestParam("check") String check) {
		String pageHere=request.getParameter("now");
		MvService srv=ss.getMapper(MvService.class);
		int a=(Integer)hs.getAttribute("movie_codeNum");
		int tt=srv.mvStarCnt(a);
		int pic=4;
		if (pageHere==null || pageHere.isEmpty() || pageHere.equals(null)) {
			now = 1;
		} else {
			now = Integer.parseInt(pageHere);
		}
		pd=new PageDTO(tt, now, pic);
		m.addAttribute("pg", pd);
		m.addAttribute("movie_codeNum", a);
		pd.setEndPage(pd.getLastPage());
		//이거 페이징에 있는데 왜 안 처리되어서 이중 코딩 시키냐 진짜
		hs.setMaxInactiveInterval(1200); //로그인이 아닐 경우 그 코드를 20분만 가지고 있을 거야.

		if(check==null) {

			ArrayList<MvStarDTO> star=srv.starOutNEW(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_new";
		}else if(check.equals("new")) {
			ArrayList<MvStarDTO> star=srv.starOutNEW(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_new";
		}else if(check.equals("like")) {
			ArrayList<MvStarDTO> star=srv.starOutGOOD(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_like";
		
		}else {
			ArrayList<MvStarDTO> star=srv.starOutNEW(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_new";
		}
	}//평점 게시판
	
	//평점게시판 페이징처리
		@ResponseBody
		@RequestMapping(value="/starPaging")
		public String starPaging(HttpSession hs
, HttpServletRequest request,@RequestParam("now") int now, @RequestParam("x")String x) {
			String pageHere=request.getParameter("now");
			x=request.getParameter("x"); //x는 new like me를 정해주는 객체;
			int movieCodeNum = (Integer)hs.getAttribute("movie_codeNum");
			MvService srv = ss.getMapper(MvService.class);
			int totalStarCnt = srv.mvStarCnt(movieCodeNum);
			int pic=4;
			if (pageHere==null || pageHere.isEmpty() || pageHere.equals(null)) {
					now = 1;
			} else {
				now = Integer.parseInt(pageHere);
			}
			PageDTO pd = new PageDTO(totalStarCnt, now, pic);
			int data=pd.getLastPage();
			return String.valueOf(data);
		}//평점 페이징

		
		@RequestMapping(value="/main_StarRatOUT_new")
		public String main_StarRatOUT_new(HttpSession hs,HttpServletRequest request,Model m,PageDTO pd) {
			String now,pic;
			now=request.getParameter("page_now");
			pic=request.getParameter("page_in_Content");
			MvService srv=ss.getMapper(MvService.class);
			int a=(Integer)hs.getAttribute("movie_codeNum");
			int tt=srv.mvStarCnt(a);
			if(now==null&&pic==null) {
				now="1";
				pic="4";
			}
			else if(now==null) {
				now="1";
			}
			else if(pic==null) {
				pic="4";
			}
			pd=new PageDTO(tt, Integer.parseInt(now), Integer.parseInt(pic));
			m.addAttribute("pg", pd);
			m.addAttribute("movie_codeNum", a);
			hs.setMaxInactiveInterval(1200); //로그인이 아닐 경우 그 코드를 20분만 가지고 있을 거야.
			ArrayList<MvStarDTO> star=srv.starOutNEW(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_new";
		}


	//추천
	@ResponseBody
	@RequestMapping(value="/star_recommendation")
	public String star_recommendation(int aa,HttpSession hs) {
		MemService srv=ss.getMapper(MemService.class);
		String login_id = (String) hs.getAttribute("login_id");
		if(login_id == null || login_id.isEmpty() || login_id.equals(null)) {
			
		}
		int countlike=srv.countlike(aa,login_id);
		String result="NO";
		System.out.println(login_id+result);
		if(countlike==1){
			return result;
		}else if(countlike==0){
			result="OK";
			srv.ilikeit(aa,login_id);
			srv.joayoUP(aa);
			return result;
		}else {
			return result;
		}
	}//추천하기
}//class

