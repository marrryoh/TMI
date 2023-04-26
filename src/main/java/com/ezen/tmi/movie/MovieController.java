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

//��ȭ
@Controller
public class MovieController {
	
	@Autowired
	SqlSession ss;
	
	//��ȭ �� �˻�
	@RequestMapping(value = "/mainSearchsave")
	public String ms1(HttpServletRequest request, Model mo)
	{
		String svalue = request.getParameter("svalue");
	    MvService ms = ss.getMapper(MvService.class); 
	    ArrayList<MgMovie_DTO> list;
	    //��ü ���ڵ� ��
	    int total = ms.getTotal(svalue); 
	    mo.addAttribute("svalue", svalue);
	    mo.addAttribute("totcnt", total);
	    
	    // �˻�� null�� �ƴϰ� ��ĭ�� �ƴ� ��쿡�� ����
	    if (svalue != null && !svalue.isEmpty()) { 
	        //�˻��� ����, �˻��� �߰�
	        ms.searchcnt(svalue);
	    }
	    //��ȭ ������ 300�� �̳��� �ڸ���, �� �ٲ� ����
	    list = ms.pagePerList(svalue);
	    for (MgMovie_DTO movie : list) {
	        String plot = movie.getMovie_plot();
	        if (plot != null && plot.length() > 300) {
	            plot = plot.substring(0, 300) + " ..."; // 150�ڱ����� ����ϰ� "..." �߰�
	        }
	        plot = plot.replace("<br>", "").replace("\n", ""); // �ٹٲ� ����
	        movie.setMovie_plot(plot);
	    }
	    mo.addAttribute("list", list);

	    return "main_SearchOut";
	   }
	
	//�˻��� ���
	@RequestMapping(value = "/mainSearchRank")
	public String ms2(Model mo)
	{
		 MvService ms = ss.getMapper(MvService.class); 
		 ArrayList<SearchDTO> sresult = ms.sresult();
		 Collections.sort(sresult,new Comparator<SearchDTO>() {
			 public int compare(SearchDTO s1, SearchDTO s2) 
			 {
				 return s2.getSearch_cnt() - s1.getSearch_cnt(); // ������������ ����
			 }		 
		 });
		 List<SearchDTO> top5 = sresult.subList(0, Math.min(sresult.size(), 5)); // ���� 5��
		 mo.addAttribute("sresult", top5);	 
		return "main_Side";
	}
	
