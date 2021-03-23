package com.spring.vo;

public class VideoVO {

	private int vnum;
	private int unum;
	private String userid;
	private int bnum; 
	private int RN;
	private String gnum;
	private String vurl;
	private String vthumimg;
	private String vpw;
	private String vtitle;
	private String  videoid;
	
	
	private int upcnt;
	private int downcnt;
	private int viewcnt;
	
	

	public String getVideoid() {
		return videoid;
	}
	public void setVideoid(String videoid) {
		this.videoid = videoid;
	}
	public String getGnum() {
		return gnum;
	}
	public void setGnum(String gnum) {
		this.gnum = gnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getUpcnt() {
		return upcnt;
	}
	public void setUpcnt(int upcnt) {
		this.upcnt = upcnt;
	}
	public int getDowncnt() {
		return downcnt;
	}
	public void setDowncnt(int downcnt) {
		this.downcnt = downcnt;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getRN() {
		return RN;
	}
	public void setRN(int rN) {
		RN = rN;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getVnum() {
		return vnum;
	}
	public void setVnum(int vnum) {
		this.vnum = vnum;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public String getVurl() {
		return vurl;
	}
	public void setVurl(String vurl) {
		this.vurl = vurl;
	}
	public String getVthumimg() {
		return vthumimg;
	}
	public void setVthumimg(String vthumimg) {
		this.vthumimg = vthumimg;
	}
	public String getVpw() {
		return vpw;
	}
	public void setVpw(String vpw) {
		this.vpw = vpw;
	}
	public String getVtitle() {
		return vtitle;
	}
	public void setVtitle(String vtitle) {
		this.vtitle = vtitle;
	}
	
	
	@Override
	public String toString() {
		return "VideoVO [vnum=" + vnum + ", unum=" + unum + ", userid=" + userid + ", bnum=" + bnum + ", RN=" + RN
				+ ", gnum=" + gnum + ", vurl=" + vurl + ", vthumimg=" + vthumimg + ", vpw=" + vpw + ", vtitle=" + vtitle
				+ ", videoid=" + videoid + ", upcnt=" + upcnt + ", downcnt=" + downcnt + ", viewcnt=" + viewcnt + "]";
	}
	


	
	 
	
}
