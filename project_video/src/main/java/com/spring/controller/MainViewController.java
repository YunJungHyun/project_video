package com.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.service.GenreService;
import com.spring.service.ReplyService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.GenreVO;
import com.spring.vo.PagingVO;
import com.spring.vo.ReplyVO;
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

	@Inject
	ReplyService replyService;

	HttpSession session;	

	@RequestMapping(value="mainView.do" , method=RequestMethod.GET)
	public String mainView(
			PagingVO pagingVO,
			@RequestParam(value="nowPage", required= false) String nowPage,
			@RequestParam(value="cntPerPage", required= false) String cntPerPage,
			@RequestParam(value="gnum", required= false) String gnum,
			@RequestParam(value="con", required= false) String con,
			HttpServletRequest request,
			Model model
			) {
		System.out.println("[mainView.do]");

		if(gnum== null || gnum.equals("0") ) {
			gnum= "";
		}
		 
		int total = boardService.boardTotalCnt(gnum);

		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="10";
		}else if(nowPage == null) {
			nowPage ="1";
		}else if(cntPerPage==null) {
			cntPerPage ="10";
		}
		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		pagingVO.setGnum(gnum);
		
		if(con != null) {
			switch (con) {

			case "allCon" :  pagingVO.setCon("bnum");
							break;
			case "viewcnt" : pagingVO.setCon("viewcnt") ;	
							break;
			case "upcnt" : pagingVO.setCon("upcnt") ;
							break;
			case "latestCon" : pagingVO.setCon("bnum") ;
							break;
			case "bnum" : pagingVO.setCon("bnum") ;
							break;
			//case "latestCon" :  pagingVO.setCon("");


			}
		}else if(con ==null){
			 
			 pagingVO.setCon("bnum");
		}
		//System.out.println("pagingVO :  "+pagingVO.toString());

		//장르
		List<GenreVO> glist= genreService.getAllGenre();

		//등록한동영상 정보
		List<VideoVO> vlist = videoService.getAllList(pagingVO);
			 
		//System.out.println(vlist.toString());
		//페이지 세션
		Map<String, String> map = new HashMap<String,String>();
		map.put("nowPage", Integer.toString(pagingVO.getNowPage()));
		map.put("cntPerPage", Integer.toString(pagingVO.getCntPerPage()));
		map.put("con",pagingVO.getCon());
		
		if(pagingVO.getGnum()=="") {
			map.put("gnum", "0");
		}else {
			map.put("gnum", pagingVO.getGnum());
		}
		session =request.getSession(true);
		session.setAttribute("pagingMap", map);
		
		
		
		//댓글 갯수가져오기
		List<ReplyVO> rlist =replyService.getReplyCnt();


		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("rlist", rlist);
		model.addAttribute("glist", glist);
		model.addAttribute("vlist", vlist);
		
		return "view/mainView.page";
	}



}
