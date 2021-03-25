package com.spring.service;

import java.util.List;

import com.spring.vo.PagingVO;
import com.spring.vo.VideoVO;

public interface VideoService {

	int insertVideo(VideoVO videoVO);

	List<VideoVO> getAllList(PagingVO pagingVO);

	VideoVO getOneVideo(int vnum);

	List<VideoVO> getMyVideo(PagingVO pagingVO);

	int myVideoUpdate(VideoVO videoVO);

	int videoDelete(String vnum);

	List<VideoVO> getMyFavVideo(PagingVO pagingVO);

	List<VideoVO> getMyRecentlyVideo(PagingVO pagingVO);

	int getMyVideoCnt(String unum);
	
	
	


	
}
