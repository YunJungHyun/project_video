package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.PagingVO;
import com.spring.vo.VideoVO;

@Repository
public class VideoDAOImpl implements VideoDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.spring.mapper.videoMapper";
	
	@Override 
	public int insertVideo(VideoVO videoVO) {
		int result = sqlSession.insert(Namespace+".insertVideo", videoVO);
	
		return result;
	}
	
	@Override
	public List<VideoVO> getAllList(PagingVO pagingVO) {
		
		//System.out.println(pagingVO.getStart() + "," + pagingVO.getEnd());
		//System.out.println("pagingVO.getCon() DAOImpl :" +pagingVO.getCon());
		List<VideoVO> list= sqlSession.selectList(Namespace+".getAllList" ,pagingVO);
		return list;
	}
	@Override
	public VideoVO getOneVideo(int vnum) {
		VideoVO videoVO = sqlSession.selectOne(Namespace+".getOneVideo" , vnum);
		return videoVO;
	}
	
	@Override
	public List<VideoVO> getMyVideo(PagingVO pagingVO) {
		
		
//		System.out.println("pagingVO.getUnum() :" +pagingVO.getUnum());
//		System.out.println("pagingVO.getStart() :" +pagingVO.getStart());
//		System.out.println("pagingVO.getUnum() :" +pagingVO.getEnd());
//		System.out.println("pagingVO.getCon() :" +pagingVO.getCon());
//		System.out.println("pagingVO.getGnum() :" +pagingVO.getGnum());
		List<VideoVO> result = sqlSession.selectList(Namespace+".getMyVideo", pagingVO);
		
		return result;
	}
	
	@Override
	public int myVideoUpdate(VideoVO videoVO) {
		
		
		int result = sqlSession.update(Namespace+".myVideoUpdate", videoVO);
		return result;
	}
	
	@Override
	public int videoDelete(String vnum) {
		
		int result =sqlSession.delete(Namespace+".videoDelete", vnum);
		return result;
	}
	
	@Override
	public List<VideoVO> getMyFavVideo(PagingVO pagingVO) {
	
		List<VideoVO> result =sqlSession.selectList(Namespace+".getMyFavVideo",pagingVO);
		return result;
	}
	
	@Override
	public List<VideoVO> getMyRecentlyVideo(PagingVO pagingVO) {
		List<VideoVO> result = sqlSession.selectList(Namespace+".getMyRecentlyVideo",pagingVO);
		return result;
	}
}
