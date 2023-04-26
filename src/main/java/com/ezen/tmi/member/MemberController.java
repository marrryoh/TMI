package com.ezen.tmi.member;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.tmi.manager.MgMovie_DTO;
import com.ezen.tmi.manager.ReplyDTO;
import com.ezen.tmi.movie.MvService;

//ȸ������
@Controller
public class MemberController {
	
	public	static	String CURR_IMAGE_REPO_PATH="C:\\Users\\3-2\\git\\repository\\TMI\\src\\main\\webapp\\imgsave\\QnAImg";

	@Autowired
	SqlSession sqlSession;
	
	//ȸ������ ��
	@RequestMapping(value = "/member_Input")
	public String member()
	{
		return "member_Input";
	}
	
	//ȸ������ DB  ����
	@RequestMapping(value = "/member_Save")
	public String member2(HttpServletRequest request)
	{
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_nic = request.getParameter("user_nic");
		String user_birth = request.getParameter("year")+"/"+
				request.getParameter("month")+"/"+request.getParameter("day");
		String user_gender = request.getParameter("user_gender");
		String user_address =  request.getParameter("sido1")+" "+
				request.getParameter("gugun1");	
		MemService ms = sqlSession.getMapper(MemService.class);
		ms.memberinsert(user_id,user_pw,user_nic,user_birth,
				user_gender,user_address);
		return "redirect:home";
	}
	
	//���̵� �ߺ� �˻�
	@ResponseBody
    @RequestMapping(value="/idck")
	  public String member3(String user_id) {
		MemService ms = sqlSession.getMapper(MemService.class);
		int cnt = ms.idCheck(user_id);
		String bigo=null;
		
		if(cnt==0) {
			bigo="ok";
		}
		else
		{
			bigo="no";
		}
		  return bigo;
		 
	  }
	
	//�г��� �ߺ� �˻�
	@ResponseBody
	@RequestMapping(value="/nicck")
		public String member4(String user_nic, HttpServletRequest request) {
		MemService ms = sqlSession.getMapper(MemService.class);
		int cnt = ms.nicCheck(user_nic);
		String bigo=null;

			 if(cnt==0) {
					bigo="ok";
				}
				else 
				{
					bigo="no";
				}
		  return bigo; 
	}		
	
	//ȸ�� ���� �г��� �ߺ��˻�
	@ResponseBody
	@RequestMapping(value="/nicck2")
		public String member44(String user_nic, HttpServletRequest request) {
		MemService ms = sqlSession.getMapper(MemService.class);
		int cnt = ms.nicCheck(user_nic);
		String bigo=null;
		
		HttpSession hs = request.getSession();
		String a = (String)hs.getAttribute("login_id");
		String mynic = ms.myid(a);
		if(mynic.equals(user_nic))
		{
			bigo="my";
		}
		else
		{
			 if(cnt==0) {
					bigo="ok";
				}
				else 
				{
					bigo="no";
				}
		}
		  return bigo; 
	}		
	
	//�α���
	@RequestMapping(value = "/member_Login")
	 public String member5(HttpServletRequest request, HttpSession hs){
	      String beforUri = request.getHeader("Referer");
	      hs.setAttribute("prevPage", beforUri);
	      return "member_Login";
	}
	
	//�α��� ���� üũ
		@ResponseBody
		@RequestMapping(value="/memberChk")
		public String mem33(HttpServletRequest request) {
	      String no="no_member";
	      String a=request.getParameter("idpw");

	      //"mcheck"��ü�� json Ÿ������ �ڷᰡ �����ִ� ����
		        JSONParser jp=new JSONParser();
		        try{
		           JSONObject joj=(JSONObject)jp.parse(a);
		           String login_id=(String)joj.get("login_id");
		           String login_pw=(String)joj.get("login_pw");
		           
		           MemService ms = sqlSession.getMapper(MemService.class);
		           MemberDTO memck = ms.member_Login(login_id,login_pw);
		           
		           if(memck!=null) 
		           {
		              no="1";
		           }
		           else 
		           {
		              no="2";
		              return no;		             
		           }
		        }catch (org.json.simple.parser.ParseException e) {e.printStackTrace();}//try catch��
		     return no;
		  }//���̵��й�ȣ ��ġ���� �ľ� Ajax
		
