package com.spring.dao;

import java.util.List;
import java.util.Map;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

public interface BoardDAO {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);

	int boardTotalCnt(String gnum);

	int updateUpCnt(int bnum);

	int updateDownCnt(int bnum);

	int viewCntUp(String bnum);

	VideoVO getFavlist(String favArray);

	int myBoardTotalCnt(String unum);
	


}
