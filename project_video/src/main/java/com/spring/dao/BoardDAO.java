package com.spring.dao;

import java.util.List;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

public interface BoardDAO {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);

	int boardTotalCnt();

	int updateUpCnt(int bnum);

	int updateDownCnt(int bnum);

	int viewCntUp(String bnum);


}