	@RequestMapping(value = "/movieSearchstate")
	public String movieSearchstate(HttpServletRequest request, Model mo){
		int state = Integer.parseInt(request.getParameter("svalue"));
		String svalue="�ѱ���ȭ";
		switch (state) {
		case 1: svalue="�ѱ���ȭ";	break;
		case 2: svalue="�ƽþ�";	break;
		case 3: svalue="�Ƹ޸�ī";	break;
		case 4: svalue="����";	break;
		case 5: svalue="������ī";	break;
		case 6: svalue="�ߵ�";	break;
		case 7: svalue="�����ƴϾ�";	break;
		default:
			svalue="";
			break;
		}
		MvService ms = ss.getMapper(MvService.class);
		ArrayList<MgMovie_DTO> list;
		//��ü ���ڵ� ��
		int total = ms.searchtt(state);
		mo.addAttribute("svalue", svalue);
		mo.addAttribute("totcnt", total);
		//��ȭ ������ 150�� �̳��� �ڸ���, �� �ٲ� ����
		list = ms.stateSearch(state);
		for (MgMovie_DTO movie : list) {
			String plot = movie.getMovie_plot();
			if (plot != null && plot.length() > 300) {
				plot = plot.substring(0, 300) + " ..."; // 150�ڱ����� ����ϰ� "..." �߰�
			}
			plot = plot.replace("<br>", "").replace("\n", ""); // �ٹٲ� ����
			movie.setMovie_plot(plot);
		}
		mo.addAttribute("list", list);
		return "main_SearchOut";
	}//������ �˻�
	
	
	//��ȭ �󼼺���
	@RequestMapping(value = "/main_MovDetails")
	   public String main_MovDetails(HttpServletRequest request, Model m) {
	      HttpSession hs=request.getSession();
	      String login_id = (String) hs.getAttribute("login_id");
	      Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");
	      
	      int a=Integer.parseInt(request.getParameter("a"));//���δ��� ������ �ڵ�
	      hs.setAttribute("movie_codeNum", a); //������ ������ ������ movie_codeNum�� �����ϱ�.
	      hs.setMaxInactiveInterval(600); //�α����� �ƴ� ��� �� �ڵ带 10�и� ������ ���� �ž�.
	      MvService srv=ss.getMapper(MvService.class);
	      MgMovie_DTO movie=srv.mvDetail(a);//��ȭ��ü���� ��������
	      m.addAttribute("mvDTO", movie);//����Ұž�. �״����� ���Ϸ����ߴ���.
	      if(movie.getMovie_new()==null) {
	         m.addAttribute("nowNew", false);
	      }else if(movie.getMovie_new().equals("����")) {
	         m.addAttribute("nowNew", true);
	      }else {
	         m.addAttribute("nowNew", false);
	      }
	      int yes=0;
	      m.addAttribute("like", yes);
	      //������ ��ü
	            /*1. movie (��ȭ ���� ��ü)
	             *2. �򿩺� 
	             *3. ���� �Խ����� ��Ŭ���ϱ� ���� �� �ʿ�������.
	             *4. ��õ��ȭ
	             * ���̵� ���� �������� �ʿ���� */
	      int jnk=srv.jenreNkey(movie.getMovie_jenre(),movie.getMovie_keyword());
	      ArrayList<MgMovie_DTO> chuchen=srv.ccMovie(movie.getMovie_jenre(),movie.getMovie_keyword(),a);
	      //7�� ����̾�, �켱���̴� jnk
	      //jnk�� 7���� �ȵǸ� ������ �ֵ�� ä������.
	      if(jnk<1) {
	         ArrayList<MgMovie_DTO> jj=srv.jORk(movie.getMovie_jenre(),movie.getMovie_keyword(),a);
	         chuchen.addAll(jj);
	      }
	      m.addAttribute("chuchen", chuchen);

	      //�α��� ���ο� ���� ���ǰ�
	      if(login_id == null||loginOrNot != true) {
	         hs.setAttribute("memberloginOrNot", false);
	         hs.setAttribute("login_id", "");
	         return "main_MovDetails";
	      }else if(loginOrNot == true){
	         hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", login_id);
	            hs.setMaxInactiveInterval(1200); //20�� �� �α׾ƿ�
	          //���̵�� �򿩺� �Խ��� ��������.
	          yes=srv.mvD_JimCheck(login_id,a);//�α��ξ��̵�� ��ȭ�ڵ尡���� �򿩺� �ľ��Ϸ�����
	          if(yes==1) {
	             yes=1;
	          }else {
	             yes=0;
	          }
	          m.addAttribute("like", yes);
	          m.addAttribute("nowID", login_id);
	            //�α��ε� ��쿡 �򿩺� ��������
	          
	          //�����ϱ����� �������� ��.
	          /*��ȭ��ü����(movie) -> �Ϸ�
	           * ����(nowNew)      -> �Ϸ�
	           * �򿩺�(yes) like  -> �Ϸ�
	           * ���̵�(now-id)    -> �Ϸ�
	           * ��õ��ȭ(chuchen) -> �Ϸ�*/
	            return "main_MovDetails";
	      }else {
	         hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", "");
	         return "main_MovDetails";
	      }//�α��� ����
	   }//��ȭ �󼼺���
	
	//���� �α��ο���
	@ResponseBody
	@RequestMapping(value="/star_checkLogin")
	public String star_checkLogin(HttpSession hs) {
		String login_id = (String) hs.getAttribute("login_id");
		Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");
		if (login_id != null && loginOrNot == true ) {
			hs.setMaxInactiveInterval(1200); //20�� �� �α׾ƿ�
	        return "success";
	    } else {
	        return "fail";
	    }//�α��ο��� �ľ� if��
	}//���� �� ���� Ȯ��(�α��ο���)
	
	//���� �Է� ó������ Ȯ��
	@ResponseBody
	@RequestMapping(value="/star_checkAgain")
	public String star_checkAgain(HttpSession hs,HttpServletRequest hr) {
		String login_id = (String) hs.getAttribute("login_id");
		int code=Integer.parseInt(hr.getParameter("cd"));
		hs.setMaxInactiveInterval(1200); //20�� �� �α׾ƿ�
		MvService sv=ss.getMapper(MvService.class);
		int a=sv.doubleStar(code,login_id);
		if(a==0) {
	        return "success";
	    } else {
	        return "fail";
	    }//�α��ο��� �ľ� if��
	}//���� �� ���� Ȯ��(�α��ο���)
	
	//���� �Խ���
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
		//�̰� ����¡�� �ִµ� �� �� ó���Ǿ ���� �ڵ� ��Ű�� ��¥
		hs.setMaxInactiveInterval(1200); //�α����� �ƴ� ��� �� �ڵ带 20�и� ������ ���� �ž�.

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
	}//���� �Խ���
	
	//�����Խ��� ����¡ó��
		@ResponseBody
		@RequestMapping(value="/starPaging")
		public String starPaging(HttpSession hs
, HttpServletRequest request,@RequestParam("now") int now, @RequestParam("x")String x) {
			String pageHere=request.getParameter("now");
			x=request.getParameter("x"); //x�� new like me�� �����ִ� ��ü;
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
		}//���� ����¡

		
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
			hs.setMaxInactiveInterval(1200); //�α����� �ƴ� ��� �� �ڵ带 20�и� ������ ���� �ž�.
			ArrayList<MvStarDTO> star=srv.starOutNEW(a,pd);
			m.addAttribute("star", star);
			return "main_StarRatOUT_new";
		}


	//��õ
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
	}//��õ�ϱ�
}//class

