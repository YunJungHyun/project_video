package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.VideoVO;

@Repository
public class VideoDAOImpl implements VideoDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.videoMapper";
	
	@Override 
	public int insertVideo(VideoVO videoVO) {
		int result = sqlSession.insert(Namespace+".insertVideo", videoVO);
		int vnum =videoVO.getVnum();
		return vnum;
	}
}
