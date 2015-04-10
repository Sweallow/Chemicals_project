package com.sc.chemical.dao;

import com.sc.chemical.model.CategoryArbitralResult;
import com.sc.common.dao.BaseDao;

public class CategoryArbitralResultDao extends BaseDao<CategoryArbitralResult>{

	@Override
	protected Class<?> getModelClass() {
		return CategoryArbitralResult.class;
	}

	@Override
	public String getTableName() {
		return "C_CATEGORYARBITRALRESULT";
	}
}
