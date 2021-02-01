package com.spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainViewController {
		
		HttpSession session;	
		
		@RequestMapping(value="mainView.do" , method=RequestMethod.GET)
		public String mainView(
				HttpServletRequest request
				) {
			System.out.println("[mainView.do]");
			
			
			//임시
			session =request.getSession(true);
			session.setAttribute("user", "admin");
			
			return "view/mainView.page";
		}
		
		@RequestMapping(value="example.do")
		public String example() {
			
			return "view/example.page";
		}
		
}
