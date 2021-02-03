package com.spring.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.service.BoardService;
import com.spring.service.GenreService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.GenreVO;
import com.spring.vo.VideoVO;

@Controller
public class MainViewController {
		
	
		@Inject
		UserService userService;
		
		@Inject
		BoardService boardService;
		
		@Inject 
		VideoService videoService;
		
		@Inject
		GenreService genreService;
		
		HttpSession session;	
		
		@RequestMapping(value="mainView.do" , method=RequestMethod.GET)
		public String mainView(
				HttpServletRequest request,
				Model model
				) {
			System.out.println("[mainView.do]");
			
			//장르
			List<GenreVO> glist= genreService.getAllGenre();
			
			//등록한동영상 정보
			List<VideoVO> vlist = videoService.getAllList();
			
			System.out.println("vlist.toString : "+vlist.toString());
			
			
			model.addAttribute("glist", glist);
			model.addAttribute("vlist", vlist);
			
			return "view/mainView.page";
		}
		
		
		
}
