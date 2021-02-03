package com.spring.dao;

import java.util.List;

import com.spring.vo.VideoVO;

public interface VideoDAO {

	int insertVideo(VideoVO videoVO);

	List<VideoVO> getAllList();

}
