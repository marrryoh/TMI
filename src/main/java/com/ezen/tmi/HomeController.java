package com.ezen.tmi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


//∏ﬁ¿Œ
@Controller
public class HomeController {
	
	@RequestMapping(value = "/")
	public String home(HttpServletRequest request)
	{
		 HttpSession hs=request.getSession();
	      if(hs.getAttribute("login_id")==null&&hs.getAttribute("manager_id")==null) {
	         hs.setAttribute("memberloginOrNot",false);
	         hs.setAttribute("administrator_only",false);
	         return "home";
	      }else {
	         if(hs.getAttribute("manager_id")==null){
	            hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("administrator_only", false);
	            return "home";
	         }else if(hs.getAttribute("administrator_only").equals(true)&&hs.getAttribute("login_id")==null) {
	            hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("administrator_only", true);
	            return "home";
	         }else if(hs.getAttribute("administrator_only").equals(true)&&hs.getAttribute("memberloginOrNot").equals(true)){
	            hs.setAttribute("memberloginOrNot", true);
	            hs.setAttribute("manager_id", "");
	            hs.setAttribute("administrator_only", false);
	            return "home";
	         }else {
	            hs.setAttribute("memberloginOrNot", false);
	            hs.setAttribute("administrator_only",false);
	            return "home";}
	      }
	   }
	
	
	@RequestMapping(value = "/home")
	public String home2()
	{
		return "home";
	}
	
	
}
