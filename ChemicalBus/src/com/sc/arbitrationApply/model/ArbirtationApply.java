package com.sc.arbitrationApply.model;

import java.sql.Date;

public class ArbirtationApply {
		private String scid;//id
		private String executeDate;//受理日期
		private String projectNum;//受理编号
		private String applyCom;//申请单位
		private String executePeople;//经办人
		private String phone;//联系电话
		private String mobilePhone;//移动电话
		private String fax;//传真
		private String email;//电子邮箱
		private String createtabledate;//填表日期
		
		private String chnName;//化学品中文名称
		private String chnEngName;//化学品英文名称
		private String chnAlies;//化学品中文别名
		
		private String applydate;//申请日期
		private String authentication_institution;//鉴定机构
		private String authentication_project;//鉴定项目
		private String report_finish_date;//鉴定报告出具日期
		private String report_no;//鉴定报告编号
		private String authentication_result;//鉴定结果
		private String our_suggestion;//单位认为
		private String executePeopleqz;//经办人
		public String getExecutePeopleqz() {
			return executePeopleqz;
		}
		public void setExecutePeopleqz(String executePeopleqz) {
			this.executePeopleqz = executePeopleqz;
		}
		private String responsible_person;//单位负责人
		private String seal_date;//盖章日期
		
		private String instructions;//其他需要说明的事项
		private String file_count;//份附件
		private String filename;//附件名称
		private String acceptance_pepple;//受理人
		
		private String scshoworder;
		private String scstatus;//项目审核状态
		private String sccreatedate;
		
		private String theReason;//退回原因
		private String userName;//当前用户名称
		
		public String getTheReason() {
			return theReason;
		}
		public void setTheReason(String theReason) {
			this.theReason = theReason;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public String getExecuteDate() {
			return executeDate;
		}
		public void setExecuteDate(String executeDate) {
			this.executeDate = executeDate;
		}
		public String getProjectNum() {
			return projectNum;
		}
		public void setProjectNum(String projectNum) {
			this.projectNum = projectNum;
		}
		public String getFax() {
			return fax;
		}
		public void setFax(String fax) {
			this.fax = fax;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getCreatetabledate() {
			return createtabledate;
		}
		public void setCreatetabledate(String createtabledate) {
			this.createtabledate = createtabledate;
		}
		public String getChnName() {
			return chnName;
		}
		public void setChnName(String chnName) {
			this.chnName = chnName;
		}
		public String getChnEngName() {
			return chnEngName;
		}
		public void setChnEngName(String chnEngName) {
			this.chnEngName = chnEngName;
		}
		public String getChnAlies() {
			return chnAlies;
		}
		public void setChnAlies(String chnAlies) {
			this.chnAlies = chnAlies;
		}
		public String getApplydate() {
			return applydate;
		}
		public void setApplydate(String applydate) {
			this.applydate = applydate;
		}
		public String getAuthentication_institution() {
			return authentication_institution;
		}
		public void setAuthentication_institution(String authenticationInstitution) {
			authentication_institution = authenticationInstitution;
		}
		public String getAuthentication_project() {
			return authentication_project;
		}
		public void setAuthentication_project(String authenticationProject) {
			authentication_project = authenticationProject;
		}
		public String getReport_finish_date() {
			return report_finish_date;
		}
		public void setReport_finish_date(String reportFinishDate) {
			report_finish_date = reportFinishDate;
		}
		public String getReport_no() {
			return report_no;
		}
		public void setReport_no(String reportNo) {
			report_no = reportNo;
		}
		public String getAuthentication_result() {
			return authentication_result;
		}
		public void setAuthentication_result(String authenticationResult) {
			authentication_result = authenticationResult;
		}
		public String getOur_suggestion() {
			return our_suggestion;
		}
		public void setOur_suggestion(String ourSuggestion) {
			our_suggestion = ourSuggestion;
		}
		public String getResponsible_person() {
			return responsible_person;
		}
		public void setResponsible_person(String responsiblePerson) {
			responsible_person = responsiblePerson;
		}
		public String getSeal_date() {
			return seal_date;
		}
		public void setSeal_date(String sealDate) {
			seal_date = sealDate;
		}
		public String getInstructions() {
			return instructions;
		}
		public void setInstructions(String instructions) {
			this.instructions = instructions;
		}
		public String getFile_count() {
			return file_count;
		}
		public void setFile_count(String fileCount) {
			file_count = fileCount;
		}
		public String getFilename() {
			return filename;
		}
		public void setFilename(String filename) {
			this.filename = filename;
		}
		public String getAcceptance_pepple() {
			return acceptance_pepple;
		}
		public void setAcceptance_pepple(String acceptancePepple) {
			acceptance_pepple = acceptancePepple;
		}
		public String getScshoworder() {
			return scshoworder;
		}
		public void setScshoworder(String scshoworder) {
			this.scshoworder = scshoworder;
		}
		public String getScstatus() {
			return scstatus;
		}
		public void setScstatus(String scstatus) {
			this.scstatus = scstatus;
		}
		public String getSccreatedate() {
			return sccreatedate;
		}
		public void setSccreatedate(String sccreatedate) {
			this.sccreatedate = sccreatedate;
		}
		
		
		
		public String getScid() {
			return scid;
		}
		public void setScid(String scid) {
			this.scid = scid;
		}
		public String getApplyCom() {
			return applyCom;
		}
		public void setApplyCom(String applyCom) {
			this.applyCom = applyCom;
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
		public String getMobilePhone() {
			return mobilePhone;
		}
		public void setMobilePhone(String mobilePhone) {
			this.mobilePhone = mobilePhone;
		}
}
