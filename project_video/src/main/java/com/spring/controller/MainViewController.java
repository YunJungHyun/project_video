package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainViewController {

		@RequestMapping(value="mainView.do" , method=RequestMethod.GET)
		public String mainView() {
			System.out.println("[mainView.do]");
			
			return "view/mainView.page";
		}
}
