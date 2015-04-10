package com.sc.imp.dao;

import com.sc.common.dao.BaseDao;
import com.sc.imp.model.Sum;

public class SumDao extends BaseDao<Sum>{

	@Override
	protected Class<?> getModelClass() {
		return Sum.class;
	}
	@Override
	protected String getTableName() {
		return "C_SUM";
	}
}