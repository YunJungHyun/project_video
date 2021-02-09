package com.spring.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.vo.BoardVO;

@Controller
public class BoardController {
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="getOneBoard", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOneBoard(String vnum,String vurl) {
		System.out.println("vnum : "+ vnum);
		Map<String, Object> map = new HashMap<String,Object>();
		String videoId = null;
		BoardVO boardVO = boardService.getOneBoard(vnum);
		
		
		String[] strArray =vurl.split("/");
		videoId = strArray[3];
		
		System.out.println("videoId :"+ videoId);
		map.put("map", boardVO);
		map.put("videoId", videoId);
		
		return map;
		
	}
	

	
}
