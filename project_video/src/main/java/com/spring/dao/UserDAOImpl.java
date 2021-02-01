package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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

}
