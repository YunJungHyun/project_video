package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.ReplyDAO;
import com.spring.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Inject
	ReplyDAO replyDAO;
	
	@Override
	public int insertReply(ReplyVO replyVO) {
		// TODO Auto-generated method stub
		return replyDAO.insertReply(replyVO);
		
	}
	
	@Override
	public List<ReplyVO> getBnumReply(int bnum) {
		// TODO Auto-generated method stub
		return replyDAO.getBnumReply(bnum);
	}
	
	@Override
	public int insertReReply(ReplyVO replyVO) {
		// TODO Auto-generated method stub
		return replyDAO.insertReReply(replyVO);
	}
}
