package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
			) {
		
		System.out.println("[login.do]");
		
		System.out.println("userVO.getUserid() : "+userVO.getUserid() );
		System.out.println("userVO.getUserpw() : "+userVO.getUserpw() );
		
		UserVO gui = userService.getUserInfo(userVO);
		
		//System.out.println("result : "+ gui.toString());
		
		
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
			RedirectAttributes rttr
			) {
		
		System.out.println("[logout.do]");
		session.invalidate();
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
}
