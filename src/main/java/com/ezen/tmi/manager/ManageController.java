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


//�Ŵ���
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
	}//�α���
	
	@ResponseBody
	@RequestMapping(value="/adminLogin")
	public String adminLogin(HttpServletRequest request) {
		String no="no_manager";
		String a=request.getParameter("idpw");
		   //"mcheck"��ü�� json Ÿ������ �ڷᰡ �����ִ� ���´�
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
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		return no;
	}//���̵��й�ȣ ��ġ���� �ľ� Ajax
	
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
				hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
				return "redirect:manager_Mainpage";
			}else if(mgId.equals(aDTO.sid)&&mgPw.equals(aDTO.spw)) {
				hs.setAttribute("manager_id", mgId);
				hs.setAttribute("manager_pw", mgPw);
				hs.setAttribute("administrator_only", true);
				hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
				return "redirect:manager_Mainpage";
			}else {
				hs.setAttribute("administrator_only", false);
				return "redirect:manager_Login";
			}
		}
	}//�α��� ó�� �޼ҵ�
	
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
	}//������ ����������
	
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
	}//��ȭ���
	
	@ResponseBody
	@RequestMapping(value = "/MgMovCheck", method = RequestMethod.POST)
	public String MgMovCheck(HttpServletRequest request){
		String a=request.getParameter("mcheck");
		String fixMov=null;
		   //"mcheck"��ü�� json Ÿ������ �ڷᰡ �����ִ� ���´�
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
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		return fixMov;
	}//��ȭ ��� �ߺ��˻�
	
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
	                     }//g4�� ���� ��
	                  }//g4�� ���� �ƴ� ��
	               }//g3�� ���� ��
	            }//g3�� null�� �ƴ� ��
	         }//g2�� ���� ��
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
	   }//��� ��ȭ ����
	
	
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
	}//��ȭ ���
	
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "manager_MovDetails";
		}
	}//���� ��ȭ �󼼺���
	
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
				String [] aaa = new String[i]; // �� �迭 ����
			    System.arraycopy(aa, 0, aaa, 0, aa.length); // ���� �迭�� ���� �� �迭�� ����
			    aa = aaa; // �� �迭�� ���� �迭�� ��ü
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "movie_Modify";
		}
	}//���� ��ȭ �����ϱ�
	
	@ResponseBody
	@RequestMapping(value = "/MgMoviCheck", method = RequestMethod.POST)
	public String MgMoviCheck(HttpServletRequest request){
		String a=request.getParameter("mcheck");
		String fixMov=null;
		   //"mcheck"��ü�� json Ÿ������ �ڷᰡ �����ִ� ���´�
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
						fixMov="0";//��ġ�°� ����
					}else if(mv==1) {
						fixMov="1";//��ġ�� �� 1�� ����
					}else if(mv>=2) {
						fixMov="2";//��ġ�� �� 2�� �̻���. �����̶� �߳�����.
					}else {
						fixMov="E";
					}//�� �� ���� �����α��� :(
				}else if(me==1) {
					fixMov="ME";
				}else {
					fixMov="E";
				}
				
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		return fixMov;
	}//��ȭ ���� �ߺ��˻�
	
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "redirect:movie_Output";
		}
	}//��ȭ����
	
	@RequestMapping(value="/movie_Update", method = RequestMethod.POST)
	   public String movie_Update(MultipartHttpServletRequest mh) throws IllegalStateException, IOException {
	      String m1=mh.getParameter("mgMovie");
	      MultipartFile p=mh.getFile("mgPoster");
	      String m3=mh.getParameter("mgDirector");
	      String m4=mh.getParameter("mgActor");
	      String m5=mh.getParameter("mgReleasedate");
	      int m6=Integer.parseInt(mh.getParameter("mgRunningtime"));
	      //�帣
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
	   }//��� ���� ����
	
	/* ���*/
	
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
	}//��ȭ���
	
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
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		return fixDir;
	}//���� ��� �ߺ��˻�
	
	
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
	}//���� ����
	
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
	}//��ȭ ���
	
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "manager_DirDetails";
		}
	}//���� ���� �󼼺���
	
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "movieDir_Modi";
		}
	}//���� ����/����
	
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
			}catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		return fixDir;
	}//��ȭ ��� �ߺ��˻�
	
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
			hs.setMaxInactiveInterval(2400); //40�� �� �α׾ƿ�
			return "redirect:movie_Output";
		}
	}//��������
	
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
	}//���� ���� ����
	
	
	
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

	//ȸ������ ����¡ ���
	@RequestMapping(value = "/member_Output")
	public String member5(HttpServletRequest request,Model mo, PageDTO dto)
	{
		String nowPage=request.getParameter("nowPage");
	    String cntPerPage=request.getParameter("cntPerPage");
	    MgService notice = ss.getMapper(MgService.class);
	    //��ü ���ڵ� ��
	    int total=notice.cntnotice();
	    //�� �������� 10�� ��
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
	
	//ȸ�� Ż�� ��Ű��
	@ResponseBody
	@RequestMapping(value = "/mg_Delete")
		public String member6(HttpServletRequest request)
	{
		String thisid = request.getParameter("user_id");
		MgService mgs = ss.getMapper(MgService.class);
		mgs.memdelete(thisid);
		return "";

	}
	//���Ǳ� ��ü ����¡ ���
		@RequestMapping(value = "/manager_QnA_Out")
		public String mg3(HttpServletRequest request,Model mo, PageDTO dto)
		{
			String nowPage=request.getParameter("nowPage");
		    String cntPerPage=request.getParameter("cntPerPage");
		    MgService notice = ss.getMapper(MgService.class);
		    //��ü ���ڵ� ��
		    int total=notice.cntboard();
		    //�� �������� 10�� ��
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
	
	//���Ǳ� �ڼ��� ����
	@RequestMapping(value = "/mg_boardDetail")
	public String mg4(HttpServletRequest request, Model mo)
	{
		 int bo_num = Integer.parseInt(request.getParameter("bo_num"));
		 MgService ms = ss.getMapper(MgService.class);
		 MemberBoardDTO myb = ms.boarddetail(bo_num);
		 mo.addAttribute("myb", myb);
		 
		 //��� �ҷ�����
		 ArrayList<ReplyDTO> reply = ms.replyout(bo_num);
		 mo.addAttribute("reply",reply);
		return "manager_boardDetail";
	}	
	
	//���� �ٿ�ޱ�
	@RequestMapping(value = "/imgdownlod")
	public String mg5(HttpServletRequest request, Model mo ,HttpServletResponse response) throws IOException 
	{
		 // ÷�����ϸ��� ���� ������ ���� ��θ� ����
		 String bo_img =request.getParameter("bo_img");
		 String imagePath = (img_path+"\\QnAImg\\"+bo_img);
		 //���� ��ü ����
		 File file = new File(imagePath);
		 
		 //���� ����� �ٿ�ε��� ���� �� �����ϰ� �ٿ�ε� â �������� Content~�κ��� �ٿ�ε� â ���� �κ�
		 response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(bo_img, "UTF-8") + "\"");
		 
		 //�ٿ�ε� �� ���� ũ�� ���� : Ŭ���̾�Ʈ ������ ���� ������ ũ�⸦ �˰� �غ��� �� �ֵ��� �������
		 //-> ���� ���� �� ���ʿ��� ���ð��� �߻��ϰų�, �ջ� ���ɼ� ����. �ٿ� �ӵ�/������ ����
		 response.setContentLength((int)file.length());
		 
		 //���� �о����
		 FileInputStream fis = new FileInputStream(file);
		 //HTTP ���� �ƿ���Ʈ�� ����
		 OutputStream out = response.getOutputStream();
		 
		 //������ ������ 1024 byte�� �о�� ���� OutputStream�� ���鼭 ����(��뷮 ���� ���)
		 byte[] buffer = new byte[1024];
		    int length;
		    while ((length = fis.read(buffer)) > 0) {
		        out.write(buffer, 0, length);
		    }
		 //OutputStream�� ����ְ�, InputStream�� �ݱ�
		 //���ۿ� ����� �����͸� �����ϱ����� ��¹��� ����� > ���� �������ų� close()�޼ҵ� ȣ�� ������ Ŭ���̾�Ʈ�� ���� �ȵ�
		 //�ڿ��� �����ϱ� ���� ��Ʈ���� �ݾ������. ���� ���� �ܺ��ڿ��� ���ѵ� ������ŭ�� ��� ������.
		 //�ڿ��� �������� �ʰ� ���ܵθ� �޸𸮴����� �߻��� �� ���� > ��Ʈ���� ����� �Ŀ��� �ݵ�� close() ���ֱ�
		  out.flush();
		  out.close();
		  fis.close();
		  
		//������ �ٿ�ε��ϴ°� �� �����̱� ������ ��ȯ �� ������ 
		return "";
	}	
	
	//���Ǳ� ��� ����
	@RequestMapping(value = "/replysave")
	public String mg6(HttpServletRequest request)
	{
		 int bo_num = Integer.parseInt(request.getParameter("bo_num"));
	 	 String re_content = request.getParameter("re_content");		 		 
		 MgService ms = ss.getMapper(MgService.class);
		 ms.replyinsert(bo_num, re_content);			 
		 //��� �� ����
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
	   }//��ȭ �˻�
	   
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
	   }//�����˻�
}














