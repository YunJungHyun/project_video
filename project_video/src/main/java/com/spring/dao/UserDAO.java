package com.spring.dao;

import com.spring.vo.UserVO;

public interface UserDAO {

	
	public int idCheck(String userid);

	public UserVO getUserInfo(UserVO userVO);
}
