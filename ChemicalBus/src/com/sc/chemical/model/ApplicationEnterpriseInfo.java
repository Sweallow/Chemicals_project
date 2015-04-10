package com.sc.chemical.model;
/**
 * @author: Chenmin
 * @description:申请单位信息
 * @date:
 */
public class ApplicationEnterpriseInfo {
	private String scid;
	//单位名称
	private String enterpriseName;
	//地址
	private String adress;
	//邮编
	private String email;
	//经办人
	private String operator;
	//联系电话
	private String phone;
	//单位属性
	private String enterpriseAttribute;
	//鉴定个数
	private int appraisalNumber;
	//审核状态
	private String scStatus;
	//驳回原由
	private String theReason;
	//创建时间
	private String scCreatedate;
	
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public String getAdress() {
		return adress;
	}
	public void setAdress(String adress) {
		this.adress = adress;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEnterpriseAttribute() {
		return enterpriseAttribute;
	}
	public void setEnterpriseAttribute(String enterpriseAttribute) {
		this.enterpriseAttribute = enterpriseAttribute;
	}
	public int getAppraisalNumber() {
		return appraisalNumber;
	}
	public void setAppraisalNumber(int appraisalNumber) {
		this.appraisalNumber = appraisalNumber;
	}
	public String getScStatus() {
		return scStatus;
	}
	public void setScStatus(String scStatus) {
		this.scStatus = scStatus;
	}
	public String getTheReason() {
		return theReason;
	}
	public void setTheReason(String theReason) {
		this.theReason = theReason;
	}
	public String getScCreatedate() {
		return scCreatedate;
	}
	public void setScCreatedate(String scCreatedate) {
		this.scCreatedate = scCreatedate;
	}
	
}
