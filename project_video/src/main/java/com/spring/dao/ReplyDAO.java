package com.spring.dao;

import java.util.List;

import com.spring.vo.ReplyVO;

public interface ReplyDAO {

	int insertReply(ReplyVO replyVO);

	List<ReplyVO> getBnumReply(int bnum);

}
