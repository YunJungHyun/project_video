package com.spring.vo;

public class UserVO {

	private int unum;
	private String userid;
	private String userpw;
	private String uname;
	private String uemail;
	private String uphn;
	
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getUphn() {
		return uphn;
	}
	public void setUphn(String uphn) {
		this.uphn = uphn;
	}
	
	@Override
	public String toString() {
		return "UserVO [unum=" + unum + ", userid=" + userid + ", userpw=" + userpw + ", uname=" + uname + ", uemail="
				+ uemail + ", uphn=" + uphn + "]";
	}
	
	
}
