package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	

	@Inject
    private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.replyMapper";

	
	@Override
	public int insertReply(ReplyVO replyVO) {
		int result = sqlSession.insert(Namespace +".insertReply",replyVO);
		return result;
	}
	
	@Override
	public List<ReplyVO> getBnumReply(int bnum) {
		
		List<ReplyVO> rlist = sqlSession.selectList(Namespace+".getBnumReply", bnum);
		return rlist;
	}
	
	@Override
	public int insertReReply(ReplyVO replyVO) {
		int result = sqlSession.insert(Namespace+".insertReReply",replyVO);
		return result;
	}

}
