package com.sc.report.model;

public class C_examine {
	
	private String scid;	
	private String ID;//����֪ͨ������C_INFORMATION���scid�ֶ�
	private String risk_categories;//Σ�������
	private String classification_results;//������
	private String audit_opinion;//������
	private String remarks;//��ע
	
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getRisk_categories() {
		return risk_categories;
	}
	public void setRisk_categories(String risk_categories) {
		this.risk_categories = risk_categories;
	}
	public String getClassification_results() {
		return classification_results;
	}
	public void setClassification_results(String classification_results) {
		this.classification_results = classification_results;
	}
	public String getAudit_opinion() {
		return audit_opinion;
	}
	public void setAudit_opinion(String audit_opinion) {
		this.audit_opinion = audit_opinion;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
