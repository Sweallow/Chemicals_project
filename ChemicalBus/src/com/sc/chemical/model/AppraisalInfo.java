package com.sc.chemical.model;
/**
 * @author Chenmin
 * @˵��:��Ҫ�����Ļ�ѧƷ��Ϣ
 */
public class AppraisalInfo {
	private String scid;
	//���
	private String numb;
	//��ѧƷ����
	private String chemicalName;
	//������������
	private String appraisalOrganizationName;
	//��������ǩ������
	private String reportIssuedDate;
	//��������
	private String appraisalType;
	//����������ֶ�
	private String glid;
	
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public String getNumb() {
		return numb;
	}
	public void setNumb(String numb) {
		this.numb = numb;
	}
	public String getChemicalName() {
		return chemicalName;
	}
	public void setChemicalName(String chemicalName) {
		this.chemicalName = chemicalName;
	}
	public String getAppraisalOrganizationName() {
		return appraisalOrganizationName;
	}
	public void setAppraisalOrganizationName(String appraisalOrganizationName) {
		this.appraisalOrganizationName = appraisalOrganizationName;
	}
	public String getReportIssuedDate() {
		return reportIssuedDate;
	}
	public void setReportIssuedDate(String reportIssuedDate) {
		this.reportIssuedDate = reportIssuedDate;
	}
	public String getAppraisalType() {
		return appraisalType;
	}
	public void setAppraisalType(String appraisalType) {
		this.appraisalType = appraisalType;
	}
	public String getGlid() {
		return glid;
	}
	public void setGlid(String glid) {
		this.glid = glid;
	}
	
}
