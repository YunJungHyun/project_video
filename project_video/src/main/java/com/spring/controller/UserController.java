package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.UserService;
import com.spring.vo.UserVO;



@Controller
public class UserController {

	@Inject
	private UserService userService;

	HttpSession session;

	@RequestMapping(value="login.do" , method=RequestMethod.POST)
	public String login(UserVO userVO,
			RedirectAttributes rttr,
			HttpServletRequest request
			,HttpServletResponse response
			) {
	
		//System.out.println("cookie.getValue() :" +cookie.getValue());
		System.out.println("[login.do]");

		System.out.println("userVO.getUserid() : "+userVO.getUserid() );
		System.out.println("userVO.getUserpw() : "+userVO.getUserpw() );

		UserVO gui = userService.getUserInfo(userVO);

		//System.out.println("result : "+ gui.toString());
		
//		Cookie[] cookies =request.getCookies();
//		
//		System.out.println("cookies :"+cookies);
//		
//		if(cookies != null) {
//			
//			for (int i=0 ; i < cookies.length ; i++) {
//				
//				cookies[i].setMaxAge(0);
//				
//				response.addCookie(cookies[i]);
//			}
//		}
 
		if(gui ==null) {
			System.out.println("gui없음");
			rttr.addFlashAttribute("message","loginFail");
		}
		else {

			System.out.println("gui있음");
			session =request.getSession(true);
			session.setAttribute("gui", gui);
			rttr.addFlashAttribute("message","loginSuccess");
		}

		return "redirect:/mainView.do";
	}

	@RequestMapping(value="logout.do")
	public String logout(
			RedirectAttributes rttr,
			HttpServletRequest request
			) {

		System.out.println("[logout.do]");
		
		
		if(request.isRequestedSessionIdValid()) {
			session.invalidate();
			
		}
		
		rttr.addFlashAttribute("message", "logoutSuccess");
		return "redirect:/mainView.do";
	}

	@RequestMapping(value="idCheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public String idCheck(String userid) {
		System.out.println("[idCheck.do]");

		int result = userService.idCheck(userid);

		System.out.println("result : " + result);
		if(result >= 1) {

			return "YES";
		}
		else {

			return "NO";
		}

	}

	@RequestMapping(value="favorites.do", method=RequestMethod.POST)
	@ResponseBody
	public String favorites(

			@RequestParam(value="bnum", required=true) String bnum,
			@RequestParam(value="chk", required=true) Boolean chk

			) {



		UserVO userVO =(UserVO) session.getAttribute("gui");


		String favResult =null;

		if(chk == true) {

			System.out.println("이미 즐겨 찾기 등록되어있음");
			userVO.setFbnum(bnum+"/");

			int result =userService.updateFavRelease(userVO);
			UserVO gui = userService.getUserInfo(userVO);
			//System.out.println(gui.toString());
			if(result==1) {
				session.setAttribute("gui", gui);
				favResult="release";
			}
		
		}else {

			userVO.setFbnum(bnum+"/");
			//System.out.println("userVO.getFbnum :"+userVO.getFbnum());
			int result= userService.updateFav(userVO);

			//System.out.println("fav result : "+ result);
			UserVO gui = userService.getUserInfo(userVO);
			
			if(result==1) {
				session.setAttribute("gui", gui);
				favResult="add";
			}
		}

		return favResult;

	}
	
	@RequestMapping("emptyDelete.do")
	@ResponseBody
	public void emptyDelete(
			@RequestParam(value="favNum", required=true) String favNum,
			HttpSession session
			) {
		
		UserVO gui = (UserVO)session.getAttribute("gui");
		int num =Integer.parseInt(favNum);
		
		String favList=gui.getFavorites();
		System.out.println(favList);
		
		String[] flArray = favList.split("/");
		String[] reFlArray = new String[flArray.length];
		
		for(int i =0 ; i <flArray.length ; i++) {
			
			reFlArray[flArray.length-1-i]= flArray[i];
			//System.out.println("flArray : "+flArray[i]);
			
			
		}
		String dFavNum = reFlArray[num];
		
		String newFavorites =favList.replace(dFavNum+'/', "");
		
		System.out.println("newFavorites :"+newFavorites);
		gui.setFavorites(newFavorites);
		int result =userService.emtyDelete(gui);
	
		System.out.println("result : " + result);
	}
}
