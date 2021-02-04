package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.boardMapper";
	
	@Override
	public int insertBoard(VideoVO videoVO) {
		
		int result = sqlSession.insert(Namespace+".insertBoard",videoVO);
		return result;
	}
	
	@Override
	public BoardVO getOneBoard(String vnum) {
		
		BoardVO board = sqlSession.selectOne(Namespace+".getOneBoard",vnum);
		 
		return board;
	}
}
 