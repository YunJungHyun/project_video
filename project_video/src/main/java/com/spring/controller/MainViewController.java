package com.spring.controller;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.service.BoardService;
import com.spring.service.GenreService;
import com.spring.service.ReplyService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.GenreVO;
import com.spring.vo.PagingVO;
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;
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
			HttpSession session,
			Model model
			) {
		System.out.println("[mainView.do]");


		/* System.out.println("nowPage : "+nowPage); */

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

		//System.out.println(vlist.size()); 

		Map<String, String> map = new HashMap<String,String>();
		//페이지 세션
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

		model.addAttribute("rlist", rlist);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("glist", glist);
		model.addAttribute("vlist", vlist);

		return "view/mainView.page";
	}


	@RequestMapping(value="myVideo.do")
	public String myVideo(
			PagingVO pagingVO,
			@RequestParam(value="nowPage", required= false) String nowPage,
			@RequestParam(value="cntPerPage", required= false) String cntPerPage,
			@RequestParam(value="unum", required=true) String unum,
			Model model,
			HttpServletRequest request
			) {
		int total = boardService.myBoardTotalCnt(unum);


		//System.out.println("total : "+total);

		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="10";
		}else if(nowPage == null) {
			nowPage ="1";
		}else if(cntPerPage==null) {
			cntPerPage ="10";
		}

		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		//System.out.println("nowPage : "+nowPage);
		//System.out.println("pagingVO.lastPage : "+pagingVO.getLastPage());

		pagingVO.setUnum(Integer.parseInt(unum));
		List<VideoVO> myVlist = videoService.getMyVideo(pagingVO);

		//장르
		List<GenreVO> glist= genreService.getAllGenre();

		//System.out.println("myVlist.size() :"+myVlist.size());
		Map<String, String> map = new HashMap<String,String>();

		//페이지 세션
		map.put("nowPage", Integer.toString(pagingVO.getNowPage()));
		map.put("cntPerPage", Integer.toString(pagingVO.getCntPerPage()));

		session =request.getSession(true); 
		session.setAttribute("PagingMap", map);	
		//댓글 갯수가져오기
		List<ReplyVO> rlist =replyService.getReplyCnt();

		model.addAttribute("rlist", rlist);

		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("vlist", myVlist);
		model.addAttribute("glist", glist);

		return "view/userInfo/myVideo.page";
	}



	@RequestMapping(value="myFavVideo.do")
	public String myFavVideo(
			PagingVO pagingVO,
			@RequestParam(value="nowPage", required= false) String nowPage,
			@RequestParam(value="cntPerPage", required= false) String cntPerPage,
			Model model,
			HttpServletRequest request,
			HttpSession session,
			@RequestParam(value="favNum" , required=false) String favNum
			) {
		UserVO gui = (UserVO)session.getAttribute("gui");
		int unum = gui.getUnum();
		String favorites =gui.getFavorites();

		System.out.println("favorites :" +favNum);
		String[] fArray = favorites.split("/");

		String fav = "^";
		String[] favArray= new String[fArray.length-1];
		int total = 0 ;

		for(int i = 0 ; i < fArray.length ; i++ ) {

			if(!fArray[i].equals("")) {
				total+=1;
				favArray[fArray.length-i-1] = fArray[i];

				if(i != fArray.length-1) {		
					fav += fArray[i] +"$|^";
				}else {

					fav += fArray[i]+"$";
				}

			} 	
		}

		System.out.println("favArray : " +Arrays.toString(favArray));
		System.out.println("total : "+total);

		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="10";
		}else if(nowPage == null) {
			nowPage ="1";
		}else if(cntPerPage==null) {
			cntPerPage ="10";
		}

		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		//System.out.println("nowPage : "+nowPage);
		//System.out.println("pagingVO.lastPage : "+pagingVO.getLastPage());

		pagingVO.setUnum(unum);
		pagingVO.setFavArray(favArray);
		pagingVO.setFav(fav);


		List<VideoVO> fvList = videoService.getMyFavVideo(pagingVO);


		System.out.println("fvList.size() :" +fvList.size());
		//System.out.println("fvList.toString() :" +fvList.toString());

		//장르
		List<GenreVO> glist= genreService.getAllGenre();

		//System.out.println("myVlist.size() :"+myVlist.size());
		Map<String, String> map = new HashMap<String,String>();

		//페이지 세션
		map.put("nowPage", Integer.toString(pagingVO.getNowPage()));
		map.put("cntPerPage", Integer.toString(pagingVO.getCntPerPage()));

		session =request.getSession(true); 
		session.setAttribute("PagingMap", map);	
		//댓글 갯수가져오기
		List<ReplyVO> rlist =replyService.getReplyCnt();

		model.addAttribute("rlist", rlist);
		model.addAttribute("favNum" ,favNum);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("vlist", fvList);
		model.addAttribute("glist", glist);

		return "view/userInfo/myFavVideo.page";
	}


	@RequestMapping(value="myRecentlyVideo.do")
	public String myRecentlyVideo(
			PagingVO pagingVO,
			@RequestParam(value="nowPage", required= false) String nowPage,
			@RequestParam(value="cntPerPage", required= false) String cntPerPage,
			Model model,
			HttpServletRequest request,
			HttpSession session,
			@RequestParam(value="reNum" , required=false) String reNum,
			@RequestParam(value="cookie" , required=false) String cookie
			) {

		System.out.println("reNum : "+ reNum);
		System.out.println("cookie : "+ cookie);

		String[] cArray = cookie.trim().split(",");
		String[] cookieArray = new String[cArray.length];
		
		int total = 0;

		String cookieStr = "^";

		for(int i = 0 ; i < cArray.length ;i++) {

			total += 1;
			cookieArray[cArray.length-i-1] = cArray[i];
			
			if(i != cArray.length-1) {
				cookieStr += cArray[i]+"$|^";

			}else {

				cookieStr +=cArray[i]+"$";
			}
		}


		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="10"; 
		}else if(nowPage == null) {
			nowPage ="1";
		}else if(cntPerPage==null) {
			cntPerPage ="10";
		}

		pagingVO = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		pagingVO.setRecently(cookieStr);
		pagingVO.setRecentlyArray(cookieArray);

		List<VideoVO> relist = videoService.getMyRecentlyVideo(pagingVO);

		System.out.println("rlist.size()"+relist.size());

		//장르
		List<GenreVO> glist= genreService.getAllGenre();

		//System.out.println("myVlist.size() :"+myVlist.size());
		Map<String, String> map = new HashMap<String,String>();

		//페이지 세션
		map.put("nowPage", Integer.toString(pagingVO.getNowPage()));
		map.put("cntPerPage", Integer.toString(pagingVO.getCntPerPage()));

		session =request.getSession(true); 
		session.setAttribute("PagingMap", map);	
		//댓글 갯수가져오기
		List<ReplyVO> rlist =replyService.getReplyCnt();

		model.addAttribute("rlist", rlist);
		model.addAttribute("reNum" ,reNum);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("vlist", relist);
		model.addAttribute("glist", glist);


		return "view/userInfo/myRecentlyVideo.page";
	}

}
