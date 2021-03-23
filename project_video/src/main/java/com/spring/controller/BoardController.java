package com.spring.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.service.VideoService;
import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

@Controller
public class BoardController {
	
	@Inject
	BoardService boardService;
	
	@Inject
	VideoService videoService;
	
	HttpSession session;
	
	@RequestMapping(value="getOneBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOneBoard(String vnum,HttpServletRequest request) {
		//System.out.println("vnum : "+ vnum);
		Map<String, Object> map = new HashMap<String,Object>();
		String videoId = null;
		BoardVO boardVO = boardService.getOneBoard(vnum);
		
	
		//System.out.println("videoId :"+ videoId);
		map.put("map", boardVO);
		
		//Map<String, String> rMap = new HashMap<String,String>();
		
	
		
		return map;
		
	}
	
	@RequestMapping(value="boardJudgment.do", method=RequestMethod.GET)
	@ResponseBody
	public String boardJudgment(
			@RequestParam(value="judg" ,  required= true) String judg ,
			@RequestParam(value="bnum" ,  required= true) int bnum 
			) {
		
		
		if(judg.equals("up")) {
			
			boardService.updateUpCnt(bnum); 
			return "up";
		}
		else  {
			boardService.updateDownCnt(bnum);
			
			return "down";
		}
		
	}
	
	@RequestMapping(value="viewCntUp.do")
	@ResponseBody
	public String viewCntUp(
			@RequestParam(value="bnum" ,required=true) String bnum
			) {
	
		//System.out.println("bnum :"+bnum);
		
		int result  =boardService.viewCntUp(bnum);
		
		if(result >= 1) {
			
			//System.out.println("조회수 증가");
		}else{
			
			//System.out.println("조회수 증가 실패");
		}
		
		return Integer.toString(result);
		
	}
	
	
	@RequestMapping(value="favList.do")
	@ResponseBody
	public List<VideoVO> favList(
			
			@RequestParam(value="fav" , required =false) String fav
			
			) {
		//System.out.println("fav : " +fav);
		
		String[] favArray = fav.split("/");
		List<VideoVO> fvlist = new ArrayList<VideoVO>();
		
		for(int i = 0 ; i < favArray.length ; i++) {
			
			//System.out.println(i+"="+favArray[i]);
			
			if(!favArray[i].equals("")) {
				VideoVO	videoVO = boardService.getFavlist(favArray[i]);
				
				fvlist.add(videoVO);
			} 
		} 
		
		//System.out.println(fvlist.toString());
		
		Collections.reverse(fvlist);
		//System.out.println(fvlist.size());
		return fvlist ;

	}
}
