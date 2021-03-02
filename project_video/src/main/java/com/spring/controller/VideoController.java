package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.UserVO;
import com.spring.vo.VideoVO;

@Controller
public class VideoController {

	
	@Inject
	VideoService videoService;
	
	@Inject
	BoardService boardService;
	@Inject
	UserService userService;
	
	HttpSession session;
	
	@RequestMapping(value="videoReg.do", method=RequestMethod.POST)
	@ResponseBody
	public String videoReg(
			VideoVO videoVO
		
			
			) {
		
		//System.out.println("videoVO.getGnum :" +videoVO.getGnum());
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
	
	@RequestMapping(value="recentlyList.do" ,method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> recentlyList(
			@RequestParam (value="cookie" , required= false) String cookie
			) {
		System.out.println("cookie : "+cookie);
		List<VideoVO> list = new ArrayList<VideoVO>();
		
		String[] cArray= cookie.split("&");
		
		for(int i = 0 ; i < cArray.length ;i++) {
			
			//System.out.println("cArray.length :"+cArray[i].length());
			int vnum =Integer.parseInt(cArray[i].substring(1,cArray[i].length()-1));
			//System.out.println("vnum : "+ vnum);
		
			VideoVO videoVO= videoService.getOneVideo(vnum);
			
			list.add(videoVO);
		}
		//return map;
		
		Map<String,Object> map = new HashMap<String,Object>();
		Collections.reverse(list);
		
		
		//System.out.println("list.size() :"+list.size());
		map.put("mlist", list);
		
		return map;
	}
	
	@RequestMapping(value="myVideoUpdate.do")
	@ResponseBody
	public void myVideoUpdate(
			
			VideoVO videoVO,
			HttpSession session
			) {
		
		try {
			String vurl = URLDecoder.decode(videoVO.getVurl(),"UTF-8");
			String vtitle =  URLDecoder.decode(videoVO.getVtitle(),"UTF-8");
			String vpw =  URLDecoder.decode(videoVO.getVpw(),"UTF-8");
			
			videoVO.setVurl(vurl);
			videoVO.setVtitle(vtitle);
			videoVO.setVpw(vpw);
		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		UserVO gui = (UserVO) session.getAttribute("gui");
		
		videoVO.setUnum(gui.getUnum());
		
		int result = videoService.myVideoUpdate(videoVO);
		System.out.println("result : " +result);
		//boardService.myBoardUpdate(videoVO);
		
	}
	
	@RequestMapping(value="videoDelete.do")
	@ResponseBody
	public void videoDelete(
			@RequestParam(value="vnum" ,required=false) String vnum
			) {
		
		
		int resultVideo = videoService.videoDelete(vnum);
		int resultBoard = boardService.boardDelete(vnum);
		
		
		System.out.println("resultVideo : "+resultVideo);
		System.out.println("resultBoard : "+resultBoard);
	
	}
}
