package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.BoardDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Inject
	BoardDAO boardDAO;
	
	@Override
	public int insertBoard(VideoVO videoVO) {
		// TODO Auto-generated method stub
		return boardDAO.insertBoard(videoVO) ;
	}
	
	@Override
	public BoardVO getOneBoard(String vnum) {
		// TODO Auto-generated method stub
		return boardDAO.getOneBoard(vnum);
	}
	
	@Override
	public int boardTotalCnt() {
		// TODO Auto-generated method stub
		return boardDAO.boardTotalCnt();
	}
	
	@Override
	public int updateUpCnt(int bnum) {
		// TODO Auto-generated method stub
		return boardDAO.updateUpCnt(bnum);
	}
	
	@Override
	public int updateDownCnt(int bnum) {
		// TODO Auto-generated method stub
		return boardDAO.updateDownCnt(bnum);
	}
}
