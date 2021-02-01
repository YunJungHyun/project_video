package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.vo.VideoVO;

@Controller
public class BoardController {

	
	@RequestMapping(value="boardReg.do", method=RequestMethod.POST)
	public void boardReg(
			VideoVO videoVO
			) {
		
		System.out.println("videoVO.getVurl() :" + videoVO.getVurl());
		System.out.println("videoVO.getVtitle() :" + videoVO.getVtitle());
		System.out.println("videoVO.getVpw() :" + videoVO.getVpw());
		System.out.println("videoVO.getUnum() :" + videoVO.getUnum());
		
	}
}
