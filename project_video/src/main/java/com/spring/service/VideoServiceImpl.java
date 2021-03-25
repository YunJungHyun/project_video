package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.VideoDAO;
import com.spring.vo.PagingVO;
import com.spring.vo.VideoVO;

@Service
public class VideoServiceImpl implements VideoService{
	
	@Inject
	VideoDAO videoDAO;
	
	@Override
	public int insertVideo(VideoVO videoVO) {
		// TODO Auto-generated method stub
		return videoDAO.insertVideo(videoVO);
	}
	
	@Override
	public List<VideoVO> getAllList(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return videoDAO.getAllList(pagingVO);
	}
	
	@Override
	public VideoVO getOneVideo(int vnum) {
		// TODO Auto-generated method stub
		return videoDAO.getOneVideo(vnum);
	}
	
	@Override
	public List<VideoVO> getMyVideo(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return videoDAO.getMyVideo(pagingVO);
	}
	
	@Override
	public int myVideoUpdate(VideoVO videoVO) {
		// TODO Auto-generated method stub
		return videoDAO.myVideoUpdate(videoVO);
	}
	
	@Override
	public int videoDelete(String vnum) {
		// TODO Auto-generated method stub
		return videoDAO.videoDelete(vnum);
	}
	
	@Override
	public List<VideoVO> getMyFavVideo(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return videoDAO.getMyFavVideo(pagingVO);
	}
	
	@Override
	public List<VideoVO> getMyRecentlyVideo(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return videoDAO.getMyRecentlyVideo(pagingVO);
	}
	
	@Override
	public int getMyVideoCnt(String unum) {
		// TODO Auto-generated method stub
		return videoDAO.getMyVideoCnt(unum);
	}
}
