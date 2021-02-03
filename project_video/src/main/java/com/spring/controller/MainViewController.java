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
			
			List<GenreVO> glist= genreService.getAllGenre();
			
			model.addAttribute("glist", glist);
			
			return "view/mainView.page";
		}
		
		
		
}
