package com.spring.service;

import java.util.List;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

public interface BoardService {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);

	int boardTotalCnt();

	int updateUpCnt(int bnum);

	int updateDownCnt(int bnum);

	
}
