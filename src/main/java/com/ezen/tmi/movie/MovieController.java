package com.ezen.tmi.movie;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.tmi.manager.MgMovie_DTO;


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
}
