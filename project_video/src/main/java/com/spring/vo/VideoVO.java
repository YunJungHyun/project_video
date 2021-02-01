package com.spring.vo;

public class VideoVO {

	private int vnum;
	private int unum;
	private String vurl;
	private String vthumimg;
	private String vpw;
	private String vtitle;
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
		return "VideoVO [vnum=" + vnum + ", unum=" + unum + ", vurl=" + vurl + ", vthumimg=" + vthumimg + ", vpw=" + vpw
				+ ", vtitle=" + vtitle + "]";
	}
	
	
}
