package com.sc.chemical.model;

/**
 * @author: Chenmin
 * @description:�������֪ͨ����Ϣ
 * @date:
 */
public class CategoryArbitralResult {
	private String scid;
	//����ʱ��
	private String appId;
	
	private String acceptTime;
	//����ʱ��
	private String meetingTime;
	//����ʱ��
	private String abstempelnTime;
	//����֪ͨ����
	private String acceptNumber;
	//���뵥λ
	private String applicationEnterprise;
	//�������
	private String arbitralResult;
	//�����ίԱ
	private String participant;
	//��ϵ��
	private String contactPerson;
	//��ϵ�绰
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
