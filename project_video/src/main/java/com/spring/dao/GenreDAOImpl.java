package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.GenreVO;

@Repository
public class GenreDAOImpl implements GenreDAO{

	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.genreMapper";

	
	@Override
	public List<GenreVO> getAllGenre() {
		
		List<GenreVO> glist = sqlSession.selectList(Namespace+".getAllgenre");
		return glist;
	}
}
