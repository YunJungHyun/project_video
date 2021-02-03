package com.spring.service;

import java.util.List;

import com.spring.vo.VideoVO;

public interface VideoService {

	int insertVideo(VideoVO videoVO);

	List<VideoVO> getAllList();



	
}
