package com.spring.service;

import com.spring.vo.UserVO;

public interface UserService {
	
	public int idCheck(String userid);

	public UserVO getUserInfo(UserVO userVO);

	public int updateFav(UserVO userVO);

	public int updateFavRelease(UserVO userVO);
}
