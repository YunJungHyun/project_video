package com.spring.dao;

import com.spring.vo.BoardVO;
import com.spring.vo.VideoVO;

public interface BoardDAO {

	int insertBoard(VideoVO videoVO);

	BoardVO getOneBoard(String vnum);

}
