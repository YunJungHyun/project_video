package com.spring.service;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

public interface BoardService {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);
	
}