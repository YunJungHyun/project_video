package com.spring.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.service.VideoService;
import com.spring.vo.VideoVO;

@Controller
public class VideoController {

	
	@Inject
	VideoService videoService;
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="videoReg.do", method=RequestMethod.POST)
	@ResponseBody
	public String videoReg(
			VideoVO videoVO
		
			
			) {
		
		System.out.println("videoVO.getGnum :" +videoVO.getGnum());
//		System.out.println("videoVO.getVurl() :" + videoVO.getVurl());
//		System.out.println("videoVO.getVtitle() :" + videoVO.getVtitle());
//		System.out.println("videoVO.getVpw() :" + videoVO.getVpw());
//		System.out.println("videoVO.getUnum() :" + videoVO.getUnum());
		
		videoService.insertVideo(videoVO);
		 
		
		System.out.println("videoVO.getVnum():"+videoVO.getVnum());
		System.out.println("videoVO.getUnum():"+videoVO.getUnum());
		
		int result = boardService.insertBoard(videoVO); 
		
		if(result >= 1) {
			
		
				return "success";
		
		}else {
			return "fail";
		}
		 
		
	}
}
