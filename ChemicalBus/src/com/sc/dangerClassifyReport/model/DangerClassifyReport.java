package com.sc.dangerClassifyReport.model;

public class DangerClassifyReport {
	
	private String scid;
	private String unit_name;//单位名称
	private String unit_property;//单位属性
	private String executePeople;//经办人
	private String phone;//电话
	private String email;//邮箱
	private String chemist_name;//化学品名称
	private String repport_no;//报告编号
	private String scstatus;//审核状态
	private String back_reason;//驳回原由
	
	public String getScstatus() {
		return scstatus;
	}

	public void setScstatus(String scstatus) {
		this.scstatus = scstatus;
	}

	public String getRepport_no() {
		return repport_no;
	}

	public void setRepport_no(String repport_no) {
		this.repport_no = repport_no;
	}

	public String getBack_reason() {
		return back_reason;
	}

	public void setBack_reason(String back_reason) {
		this.back_reason = back_reason;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getChemist_name() {
		return chemist_name;
	}

	public void setChemist_name(String chemist_name) {
		this.chemist_name = chemist_name;
	}

	public String getScid() {
		return scid;
	}

	public void setScid(String scid) {
		this.scid = scid;
	}

	public String getUnit_name() {
		return unit_name;
	}

	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}

	public String getUnit_property() {
		return unit_property;
	}

	public void setUnit_property(String unit_property) {
		this.unit_property = unit_property;
	}

	public String getExecutePeople() {
		return executePeople;
	}

	public void setExecutePeople(String executePeople) {
		this.executePeople = executePeople;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}
