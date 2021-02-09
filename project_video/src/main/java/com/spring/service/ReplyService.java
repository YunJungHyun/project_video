package com.spring.service;

import java.util.List;

import com.spring.vo.ReplyVO;

public interface ReplyService {

	int insertReply(ReplyVO replyVO);

	List<ReplyVO> getBnumReply(int bnum);

	int insertReReply(ReplyVO replyVO);
	
}