		//�α��� ���� ����
		@RequestMapping(value = "/member_Login_Save", method = RequestMethod.POST)
		public String member6(HttpServletRequest request,RedirectAttributes ra)
		{
			  HttpSession hs = request.getSession();
		      String login_id=request.getParameter("login_id");
		      String login_pw=request.getParameter("login_pw");
		      MemService ms = sqlSession.getMapper(MemService.class);
		      MemberDTO dto = ms.member_Login(login_id,login_pw);
		      String prevPage = (String) hs.getAttribute("prevPage");
		      if(dto!=null)
		      {
		         
		         hs.setAttribute("member", dto);
		         hs.setAttribute("login_id", dto.getUser_id());
		         hs.setAttribute("memberloginOrNot", true);
		         hs.setMaxInactiveInterval(300); //5�� �� �α׾ƿ�
		         if (prevPage != null) {
		            return "redirect:" + prevPage;
		         } else {
		            return "redirect:home";
		         }
		      }
		      else
		      {         
		         ra.addAttribute("memLogin", "loginfail");
		         return "member_Login";
		      }

		}
	//ȸ�� ������ �ҷ�����
		@RequestMapping(value = "/member_Info")
		public String member6(Model mo,HttpServletRequest request)
		{
			HttpSession session = request.getSession();
			String login_id = (String) session.getAttribute("login_id");
			MemService ms = sqlSession.getMapper(MemService.class);
			MemberDTO dto = ms.member_Info(login_id);	
			mo.addAttribute("list", dto);
			
			return "member_Info";
		}
	
	//ȸ�� ���� �� ���� �������� 
	@RequestMapping(value = "/member_Modify1")
	public String InfoGET(Model mo,HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		String login_id = (String) session.getAttribute("login_id");
		MemService ms = sqlSession.getMapper(MemService.class);
		MemberDTO dto = ms.member_Info(login_id);	
		mo.addAttribute("list", dto);
		
		return "member_Modify1";
	}
	
	//ȸ������ ����
	@RequestMapping(value = "/member_Modify2")
	public String member7(HttpServletRequest request)
	{
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_nic = request.getParameter("user_nic");
		String user_birth = request.getParameter("year")+"/"+
				request.getParameter("month")+"/"+request.getParameter("day");
		String user_gender = request.getParameter("user_gender");
		String user_address =  request.getParameter("sido1")+" "+
				request.getParameter("gugun1");	
		MemService ms = sqlSession.getMapper(MemService.class);
		ms.modify(user_id,user_pw,user_nic,user_birth,
				user_gender,user_address);
		return "member_Modify_Success";
	}
	
	
	//�α׾ƿ� �� ���� ��������
	@RequestMapping(value ="/logout" )
	public String member8(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		hs.removeAttribute("member");
		hs.setAttribute("memberloginOrNot", false);		
		return "redirect:home";
	}
	
	//ȸ�� Ż��
	@ResponseBody
	@RequestMapping(value ="/member_Delete" )
	public String member9(HttpServletRequest request) {

		HttpSession hs = request.getSession();
		String a = (String)hs.getAttribute("login_id");
		MemService ms = sqlSession.getMapper(MemService.class);
		hs.invalidate();		
		ms.memberdelete(a);
	
		return "";
	}
	
	//�����ϱ�
	@RequestMapping(value = "/member_MyQnA")
	public String member10()
	{
		return "member_MyQnA";
	}
	
	//���Ǳ� ����
	@RequestMapping(value = "/member_MyQnA_Save") 
	public String member11(MultipartHttpServletRequest mul, Model mo) throws Exception
	{
		HttpSession session = mul.getSession();
		String bo_id = (String) session.getAttribute("login_id");
		
		MemService ms = sqlSession.getMapper(MemService.class);
		
		String bo_type = mul.getParameter("bo_type");
		String bo_title = mul.getParameter("bo_title");
		String bo_content = mul.getParameter("bo_content");
		MultipartFile mf = mul.getFile("bo_img");
		String fname = mf.getOriginalFilename();	
		//������ ���� ���!!
			if(mf.isEmpty())
			{
				fname="N";
			}
		mf.transferTo(new File(CURR_IMAGE_REPO_PATH+"\\"+fname));
			
		ms.QnAinsert(bo_id,bo_type,bo_title,bo_content,fname);
		return "redirect:member_MyQnA_Out";
	}
	
	//�� ���Ǳ� ���
	@RequestMapping(value = "/member_MyQnA_Out")
	public String member12(HttpServletRequest request,Model mo)
	{
		HttpSession session = request.getSession();
		String bo_id = (String) session.getAttribute("login_id");
	    MemService my = sqlSession.getMapper(MemService.class);
	    ArrayList<MemberBoardDTO> list = my.member_myboard(bo_id);
	    mo.addAttribute("list", list);
		return "member_MyQnA_Out";
	}
	
