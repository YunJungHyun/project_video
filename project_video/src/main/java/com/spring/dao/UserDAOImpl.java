package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{
	
	@Inject
    private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.userMapper";

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		
		int result = sqlSession.selectOne(Namespace+".idCheck", userid);
		
		return result;
	}
	
	@Override
	public UserVO getUserInfo(UserVO userVO) {
		UserVO result =(UserVO) sqlSession.selectOne(Namespace+".getUserInfo", userVO);
		return result;
	}
	
	@Override
	public int updateFav(UserVO userVO) {
		
		int result = sqlSession.update(Namespace+".updateFav",userVO);
		return result;
	}
	
	@Override
	public int updateFavRelease(UserVO userVO) {
	
		int result = sqlSession.update(Namespace+".updateFavRelease",userVO);
		return result;
	}


}
