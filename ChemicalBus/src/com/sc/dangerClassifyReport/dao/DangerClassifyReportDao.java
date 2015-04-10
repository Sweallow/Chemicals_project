package com.sc.dangerClassifyReport.dao;

import com.sc.common.dao.BaseDao;
import com.sc.dangerClassifyReport.model.DangerClassifyReport;

public class DangerClassifyReportDao extends BaseDao<DangerClassifyReport> {

	@Override
	protected Class<?> getModelClass() {
		return DangerClassifyReport.class;
	}

	@Override
	public String getTableName() {
		return "C_DANGER_CLASSIFY_REPORT";
	}

}
