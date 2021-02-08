package com.spring.vo;

public class ReplyVO {

	private int bnum;
	private int rnum;
	private int rpnum;
	private String replyText;
	private String replyer;
	
	public int getRpnum() {
		return rpnum;
	}
	public void setRpnum(int rpnum) {
		this.rpnum = rpnum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getReplyText() {
		return replyText;
	}
	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [bnum=" + bnum + ", rnum=" + rnum + ", rpnum=" + rpnum + ", replyText=" + replyText
				+ ", replyer=" + replyer + "]";
	}
	
	
	
}
