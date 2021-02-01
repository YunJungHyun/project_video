package com.spring.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.UserService;



@Controller
public class UserController {

	@Inject
	private UserService userService;
	
	@RequestMapping(value="login.do" , method=RequestMethod.POST)
	public void login(String userid, String userpw) {
		
		System.out.println("[login.do]");
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
