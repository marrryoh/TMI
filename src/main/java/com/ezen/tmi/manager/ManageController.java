package com.ezen.tmi.manager;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.ezen.tmi.member.MemberBoardDTO;


//매니저
@Controller
public class ManageController {
	public	static	String img_path="C:\\Users\\3-2\\git\\repository\\TMI\\src\\main\\webapp\\imgsave";

	@Autowired
	SqlSession ss;
	
	@RequestMapping(value="/manager_Login")
	public String manager_Login(HttpServletRequest request) {
		HttpSession hs=request.getSession();
	    String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");

		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "manager_Login";
		}else {
			hs.setAttribute("administrator_only", true);
			return "redirect:manager_Mainpage";
		}
	}//로그인
	
	@ResponseBody
	@RequestMapping(value="/adminLogin")
	public String adminLogin(HttpServletRequest request) {
		String no="no_manager";
		String a=request.getParameter("idpw");
		   //"mcheck"객체는 json 타입으로 자료가 묶여있는 상태다
			JSONParser jp=new JSONParser();
			try{
				JSONObject joj=(JSONObject)jp.parse(a);
				String id=(String)joj.get("mgId");
				String pw=(String)joj.get("mgPw");
				MgAdmin_DTO aDTO=new MgAdmin_DTO();
				if(id.equals(aDTO.id)&&pw.equals(aDTO.pw)) {
					no="1";
					return no;
				}else if(id.equals(aDTO.sid)&&pw.equals(aDTO.spw)) {
					no="1";
					return no;
				}else {
					no="2";
					return no;
				}
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch문
		return no;
	}//아이디비밀번호 일치여부 파악 Ajax
	
	@RequestMapping(value="/managerLogin_Actionpage", method = RequestMethod.POST)
	public String managerLogin_Actionpage(HttpServletRequest request,RedirectAttributes ra) {
		String mgId,mgPw;
		mgId=request.getParameter("id");
		if(mgId==null) {
			ra.addAttribute("result", "no_Admin");
			return "redirect:manager_Login";
		}
		else {
			HttpSession hs=request.getSession();
			mgPw=request.getParameter("pw");
			MgAdmin_DTO aDTO=new MgAdmin_DTO();
			if(mgId.equals(aDTO.id)&&mgPw.equals(aDTO.pw)) {
				hs.setAttribute("manager_id", mgId);
				hs.setAttribute("manager_pw", mgPw);
				hs.setAttribute("administrator_only", true);
				hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
				return "redirect:manager_Mainpage";
			}else if(mgId.equals(aDTO.sid)&&mgPw.equals(aDTO.spw)) {
				hs.setAttribute("manager_id", mgId);
				hs.setAttribute("manager_pw", mgPw);
				hs.setAttribute("administrator_only", true);
				hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
				return "redirect:manager_Mainpage";
			}else {
				hs.setAttribute("administrator_only", false);
				return "redirect:manager_Login";
			}
		}
	}//로그인 처리 메소드
	
	@RequestMapping(value="/manager_Mainpage")
	public String manager_Mainpage(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}else {
			boolean flag=(Boolean)hs.getAttribute("administrator_only");
			if(flag) {
				return "manager_Mainpage";
			}
			else {
				return "redirect:home";}
		}
	}//관리자 메인페이지
	
	@RequestMapping(value = "/movie_Input")
	public String movie_Input(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}else {
			return "movie_Input";
		}
	}//영화등록
	
	@ResponseBody
	@RequestMapping(value = "/MgMovCheck", method = RequestMethod.POST)
	public String MgMovCheck(HttpServletRequest request){
		String a=request.getParameter("mcheck");
		String fixMov=null;
		   //"mcheck"객체는 json 타입으로 자료가 묶여있는 상태다
			JSONParser jp=new JSONParser();
			try{
				JSONObject joj=(JSONObject)jp.parse(a);
				String mvName=(String)joj.get("movie_ch");
				String mvDir=(String)joj.get("director_ch");
				MgService msrv=ss.getMapper(MgService.class);
				int mv=msrv.mvCheck(mvName,mvDir);
				if(mv==0) {
					fixMov="0";
				}
				else if(mv==1) {
					fixMov="1";
				}
				else {
					fixMov="2";
				}
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch문
		return fixMov;
	}//영화 등록 중복검사
	
	@RequestMapping(value="/MgMovSave", method = RequestMethod.POST)
	   public String MgMovSave(MultipartHttpServletRequest mh) throws IllegalStateException, IOException {
	      String m1=mh.getParameter("mgMovie");
	      MultipartFile p=mh.getFile("mgPoster");
	      String m3=mh.getParameter("mgDirector");
	      String m4=mh.getParameter("mgActor");
	      String m5=mh.getParameter("mgReleasedate");
	      int m6=Integer.parseInt(mh.getParameter("mgRunningtime"));
	      String g1=mh.getParameter("mgGenre_s1");
	      String gg2=mh.getParameter("mgGenre_s2");
	      String gg3=mh.getParameter("mgGenre_s3");
	      String gg4=mh.getParameter("mgGenre_s4");
	      String m7=g1;
	      String g2=","+gg2;
	      String g3=","+gg3;
	      String g4=","+gg4;
	      if (gg2!=null) {
	         if(!gg2.equals("null") || !gg2.equals("")||!gg2.equals(" ")) {
	            m7=g1+g2;
	            if(gg3!=null) {
	               if(!gg3.equals("null") || !gg3.equals("")||!gg3.equals(" ")) {
	                  m7= g1+ g2+ g3;
	                  if (gg4!=null) {
	                     if(!gg4.equals("null") || !gg4.equals("")||!gg4.equals(" ")) {
	                        m7 = g1 + g2 + g3 + g4;
	                     }//g4가 있을 때
	                  }//g4가 눌이 아닐 때
	               }//g3이 있을 때
	            }//g3이 null이 아닐 때
	         }//g2가 있을 때
	      }else {m7=g1;}
	      String m8=mh.getParameter("mgKeyword"); 
	      String m9=mh.getParameter("mgPlot");
	      MgService msrv=ss.getMapper(MgService.class);
	      String m2=p.getOriginalFilename();
	      p.transferTo(new File(img_path+"\\movieImg\\"+m2));
	      int m10=Integer.parseInt(mh.getParameter("mgGroup"));
	      String m11=mh.getParameter("mgLink");
	      String m12=mh.getParameter("mgReserve");
	      if(m12==null) {
	         m12="https://www.cgv.co.kr/";
	      }
	      msrv.movin(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12);
	      return "redirect:movie_Input";
	   }//등록 영화 저장
	
	
	@RequestMapping(value="/movie_Output")
	public String movie_Output(HttpServletRequest request, Model m, PageDTO pd) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		boolean flag=administrator_only;
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}else if(flag) {
			String now,pic;
			now=request.getParameter("nowPage");
			pic=request.getParameter("page_in_Content");
			MgService msrv=ss.getMapper(MgService.class);
			int tt=msrv.movPageCnt();
			if(now==null&&pic==null) {
				now="1";
				pic="5";
			}
			else if(now==null) {
				now="1";
			}
			else if(pic==null) {
				pic="5";
			}
			pd=new PageDTO(tt, Integer.parseInt(now), Integer.parseInt(pic));
			m.addAttribute("out", msrv.movout(pd));
			m.addAttribute("pg", pd);	
			return "movie_Output";
		}
		else {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
	}//영화 출력
	
	@RequestMapping(value = "/manager_MovDetails")
	public String manager_MovDetails(HttpServletRequest request, Model m) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String movie_code= request.getParameter("a");
			MgService msrv=ss.getMapper(MgService.class);
			
			
			
			MgMovie_DTO mto=msrv.movDetail(movie_code);
			m.addAttribute("mto", mto);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "manager_MovDetails";
		}
	}//관리 영화 상세보기
	
	@RequestMapping(value = "/movie_Modi")
	public String movie_Modify(HttpServletRequest request, Model m) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String movie_code= request.getParameter("a");
			MgService msrv=ss.getMapper(MgService.class);
			MgMovie_DTO mto=msrv.movDetail(movie_code);
			String a = mto.getMovie_jenre();
			String [] aa= a.split(",");
			int i=4;
			if(aa.length<i) {
				String [] aaa = new String[i]; // 새 배열 생성
			    System.arraycopy(aa, 0, aaa, 0, aa.length); // 기존 배열의 값을 새 배열로 복사
			    aa = aaa; // 새 배열로 기존 배열을 대체
			}
			String g1 = null,g2 = null ,g3 = null,g4 = null;
			g1=aa[0];
			g2=aa[1];
			g3=aa[2];
			g4=aa[3];
			m.addAttribute("modi", mto);
			m.addAttribute("a", g1);
			m.addAttribute("b", g2);
			m.addAttribute("c", g3);
			m.addAttribute("d", g4);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "movie_Modify";
		}
	}//관리 영화 수정하기
	
	@ResponseBody
	@RequestMapping(value = "/MgMoviCheck", method = RequestMethod.POST)
	public String MgMoviCheck(HttpServletRequest request){
		String a=request.getParameter("mcheck");
		String fixMov=null;
		   //"mcheck"객체는 json 타입으로 자료가 묶여있는 상태다
			JSONParser jp=new JSONParser();
			try{
				JSONObject joj=(JSONObject)jp.parse(a);
				String mvName=(String)joj.get("movie_ch");
				String mvDir=(String)joj.get("director_ch");
				String mvCode=(String)joj.get("code");
				MgService msrv=ss.getMapper(MgService.class);
				int me=msrv.mvChkMe(mvCode);
				int mv=msrv.mvMcheck(mvName,mvDir,mvCode);
				if(me==0) {
					if(mv==0) {
						fixMov="0";//겹치는거 없음
					}else if(mv==1) {
						fixMov="1";//겹치는 거 1개 있음
					}else if(mv>=2) {
						fixMov="2";//겹치는 게 2개 이상임. 실험이라도 했나보지.
					}else {
						fixMov="E";
					}//알 수 없는 에러로구만 :(
				}else if(me==1) {
					fixMov="ME";
				}else {
					fixMov="E";
				}
				
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch문
		return fixMov;
	}//영화 수정 중복검사
	
	@RequestMapping(value="/movie_Del")
	public String movie_Del(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		if(hs.getAttribute("manager_id")==null) {
		hs.setAttribute("administrator_only",false);
		return "home";}String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String movie_code= request.getParameter("a");
			MgService msrv=ss.getMapper(MgService.class);
			msrv.movDel(movie_code);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "redirect:movie_Output";
		}
	}//영화삭제
	
	@RequestMapping(value="/movie_Update", method = RequestMethod.POST)
	   public String movie_Update(MultipartHttpServletRequest mh) throws IllegalStateException, IOException {
	      String m1=mh.getParameter("mgMovie");
	      MultipartFile p=mh.getFile("mgPoster");
	      String m3=mh.getParameter("mgDirector");
	      String m4=mh.getParameter("mgActor");
	      String m5=mh.getParameter("mgReleasedate");
	      int m6=Integer.parseInt(mh.getParameter("mgRunningtime"));
	      //장르
	      String g1=mh.getParameter("mgGenre_s1");
	      String gg2=mh.getParameter("mgGenre_s2");
	      String gg3=mh.getParameter("mgGenre_s3");
	      String gg4=mh.getParameter("mgGenre_s4");	      
	      String g2=","+gg2;
	      String g3=","+gg3;
	      String g4=","+gg4;
	      StringBuilder sb = new StringBuilder();
	      sb.append(g1);
	      if(gg2!=null) {
	    	  if(!gg2.equals("")) {
	    		  sb.append(g2);  
	    	  }
	      }
	      if(gg3!=null) {
	    	  if(!gg3.equals("")) {
	    		  sb.append(g3);  
	    	  }
	      }
	      if(gg4!=null) {
	    	  if(!gg4.equals("")) {
	    		  sb.append(g4);  
	    	  }	         
	      }
	      String m7 = sb.toString();
	      String m8=mh.getParameter("mgKeyword"); 
	      String m9=mh.getParameter("mgPlot");
	      MgService msrv=ss.getMapper(MgService.class);
	      String m2=p.getOriginalFilename();
	      p.transferTo(new File(img_path+"\\movieImg\\"+m2));
	      int m10=Integer.parseInt(mh.getParameter("mgGroup"));
	      String m11=mh.getParameter("mgLink");
	      String m12=mh.getParameter("mgReserve");
	      int m13=Integer.parseInt(mh.getParameter("mgMovCode"));
	      msrv.movUpdate(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13);
	      return "redirect:movie_Output";
	   }//등록 수정 저장
	
	/* 배우*/
	
	@RequestMapping(value = "/movieDir_Input")
	public String movieDir_Input(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}else {
			return "movieDir_Input";
		}
	}//영화등록
	
	@ResponseBody
	@RequestMapping(value = "/MgDirCheck", method = RequestMethod.POST)
	public String MgDirCheck(HttpServletRequest request){
		String a=request.getParameter("dirChck");
		String fixDir="0";
			JSONParser jp=new JSONParser();
			try{
				JSONObject joj=(JSONObject)jp.parse(a);
				String dirName=(String)joj.get("a");
				String dirBirthday=(String)joj.get("b");
				MgService msrv=ss.getMapper(MgService.class);
				int dir=msrv.dirCheck(dirName,dirBirthday);
				if(dir==0) {
					fixDir="0";
				}
				else if(dir==1) {
					fixDir="1";
				}
				else {
					fixDir="2";
				}
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch문
		return fixDir;
	}//감독 등록 중복검사
	
	
	@RequestMapping(value="/MgDirSave", method = RequestMethod.POST)
	public String MgDirSave(MultipartHttpServletRequest mh) throws IllegalStateException, IOException {
		String d1=mh.getParameter("mgDir_name");
		MultipartFile p=mh.getFile("mgDir_pic");
		String d2=mh.getParameter("mgDir_day");
		String d3=mh.getParameter("mgDir_aff");
		String d4=mh.getParameter("mgDir_debut");
		String d5=mh.getParameter("mgDir_info");
		String d6=p.getOriginalFilename();
		p.transferTo(new File(img_path+"\\dirImg\\"+d6));
		MgService dsrv=ss.getMapper(MgService.class);
		dsrv.dirin(d1,d2,d3,d4,d5,d6);
		return "redirect:movieDir_Input";
	}//감독 저장
	
	@RequestMapping(value="/movieDir_Output")
	public String movieDir_Output(HttpServletRequest request, Model m, PageDTO pd) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		boolean flag=administrator_only;
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}else if(flag) {
			String now,pic;
			now=request.getParameter("page_now");
			pic=request.getParameter("page_in_Content");
			MgService dsrv=ss.getMapper(MgService.class);
			int tt=dsrv.movPageCnt();
			if(now==null&&pic==null) {
				now="1";
				pic="10";
			}
			else if(now==null) {
				now="1";
			}
			else if(pic==null) {
				pic="10";
			}
			pd=new PageDTO(tt, Integer.parseInt(now), Integer.parseInt(pic));
			m.addAttribute("Dir", dsrv.dirout(pd));
			m.addAttribute("pg", pd);
			return "movieDir_Output";
		}
		else {
			return "redirect:home";}
	}//영화 출력
	
	@RequestMapping(value = "/manager_DirDetails")
	public String manager_DirDetails(HttpServletRequest request, Model m) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String dir_code= request.getParameter("a");
			MgService dsrv=ss.getMapper(MgService.class);
			MgDirector_DTO dto=dsrv.dirDetail(dir_code);
			m.addAttribute("dto", dto);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "manager_DirDetails";
		}
	}//관리 감독 상세보기
	
	@RequestMapping(value = "/movieDir_Modi")
	public String movieDir_Modi(HttpServletRequest request, Model m) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String dir_code= request.getParameter("a");
			MgService dsrv=ss.getMapper(MgService.class);
			MgDirector_DTO dto=dsrv.dirDetail(dir_code);
			m.addAttribute("modi", dto);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "movieDir_Modi";
		}
	}//감독 수정/삭제
	
	@ResponseBody
	@RequestMapping(value = "/mgDic_Chck", method = RequestMethod.POST)
	public String mgDic_Chck(HttpServletRequest request){
		String a=request.getParameter("dirChck");
		String fixDir="0";
			JSONParser jp=new JSONParser();
			try{
				JSONObject joj=(JSONObject)jp.parse(a);
				String dirName=(String)joj.get("a");
				String dirBirthday=(String)joj.get("b");
				String dirCode=(String)joj.get("c");
				MgService dsrv=ss.getMapper(MgService.class);
				int dir1=dsrv.dirMe(dirCode);
				if(dir1==0) {
					int dir2=dsrv.dirChck(dirName,dirBirthday,dirCode);
					if(dir2==0) {
						fixDir="0";
					}else if(dir2==1) {
						fixDir="1";						
					}else if(dir2>=2) {
						fixDir="2";
					}else {
						fixDir="E";
					}
				}else if(dir1==1){
					fixDir="ME";					
				}else {
					fixDir="E";
				}
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch문
		return fixDir;
	}//영화 등록 중복검사
	
	@RequestMapping(value="/movieDir_Del")
	public String movieDir_Del(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		String manager_id = (String) hs.getAttribute("manager_id");
	    Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
		if(manager_id == null||administrator_only != true) {
			hs.setAttribute("administrator_only", false);
			return "redirect:home";
		}
		else {
			String dir_code= request.getParameter("a");
			MgService dsrv=ss.getMapper(MgService.class);
			dsrv.dirDel(dir_code);
			hs.setAttribute("administrator_only", true);
			hs.setMaxInactiveInterval(2400); //40분 후 로그아웃
			return "redirect:movie_Output";
		}
	}//감독삭제
	
	@RequestMapping(value="/MgDirUpdate", method = RequestMethod.POST)
	public String MgDirUpdate(MultipartHttpServletRequest mh) throws IllegalStateException, IOException {
		String d1=mh.getParameter("mgDir_name");
		MultipartFile p=mh.getFile("mgDir_pic");
		String d2=mh.getParameter("mgDir_day");
		String d3=mh.getParameter("mgDir_aff");
		String d4=mh.getParameter("mgDir_debut");
		String d5=mh.getParameter("mgDir_info");
		String d6=p.getOriginalFilename();
		p.transferTo(new File(img_path+"\\dirImg\\"+d6));
		MgService dsrv=ss.getMapper(MgService.class);
		int d7=Integer.parseInt(mh.getParameter("mgDir_code"));
		dsrv.dirUp(d1,d2,d3,d4,d5,d6,d7);
		return "redirect:movieDir_Output";
	}//감독 정보 수정
	
	
	
	@RequestMapping(value="/member_Sample")
	public String member_Sample() {
		return "member_Sample";
	}
	
	@RequestMapping(value="/manager_Logout")
	public String manager_Logout(HttpServletRequest request) {
		HttpSession hs=request.getSession();
		hs.invalidate(); 
		return "home";
	}

	//회원정보 페이징 출력
	@RequestMapping(value = "/member_Output")
	public String member5(HttpServletRequest request,Model mo, PageDTO dto)
	{
		String nowPage=request.getParameter("nowPage");
	    String cntPerPage=request.getParameter("cntPerPage");
	    MgService notice = ss.getMapper(MgService.class);
	    //전체 레코드 수
	    int total=notice.cntnotice();
	    //한 페이지에 10개 씩
	      if(nowPage==null && cntPerPage == null) {
	         nowPage="1";
	         cntPerPage="10";
	      }
	      else if(nowPage==null) {
	         nowPage="1";
		  }
	      else if(cntPerPage==null) {
	    	 cntPerPage="10";
		  }      
		   	 dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		     mo.addAttribute("paging",dto);
		     mo.addAttribute("list",notice.selectnotice(dto));
			return "member_Output";
		}
	
	//회원 탈퇴 시키기
	@ResponseBody
	@RequestMapping(value = "/mg_Delete")
		public String member6(HttpServletRequest request)
	{
		String thisid = request.getParameter("user_id");
		MgService mgs = ss.getMapper(MgService.class);
		mgs.memdelete(thisid);
		return "";

	}
	//문의글 전체 페이징 출력
		@RequestMapping(value = "/manager_QnA_Out")
		public String mg3(HttpServletRequest request,Model mo, PageDTO dto)
		{
			String nowPage=request.getParameter("nowPage");
		    String cntPerPage=request.getParameter("cntPerPage");
		    MgService notice = ss.getMapper(MgService.class);
		    //전체 레코드 수
		    int total=notice.cntboard();
		    //한 페이지에 10개 씩
		      if(nowPage==null && cntPerPage == null) {
		         nowPage="1";
		         cntPerPage="10";
		      }
		      else if(nowPage==null) {
		         nowPage="1";
			  }
		      else if(cntPerPage==null) {
		    	 cntPerPage="10";
			  }      
			   	 dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
			     mo.addAttribute("paging",dto);
			     mo.addAttribute("list",notice.selectboard(dto));
				return "manager_QnA_Out";
			}	
	
	//문의글 자세히 보기
	@RequestMapping(value = "/mg_boardDetail")
	public String mg4(HttpServletRequest request, Model mo)
	{
		 int bo_num = Integer.parseInt(request.getParameter("bo_num"));
		 MgService ms = ss.getMapper(MgService.class);
		 MemberBoardDTO myb = ms.boarddetail(bo_num);
		 mo.addAttribute("myb", myb);
		 
		 //댓글 불러오기
		 ArrayList<ReplyDTO> reply = ms.replyout(bo_num);
		 mo.addAttribute("reply",reply);
		return "manager_boardDetail";
	}	
	
	//파일 다운받기
	@RequestMapping(value = "/imgdownlod")
	public String mg5(HttpServletRequest request, Model mo ,HttpServletResponse response) throws IOException 
	{
		 // 첨부파일명을 값을 가져와 파일 경로를 설정
		 String bo_img =request.getParameter("bo_img");
		 String imagePath = (img_path+"\\QnAImg\\"+bo_img);
		 //파일 객체 생성
		 File file = new File(imagePath);
		 
		 //응답 헤더에 다운로드할 파일 명 설정하고 다운로드 창 열도록함 Content~부분이 다운로드 창 여는 부분
		 response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(bo_img, "UTF-8") + "\"");
		 
		 //다운로드 할 파일 크기 설정 : 클라이언트 측에서 받을 파일의 크기를 알고 준비할 수 있도록 해줘야함
		 //-> 설정 안할 시 불필요한 대기시간이 발생하거나, 손상 가능성 있음. 다운 속도/안정성 위함
		 response.setContentLength((int)file.length());
		 
		 //파일 읽어오기
		 FileInputStream fis = new FileInputStream(file);
		 //HTTP 응답 아웃스트림 생성
		 OutputStream out = response.getOutputStream();
		 
		 //파일의 내용을 1024 byte씩 읽어와 응답 OutputStream에 쓰면서 전송(대용량 파일 대비)
		 byte[] buffer = new byte[1024];
		    int length;
		    while ((length = fis.read(buffer)) > 0) {
		        out.write(buffer, 0, length);
		    }
		 //OutputStream을 비워주고, InputStream을 닫기
		 //버퍼에 저장된 데이터를 전송하기위해 출력버퍼 비워줌 > 버퍼 가득차거나 close()메소드 호출 전까지 클라이언트에 전송 안됨
		 //자원을 해제하기 위해 스트림을 닫아줘야함. 파일 같은 외부자원은 제한된 개수만큼만 사용 가능함.
		 //자원을 해제하지 않고 남겨두면 메모리누수가 발생할 수 있음 > 스트림을 사용한 후에는 반드시 close() 해주기
		  out.flush();
		  out.close();
		  fis.close();
		  
		//파일을 다운로드하는게 주 목적이기 때문에 반환 값 생략함 
		return "";
	}	
	
	//문의글 댓글 저장
	@RequestMapping(value = "/replysave")
	public String mg6(HttpServletRequest request)
	{
		 int bo_num = Integer.parseInt(request.getParameter("bo_num"));
	 	 String re_content = request.getParameter("re_content");		 		 
		 MgService ms = ss.getMapper(MgService.class);
		 ms.replyinsert(bo_num, re_content);			 
		 //댓글 수 증가
		 ms.oxcnt(bo_num);
		return "redirect:/mg_boardDetail?bo_num="+bo_num;
	}	
	@RequestMapping(value="/MgmvSearch")
	   public String MgmvSearch(HttpServletRequest request, Model m, PageDTO pd) {
	      HttpSession hs=request.getSession();
	      String manager_id = (String) hs.getAttribute("manager_id");
	       Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
	      if(administrator_only == null) {
	         administrator_only=false;
	      }
	      boolean flag=administrator_only;
	      if(manager_id == null||administrator_only != true) {
	         hs.setAttribute("administrator_only", false);
	         return "redirect:home";
	      }else if(flag) {
	         String now,pic;
	         now=request.getParameter("page_now");
	         pic=request.getParameter("page_in_Content");
	         MgService msrv=ss.getMapper(MgService.class);
	         int tt=msrv.movPageCnt();
	         if(now==null&&pic==null) {
	            now="1";
	            pic="5";
	         }
	         else if(now==null) {
	            now="1";
	         }
	         else if(pic==null) {
	            pic="5";
	         }
	         pd=new PageDTO(tt, Integer.parseInt(now), Integer.parseInt(pic));
	         int start=pd.getStart();
	         int end=pd.getEnd();
	         String jenre=null;
	         int st=0;
	         System.out.println("1");
	         jenre=request.getParameter("jenre");
	         System.out.println("2");
	         st=Integer.parseInt(request.getParameter("state"));
	         System.out.println("3");
	         if(jenre!=null&&st==0) {
	            System.out.println("4");
	            m.addAttribute("out", msrv.mvSearchJ(jenre,start, end));
	         }else if(jenre==null&&st!=0) {
	            System.out.println("5");
	            m.addAttribute("out", msrv.mvSearchS(st,start, end));
	         }
	         m.addAttribute("pg", pd);
	         return "movie_Output";
	      }
	      else {
	         hs.setAttribute("administrator_only", false);
	         return "redirect:home";
	      }
	   }//영화 검색
	   
	   @RequestMapping(value = "/MgdirSearch")
	   public String MgdirSearch(HttpServletRequest request, Model m,PageDTO pd) {
	      HttpSession hs=request.getSession();
	      String manager_id = (String) hs.getAttribute("manager_id");
	       Boolean administrator_only = (Boolean) hs.getAttribute("administrator_only");
	      boolean flag=administrator_only;
	      if(administrator_only == null) {
	         administrator_only=false;
	      }
	      if(manager_id == null||administrator_only != true) {
	         hs.setAttribute("administrator_only", false);
	         return "redirect:home";
	      }else if(flag) {
	         String now,pic;
	         now=request.getParameter("page_now");
	         pic=request.getParameter("page_in_Content");
	         MgService dsrv=ss.getMapper(MgService.class);
	         int tt=dsrv.movPageCnt();
	         if(now==null&&pic==null) {
	            now="1";
	            pic="10";
	         }
	         else if(now==null) {
	            now="1";
	         }
	         else if(pic==null) {
	            pic="10";
	         }
	         pd=new PageDTO(tt, Integer.parseInt(now), Integer.parseInt(pic));
	         int start=pd.getStart();
	         int end=pd.getEnd();
	         String dir=request.getParameter("dir");
	         m.addAttribute("Dir", dsrv.dirSearch(dir,start,end));
	         
	         m.addAttribute("pg", pd);
	         return "movieDir_Output";
	      }
	      else {
	         return "redirect:home";}
	   }//감독검색
}