	//���Ǳ� �ڼ��� ����
	@RequestMapping(value = "/mem_boardDetail")
	public String member13(HttpServletRequest request, Model mo)
	{
		 int bo_num = Integer.parseInt(request.getParameter("bo_num"));
		 MemService my = sqlSession.getMapper(MemService.class);
		 MemberBoardDTO myb = my.boarddetail(bo_num);
		 mo.addAttribute("myb", myb);
		 //��� �ҷ�����
		 ArrayList<ReplyDTO> reply = my.replyout(bo_num);
		 mo.addAttribute("reply",reply);
		return "member_boardDetail";
	}
	  @RequestMapping(value="/member_StarRating")
	   public String member_StarRating(HttpSession hs,HttpServletRequest request,Model m) {
	      String login_id = (String) hs.getAttribute("login_id");
	      Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");

	      //�α��� ���ο� ���� ���ǰ�
	      if(login_id!= null && loginOrNot == true){
	         hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", login_id);
	            hs.setMaxInactiveInterval(1200); //20�� �� �α׾ƿ�
	            MvService srv=sqlSession.getMapper(MvService.class);
	            int mvCode=Integer.parseInt(request.getParameter("a"));
	            MgMovie_DTO movie=srv.mvDetail(mvCode);
	            m.addAttribute("mvName", movie.getMovie_name());
	            m.addAttribute("mvCode", mvCode);
	            return "member_StarRating";
	      }else {
	         hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", "");
	         return "redirect:member_Login";
	      }//�α��� ����
	   }//���� �˾�â
	   
	   @ResponseBody
	   @RequestMapping(value = "/memStarSave", method = RequestMethod.POST)
	   public String memStarSave(HttpServletRequest request,HttpSession hs) {
	      int star=Integer.parseInt(request.getParameter("rating"));
	      String text=request.getParameter("starText");
	      int movie=Integer.parseInt(request.getParameter("mvCode"));
	      
	      String id=(String)hs.getAttribute("login_id");      
	      MemService msrv=sqlSession.getMapper(MemService.class);
	      msrv.starin(movie,id,star,text);
	      return "response";
	   }//���� ���
	   
	   @ResponseBody
	   @RequestMapping(value="/mvJimm")
	   public String mvJimm(HttpServletRequest request,HttpSession hs) {
	      String myid=(String)hs.getAttribute("login_id");//���̵�
	      int mv=Integer.parseInt(request.getParameter("aa"));//��ȭ�ڵ�
	      MemService msrv=sqlSession.getMapper(MemService.class);
	      int check=msrv.mJimCheck(myid,mv);
	      String jjim="no";
	      if(check==1) {
	         jjim="no";
	      }else if(check==0) {
	         jjim="yes";
	         msrv.mvJimm(myid,mv);
	      }else {
	         jjim="err";
	      }
	      return jjim;
	   }//���ϱ�
	   
	   @ResponseBody
	   @RequestMapping(value="/mvJimm_Delete")
	   public String mvJimm_Delete(HttpServletRequest request,HttpSession hs) {
	      String myid=(String)hs.getAttribute("login_id");//���̵�
	      int mv=Integer.parseInt(request.getParameter("aa"));//��ȭ�ڵ�
	      MemService msrv=sqlSession.getMapper(MemService.class);
	      int check=msrv.mJimCheck(myid,mv);
	      String bye="no";
	      if(check==1) {
	         msrv.mvJimmDel(myid,mv);
	         bye="yes";
	      }else {
	         bye="err";
	      }
	      return bye;
	   }//�� ����ϱ�
	   
	   @RequestMapping(value="/member_Jimm")
	   public String member_Jimm(HttpServletRequest request,HttpSession hs,Model m) {
	      String login_id = (String) hs.getAttribute("login_id");
	      Boolean loginOrNot = (Boolean) hs.getAttribute("memberloginOrNot");

	      //�α��� ���ο� ���� ���ǰ�
	      if(login_id!= null && loginOrNot == true){
	         hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", login_id);
	            hs.setMaxInactiveInterval(1200); //20�� �� �α׾ƿ�
	            MemService srv=sqlSession.getMapper(MemService.class);
	            ArrayList<JimDTO> jjim=srv.memberJjim(login_id);
	            m.addAttribute("jim", jjim);
	            return "member_Jimm";
	      }else {
	         hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            hs.setAttribute("login_id", "");
	         return "redirect:member_Login";
	      }//�α��� ����
	   }//���� ����
}




















