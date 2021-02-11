package com.spring.dao;

import java.util.List;

import com.spring.vo.PagingVO;
import com.spring.vo.VideoVO;

public interface VideoDAO {

	int insertVideo(VideoVO videoVO);

	List<VideoVO> getAllList(PagingVO pagingVO);

	VideoVO getOneVideo(int vnum);

	 

}
