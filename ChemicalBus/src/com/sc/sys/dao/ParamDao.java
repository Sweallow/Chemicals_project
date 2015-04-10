package com.sc.sys.dao;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.Param;

public class ParamDao extends BaseDao<Param>{

	@Override
	protected Class<?> getModelClass() {
		return Param.class;
	}

	@Override
	protected String getTableName() {
		return "SC_PARAM";
	}

}
