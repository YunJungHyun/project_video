package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@RequestMapping(value="rightMenuList.do" ,method=RequestMethod.GET)
	@ResponseBody
	public void rightMenuList(
			@RequestParam (value="vnumList" , required= false) String vnumList
			) {
		String[] strArray =null;
		List<VideoVO> list = new ArrayList<VideoVO>();
		
		if(!vnumList.contains("/")) {
			int vnum = Integer.parseInt(vnumList);
			System.out.println("/있음");
			VideoVO videoVO= videoService.getOneVideo(vnum);
			list.add(videoVO);
		}else {
		
			strArray = vnumList.split("/");
			for(int i=0 ; i < strArray.length ;i++) {
				
				int vnum = Integer.parseInt(strArray[i]);
				VideoVO videoVO= videoService.getOneVideo(vnum);
				
				list.add(videoVO);
			}
		}
		
		System.out.println("list.toString :" +list.toString());
	}
}
