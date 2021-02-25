package com.spring.service;

import com.spring.vo.BoardVO;
import com.spring.vo.UserVO;
import com.spring.vo.VideoVO;

public interface BoardService {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);

	int boardTotalCnt(String gnum);
 
	int updateUpCnt(int bnum);

	int updateDownCnt(int bnum);

	int viewCntUp(String bnum);

	VideoVO getFavlist(String favArray);

	int myBoardTotalCnt(String unum);

	int boardDelete(String vnum);


	
}
