package com.spring.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.service.BoardService;
import com.spring.service.GenreService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.GenreVO;
import com.spring.vo.PagingVO;
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
				PagingVO pagingVO,
				@RequestParam(value="nowPage", required= false) String nowPage,
				@RequestParam(value="cntPerPage", required= false) String cntPerPage,
				
				Model model
				) {
			System.out.println("[mainView.do]");
			System.out.println("nowPage  : " +nowPage);
			System.out.println("cntPerPage  : " +cntPerPage);
			int total = boardService.boardTotalCnt();
			
			System.out.println("전체 글 수 : "+total);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage="10";
			}else if(nowPage == null) {
				nowPage ="1";
			}else if(cntPerPage==null) {
				cntPerPage ="10";
			}
			pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			
			System.out.println("pagingVO :  "+pagingVO.toString());
			//장르
			List<GenreVO> glist= genreService.getAllGenre();
			
			//등록한동영상 정보
			List<VideoVO> vlist = videoService.getAllList(pagingVO);
			
			System.out.println("vlist.toString : "+vlist.toString());
			System.out.println("vlist.size() :" +vlist.size());
			model.addAttribute("pagingVO",pagingVO);
			model.addAttribute("glist", glist);
			model.addAttribute("vlist", vlist);
			
			return "view/mainView.page";
		}
		
		
		
}
