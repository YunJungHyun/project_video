package com.spring.vo;

public class BoardVO {
	
	private int bnum;
	private int vnum;
	private int unum;
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
	@Override
	public String toString() {
		return "BoardVO [bnum=" + bnum + ", vnum=" + vnum + ", unum=" + unum + "]";
	}
	
	
	
}
