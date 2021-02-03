package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.GenreDAO;
import com.spring.vo.GenreVO;

@Service
public class GenreServiceImpl implements GenreService{

	@Inject
	GenreDAO genreDAO;
	
	@Override
	public List<GenreVO> getAllGenre() {
		// TODO Auto-generated method stub
		return genreDAO.getAllGenre();
	}
}
