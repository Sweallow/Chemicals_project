package com.sc.chemical.model;
/**
 * @author Chenmin
 * @说明:需要鉴定的化学品信息
 */
public class AppraisalInfo {
	private String scid;
	//序号
	private String numb;
	//化学品名称
	private String chemicalName;
	//鉴定机构名称
	private String appraisalOrganizationName;
	//鉴定报告签发日期
	private String reportIssuedDate;
	//鉴定类型
	private String appraisalType;
	//关联主表的字段
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
