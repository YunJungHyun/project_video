package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {

	
	
	@RequestMapping(value="login.do" , method=RequestMethod.POST)
	public void login(String userid, String userpw) {
		
		System.out.println("[login.do]");
	}
	
	
	@RequestMapping(value="idCheck.do" , method=RequestMethod.POST)
	public void idCheck(String userid) {
		System.out.println("[idCheck.do]");
		
		
		
	}
}
