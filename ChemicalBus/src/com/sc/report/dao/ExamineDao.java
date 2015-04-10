package com.sc.report.dao;

import com.sc.common.dao.BaseDao;
import com.sc.report.model.C_examine;

public class ExamineDao  extends BaseDao<C_examine> {

	@Override
	protected Class<?> getModelClass() {
		return C_examine.class;
	}

	@Override
	protected String getTableName() {
		return "C_EXAMINE";
	}

}
