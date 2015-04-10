package com.sc.report.model;

public class C_information {
	
	private String scid;
	private String Userd;//单位名称
	private String data1;//提审日期
	private String Chemical;//化学品名称
	private String date_acceptance;//受理日期
	private String Acceptance_number;//受理编号
	private String Opinions;//意见
	private String Contact;//联系人
	private String Telephone;//联系电话
	private String data2;//盖章日期
	private String Audit1;//审核人
	private String data3;//审核时间
	private String appScid;//关联C_DANGER_CLASSIFY_REPORT表的scid字段
	
	public String getAppScid() {
		return appScid;
	}
	public void setAppScid(String appScid) {
		this.appScid = appScid;
	}
	public String getAudit1() {
		return Audit1;
	}
	public void setAudit1(String audit1) {
		Audit1 = audit1;
	}
	public String getData3() {
		return data3;
	}
	public void setData3(String data3) {
		this.data3 = data3;
	}
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getUserd() {
		return Userd;
	}
	public void setUserd(String userd) {
		Userd = userd;
	}
	public String getData1() {
		return data1;
	}
	public void setData1(String data1) {
		this.data1 = data1;
	}
	public String getChemical() {
		return Chemical;
	}
	public void setChemical(String chemical) {
		Chemical = chemical;
	}
	public String getDate_acceptance() {
		return date_acceptance;
	}
	public void setDate_acceptance(String date_acceptance) {
		this.date_acceptance = date_acceptance;
	}
	public String getAcceptance_number() {
		return Acceptance_number;
	}
	public void setAcceptance_number(String acceptance_number) {
		Acceptance_number = acceptance_number;
	}
	public String getOpinions() {
		return Opinions;
	}
	public void setOpinions(String opinions) {
		Opinions = opinions;
	}
	public String getContact() {
		return Contact;
	}
	public void setContact(String contact) {
		Contact = contact;
	}
	public String getTelephone() {
		return Telephone;
	}
	public void setTelephone(String telephone) {
		Telephone = telephone;
	}
	public String getData2() {
		return data2;
	}
	public void setData2(String data2) {
		this.data2 = data2;
	}

}
