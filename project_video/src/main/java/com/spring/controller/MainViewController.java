package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.service.UserService;

@Controller
public class MainViewController {
		
	
		@Inject
		UserService userService;
		
		HttpSession session;	
		
		@RequestMapping(value="mainView.do" , method=RequestMethod.GET)
		public String mainView(
				HttpServletRequest request
				) {
			System.out.println("[mainView.do]");
			
			
			
			return "view/mainView.page";
		}
		
		
		
}
