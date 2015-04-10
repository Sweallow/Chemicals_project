package com.sc.sys.dao;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.Organise;

public class OrganiseDao extends BaseDao<Organise> {

	@Override
	protected Class<?> getModelClass() {
		return Organise.class;
	}

	@Override
	protected String getTableName() {
		return "SC_ORGANISE";
	}

}
