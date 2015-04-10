package com.sc.chemical.model;

/**
 * @author: Chenmin
 * @description:鉴定结果通知书信息
 * @date:
 */
public class CategoryArbitralResult {
	private String scid;
	//受理时间
	private String appId;
	
	private String acceptTime;
	//会议时间
	private String meetingTime;
	//盖章时间
	private String abstempelnTime;
	//受理通知书编号
	private String acceptNumber;
	//申请单位
	private String applicationEnterprise;
	//鉴定结果
	private String arbitralResult;
	//参与的委员
	private String participant;
	//联系人
	private String contactPerson;
	//联系电话
	private String phone;
	
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAcceptTime() {
		return acceptTime;
	}
	public void setAcceptTime(String acceptTime) {
		this.acceptTime = acceptTime;
	}
	public String getMeetingTime() {
		return meetingTime;
	}
	public void setMeetingTime(String meetingTime) {
		this.meetingTime = meetingTime;
	}
	public String getAbstempelnTime() {
		return abstempelnTime;
	}
	public void setAbstempelnTime(String abstempelnTime) {
		this.abstempelnTime = abstempelnTime;
	}
	public String getAcceptNumber() {
		return acceptNumber;
	}
	public void setAcceptNumber(String acceptNumber) {
		this.acceptNumber = acceptNumber;
	}
	public String getApplicationEnterprise() {
		return applicationEnterprise;
	}
	public void setApplicationEnterprise(String applicationEnterprise) {
		this.applicationEnterprise = applicationEnterprise;
	}
	public String getArbitralResult() {
		return arbitralResult;
	}
	public void setArbitralResult(String arbitralResult) {
		this.arbitralResult = arbitralResult;
	}
	public String getParticipant() {
		return participant;
	}
	public void setParticipant(String participant) {
		this.participant = participant;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
