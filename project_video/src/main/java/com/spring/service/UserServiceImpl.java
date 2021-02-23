package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

		
		@Inject
		UserDAO userDAO;
	
		@Override
		public int idCheck(String userid) {
			// TODO Auto-generated method stub
			return userDAO.idCheck(userid);
		}
		 
		@Override
		public UserVO getUserInfo(UserVO userVO) {
			// TODO Auto-generated method stub
			return userDAO.getUserInfo(userVO);
		}
		
		
		@Override
		public int updateFav(UserVO userVO) {
		// TODO Auto-generated method stub
			return userDAO.updateFav(userVO);
		}
		
		@Override
		public int updateFavRelease(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.updateFavRelease(userVO);
		}
}
