package com.sc.chemical.dao;

import com.sc.chemical.model.AppraisalInfo;
import com.sc.common.dao.BaseDao;

public class AppraisalInfoDao extends BaseDao<AppraisalInfo>{

	@Override
	protected Class<?> getModelClass() {
		return AppraisalInfo.class;
	}

	@Override
	public String getTableName() {
		return "C_APPRAISALINFO";
	}

}
