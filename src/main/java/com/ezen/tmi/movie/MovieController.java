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
}
