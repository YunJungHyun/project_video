package com.spring.dao;

import java.util.List;
import java.util.Map;

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
	
	@Override
	public int boardTotalCnt(String gnum) {
		 int result = sqlSession.selectOne(Namespace+".boardTotalCnt",gnum);
		return result;
	}
	
	@Override
	public int updateUpCnt(int bnum) {
		int result = sqlSession.update(Namespace+".updateUpCnt",bnum);
		return result;
	}
	
	@Override
	public int updateDownCnt(int bnum) {
		int result = sqlSession.update(Namespace+".updateDownCnt",bnum);
		return result;
	}
	
	@Override
	public int viewCntUp(String bnum) {
		int result =sqlSession.update(Namespace+".viewCntUp",bnum);
		
		
		return result;
	}
	
	@Override
	public VideoVO getFavlist(String favArray) {
		System.out.println(favArray);
		
		VideoVO result = sqlSession.selectOne(Namespace+".getFavlist", favArray);
		
		return result;
	}
}

 