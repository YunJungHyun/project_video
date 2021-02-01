package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService {

		
		@Inject
		UserDAO userDAO;
	
		@Override
		public int idCheck(String userid) {
			// TODO Auto-generated method stub
			return userDAO.idCheck(userid);
		}
}
