package com.spring.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.ReplyService;
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;

@Controller
public class ReplyController {

	@Inject
	ReplyService replyService;

	@RequestMapping(value="insertReply.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertReply(

			@ModelAttribute ReplyVO replyVO,
			HttpSession session
			) {

		UserVO gui = (UserVO)session.getAttribute("gui");
		String userid= gui.getUserid();
		System.out.println("userid :" +userid);

		replyVO.setReplyer(userid);

		int result = replyService.insertReply(replyVO);

		System.out.println("댓글 insert 결과 : "+ result); 

		if(result >= 1) {

			return "YES";
		}
		else {

			return "NO";
		}

	}

	@RequestMapping("replyList.do")
	@ResponseBody
	public List<ReplyVO> replyList(@RequestParam int bnum) {

		System.out.println("[replyList.do]");

		List<ReplyVO> rlist=replyService.getBnumReply(bnum);

		//System.out.println(" rlist.size() : " +rlist.size());


		return rlist;
	}

	@RequestMapping(value="insertReReply.do" , method=RequestMethod.POST)
	@ResponseBody
	public String insertReReply(@ModelAttribute ReplyVO replyVO, HttpSession session) {

		UserVO gui = (UserVO)session.getAttribute("gui");
		String userid= gui.getUserid();
		System.out.println("userid :" +userid);

		replyVO.setReplyer(userid);

		System.out.println("bnum :" +replyVO.getBnum());
		System.out.println("rpnum :" +replyVO.getRpnum());
		System.out.println("대댓글 :" +replyVO.getReplyText());

		int result = replyService.insertReReply(replyVO); 

		System.out.println("result :" + result);

		if(result >= 1) {

			return "YES";
		}
		else {

			return "NO";
		}
	}
}
