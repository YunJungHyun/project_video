package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.service.BoardService;
import com.spring.service.UserService;
import com.spring.service.VideoService;
import com.spring.vo.UserVO;
import com.spring.vo.VideoVO;

@Controller
public class VideoController {


	@Inject
	VideoService videoService;

	@Inject
	BoardService boardService;
	@Inject
	UserService userService;

	HttpSession session;

	private static final String encoding="UTF-8";
	private static final String path = "/";

	@RequestMapping(value="videoReg.do", method=RequestMethod.POST)
	@ResponseBody
	public String videoReg(
			VideoVO videoVO


			) {
		System.out.println("[videoReg.do]");
		
		System.out.println("videoID : " + videoVO.getVideoid());
		videoVO.setVthumimg("https://img.youtube.com/vi/"+videoVO.getVideoid()+"/mqdefault.jpg");
		videoService.insertVideo(videoVO);

		int result = boardService.insertBoard(videoVO); 

		if(result >= 1) {


			return "success";

		}else {
			return "fail";
		}


	}

	@RequestMapping(value="recentlyList.do" ,method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> recentlyList(
			@RequestParam(value="cookie" , required= false) String cookie
			) {
		System.out.println("[recentlyList.do]"); 
		System.out.println("cookie : "+cookie);
		
		List<VideoVO> list = new ArrayList<VideoVO>();
		
		String[] cArray= cookie.trim().split(",");

		for(int i = 0 ; i < cArray.length ;i++) {

			
			//System.out.println("cArray.length :"+cArray[i].length());
			int vnum =Integer.parseInt(cArray[i]);
			//System.out.println("vnum : "+ vnum);

			VideoVO videoVO= videoService.getOneVideo(vnum);

			list.add(videoVO);
		}
		//return map;

		Map<String,Object> map = new HashMap<String,Object>();
		Collections.reverse(list);


		//System.out.println("list.size() :"+list.size());
		map.put("mlist", list);
		
 
		return map;
	}

	@RequestMapping(value="myVideoUpdate.do")
	@ResponseBody
	public void myVideoUpdate(

			VideoVO videoVO,
			HttpSession session
			) {

		try {
			String vurl = URLDecoder.decode(videoVO.getVurl(),"UTF-8");
			String vtitle =  URLDecoder.decode(videoVO.getVtitle(),"UTF-8");
			String vpw =  URLDecoder.decode(videoVO.getVpw(),"UTF-8");

			videoVO.setVurl(vurl);
			videoVO.setVtitle(vtitle);
			videoVO.setVpw(vpw);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		UserVO gui = (UserVO) session.getAttribute("gui");

		videoVO.setUnum(gui.getUnum());

		int result = videoService.myVideoUpdate(videoVO);
		System.out.println("result : " +result);
		//boardService.myBoardUpdate(videoVO);

	}

	@RequestMapping(value="videoDelete.do")
	@ResponseBody
	public void videoDelete(
			@RequestParam(value="vnum" ,required=false) String vnum
			) {


		int resultVideo = videoService.videoDelete(vnum);
		int resultBoard = boardService.boardDelete(vnum);


		System.out.println("resultVideo : "+resultVideo);
		System.out.println("resultBoard : "+resultBoard);

	}

	@RequestMapping(value="setCookie.do")
	@ResponseBody
	public void  setCookie(
			@RequestParam(value="vnum", required =true) String vnum,
			HttpSession session ,
			HttpServletResponse response,
			HttpServletRequest request
			) throws UnsupportedEncodingException {

		System.out.println("[setCookie.do]");
		System.out.println("vnum :"+vnum);
		UserVO gui = (UserVO)session.getAttribute("gui");
		String userid = null;

		if(gui == null) {

			userid="none";
		}else {

			userid = gui.getUserid();
		}

		List<String> list = getValueList(userid, request);
		String sumValue = "";
		int equalsValueCnt = 0;

		if(list != null){
			for(int i=0; i<list.size(); i++){
				sumValue += list.get(i) + ",";
				if(list.get(i).equals(vnum)){
					equalsValueCnt++;
				}
			}
			if(equalsValueCnt != 0){ // 같은 값을 넣으려고 할 때의 처리
				System.out.println("sumValue : "+sumValue); 
				String newSumValue ="";
				
				System.out.println("sumValue.contains() :"+sumValue.contains(vnum+",") );
				if(sumValue.contains(vnum+",")) {
					
					sumValue=sumValue.replaceAll(vnum+"," ,"");
					System.out.println("sumValue result:" +sumValue); 
					sumValue+=vnum;
				}
				//System.out.println("sumValue result : "+sumValue );
				
			}else{
				sumValue += vnum;
			}
			
		}else{
			sumValue = vnum;
		}

		if(!sumValue.equals("")){
			Cookie cookie = new Cookie(userid, URLEncoder.encode(sumValue, encoding));
			cookie.setMaxAge(60*60*24*1);
			cookie.setPath(path);
			response.addCookie(cookie);
			System.out.println("쿠키등록");
		}
		
		String x =getValue(userid, request);
		//System.out.println("x : " +x );
	}
	
	public String getValue(String key, HttpServletRequest request) throws UnsupportedEncodingException {
		  Cookie cookie = (Cookie) getValueMap(request).get(key);
		  if (cookie == null) return null;
		  return URLDecoder.decode(cookie.getValue(), encoding);
		}

	
	public boolean isExist(String key, HttpServletRequest request) {
		//System.out.println("getValueMap(request).get(key) :" +getValueMap(request).get(key));
		return getValueMap(request).get(key) !=null;
	}

	public HashMap getValueMap(HttpServletRequest request) {

		HashMap cookieMap = new HashMap();

		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			System.out.println("cookies not Null : "+cookies.length);

			for(int i = 0; i < cookies.length; i++) {
				System.out.println("cookies[i].getName() : "+cookies[i].getName());
				cookieMap.put(cookies[i].getName(), cookies[i]);
			}
		}

		return cookieMap;
	}

	public List<String> getValueList(String key , HttpServletRequest request) throws UnsupportedEncodingException{
		// cookie 가 존재하는지 
		Cookie[] cookies = request.getCookies();
		// cookie value 
		String[] cookieValues= null;
		String value ="";
		List<String> list = null;

		if(cookies != null) {
			System.out.println("cookies.length :"+cookies.length );
			for(int i = 0 ; i <cookies.length ; i++) {

				if(cookies[i].getName().equals(key)) {
					value=cookies[i].getValue();
					cookieValues = (URLDecoder.decode(value,encoding)).split(",");
					break;
				}
			}
		}
		System.out.println("cookieValues : "+cookieValues);

		if(cookieValues != null) {

			list = new ArrayList<String>(Arrays.asList(cookieValues));
			if(list.size()>8) {
				int start = list.size() - 8;
				List<String> copyList = new ArrayList<String>();
				for (int i = start ; i < list.size() ; i++) {
					copyList.add(list.get(i));
				}
				list = copyList;
			}
		}
		//System.out.println("list : "+list.toString());
		return list;	
	}

}
