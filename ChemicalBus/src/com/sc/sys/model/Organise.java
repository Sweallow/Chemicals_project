package com.sc.sys.model;
/**
 * 
 * @author luteng
 *
 */
public class Organise {
	private String scid;//主键
	private String orgname;//部门名称
	private String porgid;//父部门ID
	private String others;//备注
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getPorgid() {
		return porgid;
	}
	public void setPorgid(String porgid) {
		this.porgid = porgid;
	}
	public String getOthers() {
		return others;
	}
	public void setOthers(String others) {
		this.others = others;
	}
	
}
