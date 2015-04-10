package com.sc.sys.dao;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.ParamType;

public class ParamTypeDao extends BaseDao<ParamType> {

	@Override
	protected Class<?> getModelClass() {
		return ParamType.class;
	}

	@Override
	protected String getTableName() {
		return "SC_PARAMTYPE";
	}

}
